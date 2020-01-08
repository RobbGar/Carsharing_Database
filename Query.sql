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

		--c. 
		
--3 Query complesse

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
	 
	 
