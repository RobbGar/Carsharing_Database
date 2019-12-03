
create table cc
(
    codCC serial not null primary key,
	numero numeric(16) not null,
	datas date not null,
	intestatario varchar(40) not null,
	circuito varchar(20) not null,
	constraint cc_numero_datas_circuito_key
		unique(numero, datas, circuito)
);

create table rid
(
	codRid serial not null primary key ,
	intestatario varchar(40) not null,
	coordinate varchar(27) not null
);
create table modalitapagamento
(
	CodMP serial primary key,
	prepag numeric(6,2),
	cc integer references cc on update cascade on delete no action,
	rid integer references rid on update cascade on delete no action,
    Check (prepag is not null or cc is not null or rid is not null)
);

create table utente
(
	codu serial not null
		constraint utente_pkey
			primary key,
	codmp integer not null references modalitapagamento
);


create table privato
(
	codu integer not null
		constraint privato_pkey
			primary key
		constraint privato_codu_fkey
			references utente
				on update cascade,
	codf varchar(16) not null
		constraint privato_codf_key
			unique,
	email varchar(32) not null
		constraint privato_email_key
			unique,
	nome varchar(20) not null,
	cognome varchar(20) not null,
	datan date not null,
	luogon varchar(20) not null,
	genere char not null check ( genere = 'M' or genere = 'F' ),
	professione varchar(20) not null,
	bonus boolean,
	indirizzo varchar(40) not null
);


create table telefoni
(
	ntelefono numeric(10) not null
		constraint telefoni_pkey
			primary key,
	utente integer not null
		constraint telefoni_utente_fkey
			references privato
				on update cascade on delete no action
);



create table legali
(
	codl serial not null
		constraint legali_pkey
			primary key,
	nome varchar(20) not null,
	cognome varchar(20) not null,
	datan date not null,
	luogon varchar(20) not null
);

create table aziende
(
	codu integer not null
		constraint aziende_pkey
			primary key
		constraint aziende_codu_fkey
			references utente
				on update cascade,
	piva numeric(11) not null
		constraint aziende_piva_key
			unique,
	email varchar(32) not null
		constraint aziende_email_key
			unique,
	telefono numeric(10) not null,
	ragionesociale varchar(32) not null,
	sedelegale varchar(32) not null,
	settore varchar(20) not null,
	nomer varchar(20) not null,
	cognomer varchar(20) not null,
	telr numeric(10) not null,
	sedeop varchar(32),
	legale integer not null
		constraint aziende_legale_fkey
			references legali
				on update cascade on delete no action
);

create table conducenti
(
	codf varchar(16) not null
		constraint conducenti_pkey
			primary key,
	estremidoc varchar(9) not null
		constraint conducenti_estremidoc_key
			unique,
	estremipat varchar(10) not null
		constraint conducenti_estremipat_key
			unique,
	catpat char(2) not null,
	utente integer
		constraint conducenti_utente_fkey
			references privato
				on update cascade on delete no action,
	azienda integer
		constraint conducenti_azienda_fkey
			references aziende
				on update cascade on delete no action,
	indirizzo varchar(40) not null,
	datasdoc date,
	datardoc date,
	CHECK ((utente is null and azienda is not null) or (utente is not null and azienda is null)),
	CHECK (datasdoc>datardoc)
);






create table abbonamenti
(
	coda serial not null
		constraint abbonamenti_pkey
			primary key,
	durata interval not null,
	costo numeric(6,2) not null
);

create table storicoabbonamenti
(
	codu integer not null
		constraint storicoabbonamenti_codu_fkey
			references utente
				on update cascade on delete no action,
	datai date not null,
	dataf date,
	coda integer
		constraint storicoabbonamenti_coda_fkey
			references abbonamenti
				on update cascade on delete no action,
	datapagamento date,
	tipopagamento varchar(7) not null CHECK (tipopagamento='CC' OR tipopagamento='RID' OR tipopagamento = 'PREPAG'),
	constraint storicoabbonamenti_pkey
		primary key (codu, datai)
);


