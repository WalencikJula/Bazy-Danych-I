CREATE TABLE "rozliczenia".Pracownicy
(
    Id_Pracownika int  NOT NULL,
    Imie text  NOT NULL,
    Nazwisko text  NOT NULL,
    Adres text  NOT NULL,
    Telefon int  NULL,
    PRIMARY KEY (Id_Pracownika)
);

CREATE TABLE "rozliczenia".Godziny
(
    Id_Godziny int  NOT NULL,
    Dataa date  NOT NULL,
    Liczba_Godzin int  NOT NULL,
    Id_Pracownika int  NOT NULL,
    PRIMARY KEY (Id_Godziny)
);

CREATE TABLE "rozliczenia".Pensje
(
    Id_Pensji int  NOT NULL,
    Stanowisko text  NOT NULL,
    Kwota money  NOT NULL,
    Id_Premi int  NULL,
    PRIMARY KEY (Id_Pensji)
);

CREATE TABLE "rozliczenia".Premie
(
    Id_Premi int  NOT NULL,
    Rodzaj text  NOT NULL,
    Kwota int  NOT NULL,
    PRIMARY KEY (Id_Premi)
);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premi) REFERENCES rozliczenia.premie(id_premi)

INSERT INTO rozliczenia.pracownicy
VALUES (1,'Maja','Momoto','13 Porka',455112123),
(2,'Tobiasz','Raj','35 Piast',131123423),
(3,'Tomasz','Motyl','1 Tulpa',456123643),
(4,'Ruby','White','163 Park',NULL),
(5,'Ola','Torto','52/123 Piwot',213789544),
(6,'Ruta','Momoto','13 Porka',232763242),
(7,'Karolina','Utarta','23/153 Rozbior',213654234),
(8,'Monika','Kaita','123 Wieczysta',546345678),
(9,'Zygmunt','Śruba','67 Wieszcz',324768567),
(10,'Ula','Kmiet','37 Postyl',566765345);

INSERT INTO rozliczenia.godziny
VALUES
(1, '13.12.2002', 3, 1),
(2, '26.12.2002', 2, 10),
(3, '12.12.2002', 2, 9),
(4, '19.12.2002', 4, 3),
(5, '20.12.2002', 3, 2),
(6, '16.12.2002', 3, 8),
(7, '23.12.2002', 4, 4),
(8, '28.12.2002', 2, 6),
(9, '31.12.2002', 3, 5),
(10, '15.12.2002', 1, 7);

INSERT INTO rozliczenia.premie
VALUES
(1,'uznaniowa', 230),
(2,'uznaniowa',230),
(3,'za frekwencję',710),
(4,'za frekwencję',530),
(5,'regulaminowa',230),
(6,'uznaniowa',480),
(7,'regulaminowa',480),
(8,'uznaniowa',800),
(9,'regulaminowa',530),
(10,'uznaniowa',230);

INSERT INTO rozliczenia.pensje
VALUES
(1,'asystent', 2300, 5),
(2,'asystent', 2300, 1),
(3,'manager', 7100, 7),
(4,'starszy specjalista', 5300, 6),
(5,'asystent', 2300, 2),
(6,'specjalista', 4800, 8),
(7,'specjalista', 4800, 3),
(8,'dyrektor', 8000, 10),
(9,'starszy specjalista', 5300, 4),
(10,'asystent', 2300, 9);

SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

SELECT date_part('dow', dataa) AS dzien_tygodnia, date_part('month', dataa) AS miesiac
FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota to kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD kwota_netto money;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto/1.23;