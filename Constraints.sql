set search_path to 'carsharing';

--0 Coerenza durata abbonamenti
CREATE OR REPLACE FUNCTION controllo_fine_abbonamento() RETURNS trigger AS $controllo_fine_abbonamento$ BEGIN
IF (SELECT durata from abbonamenti Where coda = new.coda and new.dataf is not null) <>  make_interval (days => (new.dataf - new.datai))
THEN RAISE EXCEPTION '%Data di fine abbonamento non coincide ', NEW.dataf;
ELSE RETURN NEW;
END IF; END; $controllo_fine_abbonamento$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_fine_abbonamento BEFORE INSERT OR UPDATE ON storicoabbonamenti FOR EACH ROW EXECUTE PROCEDURE controllo_fine_abbonamento();

--1 Un utente può avere più abbonamenti, ma solo uno di essi può essere valido.


--Funzione che ritorna quanti abbonamenti validi ha un utente
CREATE OR REPLACE FUNCTION valabb ( IN cod Integer )
RETURNS Integer   
AS $$  DECLARE var integer;  BEGIN  SELECT INTO var count(*) FROM storicoabbonamenti WHERE current_date BETWEEN datai and dataf and codu=cod; RETURN var; END; $$  LANGUAGE plpgsql ;


ALTER TABLE storicoabbonamenti ADD CONSTRAINT val CHECK (1>= valabb(codu));


--2 Una prenotazione può essere effettuata solo da un utente con un abbonamento valido.

ALTER TABLE prenotazioni ADD CONSTRAINT abbonamentovalido CHECK (1 = valabb(codu));

--3 La data di ritiro della vettura deve essere successiva o contemporanea alla data di inizio dell'abbonamento.

CREATE OR REPLACE FUNCTION dopo_abbonamento() RETURNS trigger AS $dopo_abbonamento$ BEGIN
IF ((SELECT datai FROM storicoabbonamenti WHERE codu = NEW.codu AND dataf is null)-DATE(NEW.dataoraritiro))  >0
THEN RAISE EXCEPTION '%Il ritiro deve essere successivo alla data di inizo abbonamento ', NEW.codu;
ELSE RETURN NEW;
END IF; END; $dopo_abbonamento$ LANGUAGE plpgsql;

CREATE TRIGGER ritiro_abbonamento BEFORE INSERT OR UPDATE ON Prenotazioni FOR EACH ROW EXECUTE PROCEDURE dopo_abbonamento();


--4 L'ora di ritiro della vettura deve essere di almeno 15 minuti successiva all'ora dell'inserimento della prenotazione.

ALTER TABLE Prenotazioni ADD CONSTRAINT almeno15min check ((dataoraritiro - oraprenotazione) >=  make_interval(mins := 15));

-- 5 Il conducente addizionale associato a privato deve avere lo stesso indirizzo di residenza del privato a cui sono associati.;

CREATE OR REPLACE FUNCTION controllo_indirizzo() RETURNS trigger AS $controllo_indirizzo$ BEGIN
IF (SELECT indirizzo FROM privato WHERE codu=NEW.utente) <> NEW.indirizzo
THEN RAISE EXCEPTION '%Il conducente addizionale associato ad un privato deve avere lo stesso indirizzo di quest ultimo ', NEW.indirizzo;
ELSE RETURN NEW;
END IF; END; $controllo_indirizzo$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_indirizzo BEFORE INSERT OR UPDATE ON Conducenti FOR EACH ROW EXECUTE PROCEDURE controllo_indirizzo();


--6 Ogni utente deve avere almeno un metodo di pagamento 
--Per costruzione della tabella

--7 Se si sceglie come modalità di pagamento il pre-pagamento, l'ammontare deve essere strettamente maggiore di 0 e il residuo coerente con quanto speso per abbonamenti e  prenotazioni.

ALTER TABLE modalitapagamento ADD CONSTRAINT Controllo_prepagamento CHECK (prepag>0 OR prepag IS NULL);

--8 Utenti diversi possono usare la stessa modalità di pagamento solo se essa non è di tipo pre-pagamento/contanti.
--Per costruzione della tabella


