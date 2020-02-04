--Popolamento Carte di credito
insert into cc values (1, '4023345666755643', '01-01-2020', 'Paolo Rossi', 'VISA');
insert into cc values (2, '4023345222355643', '01-05-2019', 'Mario Rossi', 'VISA');
insert into cc values (3, '4023345456755643', '01-07-2021', 'Marco Maschio', 'VISA');
insert into cc values (4, '4023345786555643', '01-11-2022', 'Roberto Garbarino', 'MASTERCARD');
insert into cc values (5, '4023236748955643', '01-12-2020', 'Francesco De Gregori', 'MASTERCARD');
insert into cc values (6, '4021922649207463', '01-09-2024', 'Adriano Celentano', 'VISA');
insert into cc values (7, '4023345661231253', '01-01-2023', 'Fio Germi', 'VISA');
insert into cc values (8, '4023345666799763', '01-09-2022', 'Gerry Scotti', 'MASTERCARD');
insert into cc values (9, '4015628105666753', '01-04-2021', 'Giacomo Cangioloni', 'VISA');
insert into cc values (10, '4023124780597343', '01-06-2025', 'Maria Giordano', 'VISA');

--RID

insert into RID values (1, 'Giacomo Cangioloni', 'IT92D0300203280753829196629');
insert into RID values (2, 'Paolo Rossi', 'IT76P0300203280488455885995');
insert into RID values (3, 'Maria Giordano', 'IT45V0300203280954185284694');
insert into RID values (4, 'Ezio Greggio', 'MC7630003000709831872185S71');
insert into RID values (5, 'Cristiano Olivari', 'BR5026717536862473534325F4');
insert into RID values (6, 'Marco Marcio', 'IT49C0300203280541486218456');
insert into RID values (7, 'Lorenzo Svanosio', 'IT98N0300203280189578483639');
insert into RID values (8, 'Sara Nuvoli', 'IT33P0300203280621194373642');
insert into RID values (9, 'Francesco Giuseppe', 'CI16M268544311748144872');
insert into RID values (10, 'Gerry Scotti', 'LU060103898248445173');


--modalita pagamento
insert into modalitapagamento values (1, 70, 2, 1);
insert into modalitapagamento values (2, 65, NUll, NULL);
insert into modalitapagamento values (3, NULL, 7, NULL);
insert into modalitapagamento values (4, 40, NUll, 3);
insert into modalitapagamento values (5, NULL, 1, 2);
insert into modalitapagamento values (6, 65, 8, 4);
insert into modalitapagamento values (7, 12, 5, NULL);
insert into modalitapagamento values (8, 55, NULL, 1);
insert into modalitapagamento values (9, 70, 6, 5);
insert into modalitapagamento values (10, NULL, NUll, 10);
insert into modalitapagamento values (11, NULL, NULL, 9);
insert into modalitapagamento values (12, 33, 4, 8);
--Utenti

INSERT INTO utente (codu, codmp) VALUES (1, 1);
INSERT INTO utente (codu, codmp) VALUES (2, 2);
INSERT INTO utente (codu, codmp) VALUES (3, 3);
INSERT INTO utente (codu, codmp) VALUES (4, 4);
INSERT INTO utente (codu, codmp) VALUES (5, 5);
INSERT INTO utente (codu, codmp) VALUES (6, 6);
INSERT INTO utente (codu, codmp) VALUES (7, 7);
INSERT INTO utente (codu, codmp) VALUES (8, 8);
INSERT INTO utente (codu, codmp) VALUES (9, 9);
INSERT INTO utente (codu, codmp) VALUES (10, 10);
INSERT INTO utente (codu, codmp) VALUES (11, 11);
INSERT INTO utente (codu, codmp) VALUES (12, 2);
INSERT INTO utente (codu, codmp) VALUES (13, 4);
INSERT INTO utente (codu, codmp) VALUES (14, 12);

--Privato

INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (1, 'TMMFXX00I24E463J', 'tommofaa@gmail.com', 'Tommo', 'Faa', '2000-01-01', 'Brembate', 'M', 'studente', 'Via Dotto, 6', true);
INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (2, 'GCMCNG96E24E463J', 'cingolans@gmail.com', 'Giacomo', 'Cangioloni', '1996-01-01', 'Addis Abeba', 'M', 'studente', 'Via Pronti, 9', false);
INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (3, 'MRCMSC96E12R163J', 'SHOPPIAML@gmail.com', 'Marco', 'Maschio', '1996-12-23', 'Santa Maria', 'M', 'studente', 'Piazza Ta, 5', true);
INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (4, 'LCXVLL97H54Y234O', 'luccavalle@hotmail.com', 'Lucca', 'Valle', '2000-10-03', 'Scampia', 'M', 'portapizze', 'Largo Stretto, 1', false);
INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (5, 'MRXGRD66E24E463J', 'mariagiordano5@gmail.com', 'Maria', 'Giordano', '1966-01-01', 'Roma', 'F', 'pizzaiola', 'Via Del Corso, 23', false);
INSERT INTO privato (codu, codf, email, nome, cognome, datan, luogon, genere, professione, indirizzo, bonus) VALUES (6, 'RXXKSM96E24E463J', 'erikasamoto@gmail.com', 'Eri', 'Kasamoto', '1989-01-01', 'Tokyo', 'F', 'soldato', 'Via Del Parco, 12 ', false);
--Legali

insert into legali values (1, 'Davide', 'Marcone', '01-01-1996', 'Camogli');
insert into legali values (2, 'Gianmaria', 'Sasso', '01-02-1990', 'Recco');
insert into legali values (3, 'Cristiano', 'Olivari', '24-05-1996', 'La Spezia');
insert into legali values (4, 'Rachele', 'Faretra', '01-10-1995', 'Lavagna');
insert into legali values (5, 'Jacob', 'Cangiolini', '23-07-1990', 'Alessandria (EG)');
insert into legali values (6, 'Paolo', 'Arcone', '05-04-1981', 'Salsomaggiore');

-- Aziende

insert into aziende values(7, 02191860135, 'general@general.com', 0185243361, 'General', 'Santa Maria Del Campo, 12', 'Imprese Generali', 'Giovanni', 'Generali', 3333454567, 'Via Carlo, 2', 1 );
insert into aziende values(8, 02191999000, 'NVIDIA@NVIDIA.com', 01115430092, 'Nvidia Ent.', 'Cape Canaveral, 12', 'Videogiochi', 'Billy', 'Idol', 3333086457, 'Via Roberto, 1', 2 );
insert into aziende values(9, 02191860100, 'Microsoft@gmail.com', 0022345654, 'MIcrosoft', 'Silicon Valley, 1', 'Computer', 'Billo', 'Cancello', 3312546600, 'Via Fatto, 5', 3 );
insert into aziende values(10, 00091860124, 'lacampese@lacampese.com', 0185111361, 'Birrificio La Campese', 'Via Santa Maria Del Campo, 193', 'Bevande', 'Matteo', 'Lusardi', 3345797877, 'Via Santa Maria Del Campo, 193', 4 );
insert into aziende values(11, 01191860135, 'fandc@fandc.com', 0185243888, 'FishAndChips', 'Via Massaia, 50', 'Giochi Mobile', 'Cricchi', 'Chicco', 3333454567, 'Via Massaia 50', 5);
insert into aziende values(12, 03391860135, 'hem@hem.com', 0185289900, 'H&M', 'Via Via, 1', 'Vestiario', 'Harnold', 'Marzenegger', 3333454567, 'Via Via , 2', 6 );

--Abbonamenti

insert into abbonamenti values (1, INTERVAL '7 days', 15);
insert into abbonamenti values (2, INTERVAL '30 days', 45);
insert into abbonamenti values (3, INTERVAL '14 days', 26);
insert into abbonamenti values (4, INTERVAL '60 days', 80);
insert into abbonamenti values (5, INTERVAL '180 days', 220);

--Storico Abbonamenti

INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (1, '2019-10-07', '2019-10-14', 1, '2019-04-01', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (2, '2019-06-18', '2019-06-25', 1, '2019-06-17', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (3, '2019-02-01', '2019-04-02', 4, '2019-02-20', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (3, '2019-01-01', '2019-01-08', 1, '2020-01-01', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (7, '2019-11-04', '2020-05-02', 5, '2019-11-01', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (8, '2019-12-01', '2020-05-29', 5, '2019-12-08', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (9, '2019-06-04', '2019-06-18', 3, '2020-10-10', 'CC');
INSERT INTO storicoabbonamenti (codu, datai, dataf, coda, datapagamento, tipopagamento) VALUES (6, '2019-12-27', '2020-06-24', 5, '2019-12-28', 'CC');

--Modelli

INSERT INTO modelli   VALUES (6, 999, 86.0, 5, 10.0, 250, 5, true, true, true, 'Volkswagen', 'Golf', 147, 426, 180, 40, 'Cargo');
INSERT INTO modelli   VALUES (1, 1000, 45.1, 5, 133.2, 250, 4, true, true, true, 'Karl', 'Opel', 160, 3, 1, 10, 'City Car');
INSERT INTO modelli   VALUES (3, 1000, 75.0, 5, 7.0, 200, 5, true, true, true, 'I10', 'Hyundai', 150, 350, 160, 30, 'Elettrico');
INSERT INTO modelli   VALUES (4, 1995, 148.0, 5, 10.0, 280, 5, true, true, true, 'Giulia', 'Alfa Romeo', 145, 464, 186, 40, 'Media');
INSERT INTO modelli   VALUES (8, 875, 63.0, 5, 10.0, 180, 5, true, true, true, '500', 'Fiat', 149, 357, 163, 30, 'City Car');
INSERT INTO modelli   VALUES (9, 1248, 70.0, 5, 10.0, 160, 5, true, true, true, 'Punto', 'Fiat', 149, 407, 169, 40, 'City Car');
INSERT INTO modelli   VALUES (5, 1368, 88.0, 5, 10.0, 230, 5, true, true, true, 'Giulietta', 'Alfa Romeo', 146, 435, 180, 40, 'Comfort');
INSERT INTO modelli   VALUES (2, 1995, 100.0, 5, 10.0, 270, 5, true, true, true, 'Forester', 'Subaru', 160, 380, 160, 100, 'Comfort');
INSERT INTO modelli   VALUES (7, 875, 63.0, 5, 10.0, 190, 5, true, true, true, 'Panda', 'Fiat', 155, 365, 164, 25, 'City Car');
--Telefoni

INSERT INTO telefoni (ntelefono, utente) VALUES (3934562783, 4);
INSERT INTO telefoni (ntelefono, utente) VALUES (3934435676, 2);
INSERT INTO telefoni (ntelefono, utente) VALUES (3931138767, 5);	
INSERT INTO telefoni (ntelefono, utente) VALUES (3355464523, 3);
INSERT INTO telefoni (ntelefono, utente) VALUES (3333984723, 5);
INSERT INTO telefoni (ntelefono, utente) VALUES (3333255678, 1);

--Tariffe

INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (1, 5.00, 1.00, 50.00, 7.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (2, 2.00, 1.00, 60.00, 8.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (3, 2.00, 1.00, 60.00, 6.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (4, 2.00, 1.00, 70.00, 7.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (5, 2.00, 1.00, 80.00, 8.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (6, 4.00, 2.00, 60.00, 5.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (7, 3.00, 3.00, 90.00, 10.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (8, 2.00, 1.00, 68.00, 9.00);
INSERT INTO tariffe (codm, oraria, kilmetrica, settimanale, giornaliera) VALUES (9, 1.00, 1.00, 67.00, 8.00);

--Parcheggi

INSERT INTO parcheggi (codp, lat, long, nome, indirizzo, zona, numposti) VALUES (1, '12145', '33252', 'Piccapietra', 'Via piccapietra', 'Piccapietra', 25);
INSERT INTO parcheggi (codp, lat, long, nome, indirizzo, zona, numposti) VALUES (2, '52352', '11234', 'Vittoria', 'Piazza della vittoria', 'Foce', 30);
INSERT INTO parcheggi (codp, lat, long, nome, indirizzo, zona, numposti) VALUES (3, '33213', '123421', 'casa', 'via del carreto ', 'rapallo', 2);


--Ammette

INSERT INTO ammette (codp, nomecategoria) VALUES (1, 'City Car');
INSERT INTO ammette (codp, nomecategoria) VALUES (1, 'Cargo');
INSERT INTO ammette (codp, nomecategoria) VALUES (1, 'Elettrico');
INSERT INTO ammette (codp, nomecategoria) VALUES (1, 'Media');
INSERT INTO ammette (codp, nomecategoria) VALUES (2, 'Media');
INSERT INTO ammette (codp, nomecategoria) VALUES (2, 'Cargo');
INSERT INTO ammette (codp, nomecategoria) VALUES (2, 'Elettrico');
INSERT INTO ammette (codp, nomecategoria) VALUES (3, 'Comfort');
INSERT INTO ammette (codp, nomecategoria) VALUES (3, 'Media');
INSERT INTO ammette (codp, nomecategoria) VALUES (3, 'City Car');
--Veicoli

INSERT INTO veicoli VALUES ('AB123AB', 'Violetta', 12000.00, 'Blu', 1234, 1, false, 1, 1);
INSERT INTO veicoli VALUES ('PP123PP', 'Bluette', 16000.00, 'Verde', 1234, 1, true, 1, 3);
INSERT INTO veicoli VALUES ('VV123VV', 'Azzurra', 21000.00, 'Grigia', 1234, 2, true, 3, 1);
INSERT INTO veicoli VALUES ('PP234PP', 'Bionda', 22000.00, 'Nera', 1234, 1, false, 4, 2);
INSERT INTO veicoli VALUES ('QQ123PP', 'Mazzi', 99000.00, 'Rossa', 1234, null, false, 4, 2);
INSERT INTO veicoli VALUES ('FS668SS', 'Giova', 29000.00, 'Blu', 1234, null, true, 2, 3);
INSERT INTO veicoli VALUES ('FT121GB', 'Paol', 89000.00, 'Nera', 1234, null, true, 4, 1);

--Conducenti

INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('TRNDVO96R22E132F', 'VV65463JI', 'GE4532351K', 'B ', 1, null, 'Via Dotto, 6', '2025-07-11', '2015-07-11');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('TMMFXX00I24E463J', 'BB34234ED', 'GE4553422K', 'B ', 1, null, 'Via Dotto, 6', '2027-12-11', '2017-01-11');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('PLRCML68T23E488W', 'GR33222AB', 'GE3222675K', 'B ', 2, null, 'Via Pronti, 9', '2025-11-28', '2019-11-13');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('NPLNSL73F11E444R', 'DE234112V', 'GE3525678K', 'B ', null, 7, 'Vicolo Cieco Fondachetto, 13', '2027-06-11', '2018-10-06');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('PNCADT22E49B212R', 'DD32342TG', 'GE3231124K', 'B ', 3, null, 'Piazza Ta, 5', '2029-05-11', '2019-05-11');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('TSCMMA11B79B344M', 'MN32892DD', 'GE3119498K', 'B ', 3, null, 'Piazza Ta, 5', '2028-07-20', '2018-07-20');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('TRVGNZ23A78B233R', 'JI72847WQ', 'GE3291847K', 'B ', null, 7, 'Via del Canneto, 77', '2022-01-01', '2012-01-01');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('BRGGRU37B22E333F', 'EWHRBH12E', 'GE2134918K', 'B ', null, 8, 'Via del Guaglione', '2025-01-28', '2020-01-08');
INSERT INTO conducenti (codf, estremidoc, estremipat, catpat, utente, azienda, indirizzo, datasdoc, datardoc) VALUES ('AWWEVE12Q13V344F', 'AWEB3233C', 'GE2231298K', 'B ', null, 8, 'Via della fontana, 2', '2030-01-22', '2020-01-08');

--Prenotazioni

insert into prenotazioni values (1, 7, 'NPLNSL73F11E444R' ,'2020-02-06 08:00:00','2020-02-09 08:00:00',0,null, null, null, 'AB123AB', '2019-10-08 00:00:00',null, null, 'CC', null);
insert into prenotazioni values (2, 7, 'NPLNSL73F11E444R' ,'2019-12-06 08:00:00','2020-12-12 08:00:00',140,null, null, null, 'PP123PP', '2019-12-06 07:40:00',null, null, 'CC', null);
insert into prenotazioni values(3, 8, 'BRGGRU37B22E333F','2019-12-03 12:00:00', '2019-12-16 12:00:00', 2000, 2500, '2019-12-03 12:00:01', '2019-12-16 11:00:00', 'FT121GB', '2019-12-02 07:40:00',null,'2019-12-02 07:40:00', 'CC', null);
INSERT INTO prenotazioni VALUES (4, 8,'BRGGRU37B22E333F', '2020-01-01 00:00:00.002000', '2020-01-07 17:01:58.000000', 1400.00, 1500.00, '2020-01-01 17:02:13.000000', '2020-01-07 18:02:36.000000', 'FT121GB', '2019-12-27 17:03:00.000000', null, '2019-12-27 18:03:24.000000', 'CC', null);
INSERT INTO prenotazioni VALUES (5, 6, 'TSCMMA11B79B344M','2020-01-01 09:21:51.000000', '2020-01-08 09:22:01.000000', 12000.00, 13000.00, '2020-01-01 10:22:27.000000', '2020-01-08 10:22:37.000000', 'PP234PP', '2019-12-30 09:23:07.000000', null, '2019-12-30 10:23:25.000000', 'CC', null);