create table modelli
(
	codm serial not null
		constraint modelli_pkey
			primary key,
	cilindrata numeric(4) not null,
	cvkm numeric(4,1) not null,
	nporte numeric(1) not null,
	consumo numeric(4,1) not null,
	vmax numeric(3) not null,
	nposti numeric(1) not null,
	servosterzo boolean not null,
	ac boolean not null,
	airbag boolean not null,
	nome varchar(20) not null,
	produttore varchar(20) not null,
	altezza numeric(3) not null,
	lunghezza numeric(3) not null,
	larghezza numeric(3) not null,
	bagagliaio numeric(4) not null,
	cat varchar(9) not null check (cat = 'City Car' OR cat = 'Elettrico' or cat = 'Media' OR cat = 'Cargo' OR cat = 'Comfort')
);


create table tariffe
(
	codm integer not null
		constraint tariffe_pkey
			primary key
		constraint tariffe_codm_fkey
			references modelli
				on update cascade on delete no action,
	oraria numeric(4,2) not null,
	kilmetrica numeric(5,2) not null,
	settimanale numeric(6,2) not null,
	giornaliera numeric(5,2) not null
);

create table parcheggi
(
	codp serial not null
		constraint parcheggi_pkey
			primary key,
	lat varchar(12) not null,
	long varchar(12) not null,
	nome varchar(20) not null,
	indirizzo varchar(30) not null,
	zona varchar(20) not null,
	numposti numeric(4) not null,
	constraint latlong
		unique (lat, long)
);


create table veicoli
(
	targa varchar(7) not null
		constraint veicoli_pkey
			primary key,
	nome varchar(20) not null,
	km numeric(8,2) not null,
	colore varchar(10) not null,
	pincc numeric(5) not null,
	qtaseggiolini numeric(1),
	animali boolean not null,
	Modello integer
		constraint "veicoli_Modello_fkey"
			references modelli
				on update cascade,
	Parcheggio integer
		constraint "veicoli_Parcheggio_fkey"
			references parcheggi
				on update cascade
);


create table prenotazioni
(
	codp serial not null
		constraint prenotazioni_pkey
			primary key,
	utente integer
		constraint prenotazioni_utente_fkey
			references utente
				on update cascade on delete no action,
	dataoraritiro timestamp not null,
	dataoraric timestamp not null,
	kmritiro numeric(8,2),
	kmriconsegna numeric(8,2),
	oraeffettivaritiro timestamp,
	oraeffettivaric timestamp,
	veicolo varchar(7) not null
		constraint prenotazioni_veicolo_fkey
			references veicoli
				on update cascade on delete no action,
	oraprenotazione timestamp not null,
	dataoraannullamento timestamp,
	datapagamento timestamp,
	tipopagamento varchar(7) Not null CHECK (tipopagamento='CC' OR tipopagamento='RID' OR tipopagamento = 'PREPAG'),
	prezzo numeric(8,2)
);


create table rifornimenti
(
	targa varchar(7) not null
		constraint rifornimenti_pkey
			primary key
		constraint rifornimenti_veicoli_targa_fk
			references veicoli,
	kmpercorsi numeric(8,2) not null,
	ltcarburante numeric(4,1) not null,
	prenotazione integer
		constraint rifornimenti_prenotazione_fkey
			references prenotazioni
);





create table ammette
(
	codp integer not null
		constraint ammette_codp_fkey
			references parcheggi
				on update cascade on delete no action,
	nomecategoria varchar(20),
	primary key (codp, nomecategoria),
	check (nomecategoria = 'City Car' OR nomecategoria = 'Elettrico' or nomecategoria = 'Media' OR nomecategoria = 'Cargo' OR nomecategoria = 'Comfort')
);


create table incidenti
(
	conducente varchar(16) not null
		constraint incidenti_pkey
			primary key
		constraint incidenti_conducente_fkey
			references conducenti,
	dataora timestamp not null,
	descrdinamica varchar(150) not null,
	luogo varchar(40) not null,
	veicolo varchar(7)
		constraint incidenti_veicolo_fkey
			references veicoli
);

create table testimoniconducenti
(
	codf varchar(16) not null
		constraint testimoniconducenti_pkey
			primary key,
	targa varchar(7)
);

create table coinvolge
(
	codf varchar(16) not null
		constraint coinvolge_codf_fkey
			references testimoniconducenti,
	conducente varchar(16) not null
		constraint coinvolge_conducente_fkey
			references incidenti,
	dataoraincidente timestamp not null,
	constraint coinvolge_pkey
		primary key (codf, conducente, dataoraincidente)
);