--9 Una carta di credito può essere utilizzata per un pagamento solo entro la data di scadenza (la data di scadenza deve essere successiva alla data di acquisto dell'abbonamento e alla data di riconsegna di ogni prenotazione).


CREATE OR REPLACE FUNCTION controllo_carta() RETURNS trigger AS $controllo_carta$ BEGIN
IF ((SELECT datas FROM CC INNER JOIN modalitapagamento on CC = CC INNER JOIN utente on codu=new.codu and utente.codmp = modalitapagamento.codmp WHERE new.tipopagamento= 'CC')<new.datapagamento)
THEN RAISE EXCEPTION '%carta scaduta', NEW.codu;
ELSE RETURN NEW;
END IF; END; $controllo_carta$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_carta_abbonamento BEFORE INSERT OR UPDATE ON storicoabbonamenti FOR EACH ROW EXECUTE PROCEDURE controllo_carta();

CREATE TRIGGER controllo_carta_prenotazione BEFORE INSERT OR UPDATE ON prenotazioni FOR EACH ROW EXECUTE PROCEDURE controllo_carta();
--10 Il numero di vetture presenti in un parcheggio non deve mai eccedere il numero posti dello stesso.

CREATE OR REPLACE FUNCTION controllo_numerovetture() RETURNS trigger AS $controllo_numerovetture$ BEGIN
IF (SELECT count(*) FROM veicoli WHERE parcheggio = NEW.parcheggio)>=(SELECT numposti FROM parcheggi WHERE codP = new.parcheggio)
THEN RAISE EXCEPTION '%posti esauriti in quel parcheggio', NEW.parcheggio;
ELSE RETURN NEW;
END IF; END; $controllo_numerovetture$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_numerovetture BEFORE INSERT OR UPDATE ON veicoli FOR EACH ROW EXECUTE PROCEDURE controllo_numerovetture();

--11 Un parcheggio non deve contenere veicoli di una categoria che non può ospitare.

CREATE OR REPLACE FUNCTION controllo_categoriavetture() RETURNS trigger AS $controllo_categoriavetture$ BEGIN
IF (SELECT cat FROM modelli WHERE codm = new.modello) NOT IN (SELECT nomecategoria from ammette where codp = new.parcheggio )
THEN RAISE EXCEPTION '%Categoria non accettata dal parcheggio', NEW.modello;
ELSE RETURN NEW;
END IF; END; $controllo_categoriavetture$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_categorievetture BEFORE INSERT OR UPDATE ON veicoli FOR EACH ROW EXECUTE PROCEDURE controllo_categoriavetture();


--12 Due utilizzi (e prenotazioni) della stessa auto non si possono temporalmente sovrapporre.

CREATE OR REPLACE FUNCTION controllo_autoprenotazioni() RETURNS trigger AS $controllo_autoprenotazioni$ BEGIN
IF (SELECT count(*) FROM prenotazioni where new.veicolo = veicolo and ((new.dataoraritiro BETWEEN dataoraritiro AND dataoraric) OR (new.dataoraric BETWEEN dataoraritiro AND dataoraric)))>0
THEN RAISE EXCEPTION '%Due utilizzi (e prenotazioni) della stessa auto non si possono temporalmente sovrapporre', NEW.parcheggio;
ELSE RETURN NEW;
END IF; END; $controllo_autoprenotazioni$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_autoprenotazioni BEFORE INSERT OR UPDATE ON prenotazioni FOR EACH ROW EXECUTE PROCEDURE controllo_autoprenotazioni();

--Un utente non può avere più di un conducente addizionale

CREATE OR REPLACE FUNCTION controllo_numeroconducenti() RETURNS trigger AS $controllo_numeroconducenti$ BEGIN
IF (Select count(*) from conducenti where utente = new.utente) = 2
THEN RAISE EXCEPTION '%Un utente può avere solo un conducente addizionale', NEW.utente;
ELSE RETURN NEW;
END IF; END; $controllo_numeroconducenti$ LANGUAGE plpgsql;

CREATE TRIGGER controllo_numeroconducenti BEFORE INSERT OR UPDATE ON conducenti FOR EACH ROW EXECUTE PROCEDURE controllo_numeroconducenti();


--14 Data e ora di ritiro in prenotazione devono essere precedenti alla data e ora di consegna.

ALTER TABLE prenotazioni ADD CONSTRAINT valid_rit_ric CHECK (dataoraritiro<dataoraric);

--15 Data e ora di ritiro in effettivi utilizzi devono essere precedenti alla data e ora di consegna e successivi alla data e ora di ritiro di prenotazione.

ALTER TABLE prenotazioni ADD CONSTRAINT valid_riteff_riceff CHECK (oraeffettivaritiro<dataoraric and oraeffettivaritiro>dataoraritiro);

--18 I km alla consegna degli effettivi utilizzi delle prenotazioni devono essere strettamente superiori ai km al ritiro.

ALTER TABLE prenotazioni ADD CONSTRAINT km_validi_prenot CHECK (kmritiro<kmriconsegna);

--19 Nel caso di prenotazioni in cui data di ritiro e data di consegna coincidono, il prezzo deve essere uguale a (tariffa oraria)*(ore prenotate) + (tariffa chilometrica)*(chilometri effettivamente percorsi) se non è attivo il bonus di rottamazione.

--20 Nel caso di prenotazioni in cui data di ritiro e data di consegna non coincidono e la differenza tra le due è, al massimo, sette giorni, se  è attivo il bonus di rottamazione il prezzo deve essere uguale: (tariffa chilometrica)*(chilometri effettivamente percorsi).

--21 Nel caso di prenotazioni in cui data di ritiro e data di consegna non coincidono e la differenza tra le due è, al massimo, sette giorni, il  prezzo deve essere uguale a (tariffa giornaliera)*(giorni prenotati) + (tariffa chilometrica)*(chilometri effettivamente percorsi), se non è attivo il bonus di rottamazione.

--22 Nel caso di prenotazioni in cui data di ritiro e data di consegna non coincidono e la differenza tra le due è strettamente superiore a  sette giorni, il prezzo deve essere uguale a (tariffa settimanale) + (tariffa giorno aggiuntivo)*((giorni prenotati) – 7).
--------------------calcolo_prezzo: funzione "esterna al trigger" che calcola il valore di prezzo

-------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION calcolo_prezzo (codp integer, utente integer, kmritiro numeric,kmriconsegna numeric, oraeffettivaritiro timestamp, oraeffettivaric timestamp, veicolo char(7))
RETURNS numeric
AS $calcolo_prezzo$ 
DECLARE 	
		tar1 numeric (8,2); --tar1: tariffa kilometrica
		tar2 numeric(8,2); --tar2: tariffe temporali
		prezzokm numeric(8,2); --salveremo il prezzo dei soli km in questa variabile
BEGIN
	SELECT INTO tar1 kilmetrica FROM tariffe WHERE codm=(SELECT modello from veicoli where veicolo=targa);
	prezzokm=tar1*(kmriconsegna-kmritiro); --tar1=tariffa kilometrica
	IF (SELECT bonus FROM privato WHERE codu=utente AND DATE_PART('day', oraeffettivaric-oraeffettivaritiro)<7)
		THEN	RETURN prezzokm; --tariffa rottamazione: solo kilometri
	ELSIF(DATE_PART('day', oraeffettivaric-oraeffettivaritiro)=0) --tariffa oraria
		THEN 	SELECT INTO tar2 oraria FROM tariffe WHERE codm=(SELECT modello from veicoli where veicolo=targa);
			RETURN prezzokm+tar2*(DATE_PART('hour', oraeffettivaric-oraeffettivaritiro));
	ELSIF(DATE_PART('day', oraeffettivaric-oraeffettivaritiro)<7) --tariffa giornaliera
		THEN 	SELECT INTO tar2 giornaliera FROM tariffe WHERE codm=(SELECT modello from veicoli where veicolo=targa);
			RETURN prezzokm+tar2*(DATE_PART('day', oraeffettivaric-oraeffettivaritiro));
	ELSE 	SELECT settimanale, giornaliera INTO tar1, tar2 FROM tariffe WHERE codm=(SELECT modello from veicoli where veicolo=targa); --tariffa settimanale
		RETURN tar1+tar2*(DATE_PART('day', oraeffettivaric-oraeffettivaritiro)-7);
		--tar1 usata come tariffa settimanale in questo caso per semplicità
END IF;
RETURN -1;
END;
$calcolo_prezzo$ LANGUAGE plpgsql;

--------------calcolo_prezzo_trigg(): funzione trigger che chiama calcolo-prezzo()

CREATE OR REPLACE FUNCTION calcolo_prezzo_trigg()
RETURNS TRIGGER 
SECURITY DEFINER
AS $calcolo_prezzo_t$
BEGIN 
	NEW.prezzo=calcolo_prezzo(NEW.codp, NEW.codu, NEW.kmritiro,NEW.kmriconsegna,NEW.oraeffettivaritiro,NEW.oraeffettivaric, NEW.veicolo); --chiamo un'altra funzione per il calcolo del prezzo
RETURN NEW;
END;
$calcolo_prezzo_t$ LANGUAGE plpgsql;

---------------- prezzotrigger: trigger per gli inserimenti di tuple in 'prenotazioni'

CREATE TRIGGER prezzotrigger
BEFORE INSERT OR UPDATE ON prenotazioni
FOR EACH ROW EXECUTE PROCEDURE 

	calcolo_prezzo_trigg();
--28 Se un utente privato ha meno di 26 anni, il prezzo viene ridotto della percentuale prevista.

CREATE FUNCTION number28()
RETURNS trigger
AS $number28$
BEGIN

		UPDATE Prenotazioni SET prezzo=prezzo/1.25
	WHERE prenotazioni.codu=NEW.codu AND NEW.codu IN (SELECT CodU FROM Utente Natural JOIN Privato  WHERE make_interval(years := (CURRENT_DATE-DataN))< INTERVAL'26' YEAR);
	RETURN NEW;


END;
$number28$ LANGUAGE plpgsql;

CREATE TRIGGER number28 AFTER INSERT ON Prenotazioni FOR EACH ROW EXECUTE PROCEDURE number28();
--29 Per gli utenti che scelgono come modalità di pagamento la carta di credito, la data di scadenza deve essere successiva alla data del pagamento dell'abbonamento.
--gia fatto
--30 Per gli utenti che scelgono come modalità di pagamento la carta di credito, la data di scadenza deve essere successiva alla data del pagamento della prenotazione. 
--gia fatto
-- 32 Le date di rilascio e scadenza dei documenti e le date di nascita degli utenti devono essere temporalmente coerenti.

CREATE OR REPLACE FUNCTION controllo_documenti() RETURNS trigger AS $controllo_documenti$ 
DECLARE
d date;
BEGIN
select datan into d From privato where codu = new.utente;
IF d > new.datasdoc OR d > new.datardoc
THEN RAISE EXCEPTION '%Le date di scadenza e rilascio dei documenti devono essere temporalmente corrette ', new.datasdoc;
ELSE RETURN NEW;
END IF; END; $controllo_documenti$ LANGUAGE plpgsql;
