--0 Vista Fatturazione

Create view Fatturazione as
    select codp, prezzo from prenotazioni where oraeffettivaric is not null;

--1 Alcune (almeno tre) interrogazioni semplici (= di gestione) per ogni porzione coperta (comune, a scelta)

	--Porzione comune

		--a. Selezionare il parcheggio con più auto con seggiolini

		select parcheggio, count(*) as max
		from veicoli
		where qtaseggiolini is not null
		group by parcheggio
		ORDER BY max desc
		limit 1;

		--b. Selezionare le vetture non prenotate con un abbonamento annuale

		Select distinct veicolo from prenotazioni
		except
		select targa from veicoli where targa in(
			select distinct veicolo from prenotazioni inner join utente on prenotazioni.codu = utente.codu inner join storicoabbonamenti on utente.codu = storicoabbonamenti.codu
			where storicoabbonamenti.coda = 5
		);

		--c. selezionare le auto che accettano animali a bordo e gli utenti che le hanno eventualmente prenotate

		select targa, codu
		from veicoli left outer join prenotazioni  on prenotazioni.veicolo = targa
		where animali = true;

	--Porzione A scelta

		--a. Selezionare i dipendenti di aziende che hanno prenotato una opel

		select distinct conducenti.codf
		from conducenti inner join prenotazioni on conducenti.codf = prenotazioni.codf inner join veicoli v on prenotazioni.veicolo = v.targa inner join modelli m on v.modello = m.codm
        where m.produttore = 'Opel' and azienda is not null;
		
		--b. selezionare gli utenti che hanno prenotato con carta di credito sul parcheggio con piu posti

		select prenotazioni.codu
        from prenotazioni inner join utente u on prenotazioni.codu = u.codu inner join modalitapagamento m on u.codmp = m.codmp inner join parcheggi p on prenotazioni.codp = p.codp
        where m.cc is not null and numposti = (
		    select max(numposti)
            from parcheggi);

		--c. Selezionare gli utenti con più di 25 anni che hanno prenotato nell'ultimo mese
		
		select c.codf, nome, cognome
		from prenotazioni inner join privato c on prenotazioni.codu = c.codu
		where (current_timestamp - oraprenotazione) < make_interval(days := 30) and age(datan) >= make_interval(25)
	
--2. Operazioni di manipolazione
		
	--Porzione comune
		
		--a.Sconto natalizio del 10% sugli abbonamenti
			UPDATE abbonamenti SET costo = costo * 0.9
			
		--b. cancellazione dei modelli senza vetture disponibili
			DELETE from modelli where codm not in (select modello from veicoli);
		
		--c. inserimento 
		
	--Porzione a scelta
		
		--a. dimezza il pre-pag a chi non ha più un abbonamento valido. così. per pura cattiveria.
			update modalitapagamento set prepag = prepag / 2 where codmp in (select codmp from utente where valabb(codu)=0);
			
		
		--b. cancellazione dei conducenti che non hanno guidato nell'ultimo anno
			delete from conducenti where codf not in (select codf from prenotazioni where oraprenotazione-current_timestamp < make_interval(years := 1));	
			
		--c. inserimento 
		
		
--3 Query di analisi
	
	--Porzione comune
		--a. determinare gli utenti che hanno utilizzato almeno una volta tutte le vetture in un determinato parcheggio
		--usiamo le funzioni di gruppo per esprimere la divisione
		Select codu
		from prenotazioni inner join veicoli v on prenotazioni.veicolo = v.targa
		where codp = 3
		group by codu
		having count(distinct (veicolo)) = (SELECT count(*)
											FROM parcheggi inner join veicoli v2 on parcheggi.codp = v2.parcheggio
											WHERE parcheggi.codp = 3
											group by parcheggi.codp);
									
									
		--b. determinare la categoria di veicolo noleggiati più volte negli ultimi 6 mesi
		select cat
		from prenotazioni inner join veicoli v1 on prenotazioni.veicolo = v1.targa inner join modelli m1 on v1.modello = m1.codm
		where age(current_timestamp, oraprenotazione) < make_interval(months := 6)
		group by cat
		having count(*) = (
			select max(bb)
			from (select distinct m.cat, count(*) as bb
				from prenotazioni
						inner join veicoli v on prenotazioni.veicolo = v.targa
                     inner join modelli m on v.modello = m.codm
				where age(current_timestamp, oraprenotazione) < make_interval(months := 6)
              group by m.cat

            ) as cc)
			
		--c. determinare il numero di ore che sono state noleggiate le auto nel parcheggio 1

		select sum(bb) as temponoleggio
		from (
			select (oraeffettivaric-oraeffettivaritiro) as bb, targa
			from prenotazioni inner join veicoli v on prenotazioni.veicolo = v.targa
			where parcheggio = 1 and oraeffettivaric is not null
			group by targa, (oraeffettivaric-oraeffettivaritiro)
        )
        as cc
	
	
	--Porzione a scelta
	
		--a. selezionare il privato con l'età minore che non ha effettuato prenotazioni
		select codf
		from privato
		where (current_date - datan)= (select min(age)
		from (
			select codf, ((current_date - datan)) as age
			from privato
				except
			select p2.codf, ((current_date - datan)) as ages
			from prenotazioni inner join privato p2 on prenotazioni.codu = p2.codu
		)as tbb);
		
		--b. determinare l'azienda i cui dipendenti hanno noleggiato piu macchine
		--funzione che ritorna il numero di dipendenti che hanno effettuato piu noleggi
		create function maxdipendenti() returns integer
		language plpgsql
		as
		$$
			DECLARE var integer;  BEGIN  SELECT INTO var max(num) FROM (select count(*) as num from prenotazioni inner join aziende a on prenotazioni.codu = a.codu group by a.codu) as bb ; RETURN var; END;
		$$;

        select p.codu as cod, ragionesociale, count(*) as numerodipendenti
        from aziende inner join prenotazioni p on aziende.codu = p.codu
        group by p.codu, ragionesociale
        having count(*) = maxdipendenti()
	 
		--c. 