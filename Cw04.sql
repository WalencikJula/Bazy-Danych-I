CREATE TABLE księgowość.pracownicy
(
	id_pracownika int  NOT NULL,
    imie text  NOT NULL,
    nazwisko text  NOT NULL,
    adres text  NOT NULL,
    telefon int  NULL,
    PRIMARY KEY (id_pracownika)
);

CREATE TABLE księgowość.godziny
(
	id_godziny int  NOT NULL,
    datta date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    PRIMARY KEY (id_godziny),
	FOREIGN KEY (id_pracownika) REFERENCES księgowość.pracownicy(id_pracownika)
);

CREATE TABLE księgowość.pensje
(
	id_pensji int  NOT NULL,
    stanowisko text  NOT NULL,
    kwota money  NOT NULL,
    PRIMARY KEY (id_pensji)
);

CREATE TABLE księgowość.premii
(
	id_premii int  NOT NULL,
    rodzaj text  NOT NULL,
    kwota int  NOT NULL,
    PRIMARY KEY (id_premii)
);

CREATE TABLE księgowość.wynagrodzenie
(
	id_wynagrodzenia int NOT NULL,
	datta date NOT NULL,
	id_pracownika int NOT NULL,
	id_godziny int NOT NULL,
	id_pensji int NOT NULL,
	id_premii int NULL,
	PRIMARY KEY (id_wynagrodzenia),
	FOREIGN KEY (id_pracownika) REFERENCES księgowość.pracownicy(id_pracownika),
	FOREIGN KEY (id_godziny) REFERENCES księgowość.godziny(id_godziny),
	FOREIGN KEY (id_pensji) REFERENCES księgowość.pensje(id_pensji),
	FOREIGN KEY (id_premii) REFERENCES księgowość.premii(id_premii)
);

COMMENT ON TABLE księgowość.pracownicy IS 'tabela pracowników';
COMMENT ON TABLE księgowość.godziny IS 'tabela godzin';
COMMENT ON TABLE księgowość.pensje IS 'tabela pensji';
COMMENT ON TABLE księgowość.premii IS 'tabela premii';
COMMENT ON TABLE księgowość.wynagrodzenie IS 'tabela wynagrodzeń';

INSERT INTO księgowość.pracownicy
VALUES
(1,'Maja','Monoto','13 Porka',455112123),
(2,'Jakub','Raj','35 Piast',131123423),
(3,'Tomasz','Motyl','1 Tulpa',456123643),
(4,'Ruby','White','163 Park',NULL),
(5,'Ola','Torto','52/123 Piwot',213789544),
(6,'Jagoda','Monoto','13 Porka',232763242),
(7,'Karolina','Utarta','23/153 Rozbior',213654234),
(8,'Monika','Kaita','123 Wieczysta',546345678),
(9,'Zygmunt','Śruba','67 Wieszcz',324768567),
(10,'Jula','Kmien','37 Postyl',566765345);

INSERT INTO księgowość.godziny
VALUES
(1, '13.12.2002', 140, 1),
(2, '26.12.2002', 160, 10),
(3, '12.12.2002', 200, 9),
(4, '19.12.2002', 140, 3),
(5, '20.12.2002', 180, 2),
(6, '16.12.2002', 150, 8),
(7, '23.12.2002', 140, 4),
(8, '28.12.2002', 120, 6),
(9, '31.12.2002', 150, 5),
(10, '15.12.2002', 180, 7);

INSERT INTO księgowość.pensje
VALUES
(1,'asystent', 680),
(2,'asystent', 800),
(3,'manager', 1800),
(4,'kierownik', 2100),
(5,'asystent', 750),
(6,'specjalista', 1300),
(7,'specjalista', 1500),
(8,'kierownik', 2900),
(9,'kierownik', 2500),
(10,'asystent', 1000);

INSERT INTO księgowość.premii
VALUES
(1,'uznaniowa', 230),
(2,'uznaniowa',300),
(3,'za frekwencję',710),
(4,'za frekwencję',200),
(5,'regulaminowa',230),
(6,'uznaniowa',480),
(7,'regulaminowa',480),
(8,'uznaniowa',800),
(9,'regulaminowa',530),
(10,'uznaniowa',100);

INSERT INTO księgowość.wynagrodzenie
VALUES
(1, '15.11.2001', 1 ,5 ,4 ,NULL),
(2, '02.04.2001', 10,7 ,9 ,NULL),
(3, '15.06.2001', 5 ,2 ,8 ,9),
(4, '15.01.2002', 6 ,6 ,5 ,10),
(5, '26.05.2002', 2 ,10,3 ,7),
(6, '27.11.2000', 8 ,3 ,6 ,NULL),
(7, '25.07.2001', 9 ,8 ,7 ,3),
(8, '23.03.2000', 4 ,4 ,10,6),
(9, '25.09.2000', 7 ,9 ,1 ,4),
(10, '14.07.2001', 3,1 ,2 ,NULL);

--PODa)
SELECT id_pracownika, nazwisko
FROM księgowość.pracownicy

--PODb)
SELECT kprac.id_pracownika
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
JOIN księgowość.premii kprem ON kw.id_premii = kprem.id_premii
WHERE ((kpen.kwota + cast(COALESCE(kprem.kwota,0) AS money )) > cast(1000 AS money))

--PODc)
SELECT kprac.id_pracownika
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
WHERE ( (kpen.kwota > cast(2000 AS money)) AND (kw.id_premii IS NULL))

--PODd)
SELECT *
FROM księgowość.pracownicy kprac
WHERE kprac.imie LIKE 'J%'

--PODe)
SELECT *
FROM księgowość.pracownicy kprac
WHERE (kprac.imie LIKE '%a' AND (kprac.nazwisko LIKE '%n%' OR kprac.nazwisko LIKE 'N%'))

--PODf)
SELECT kprac.imie, kprac.nazwisko, (kg.liczba_godzin-160) AS nadgodziny
FROM księgowość.pracownicy kprac
JOIN księgowość.godziny kg ON kg.id_pracownika = kprac.id_pracownika
WHERE (kg.liczba_godzin-160)>0

--PODg)
SELECT kprac.imie, kprac.nazwisko
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
WHERE (kpen.kwota > cast(1500 AS money) AND kpen.kwota < cast(3000 AS money) )

--PODh)
SELECT kprac.imie, kprac.nazwisko
FROM księgowość.pracownicy kprac
JOIN księgowość.godziny kg ON kg.id_pracownika = kprac.id_pracownika
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
WHERE (kg.liczba_godzin-160)>0 AND (kw.id_premii IS NULL)

--PODi)
SELECT kprac.imie, kprac.nazwisko 
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
ORDER BY kpen.kwota

--PODj)
SELECT kprac.imie, kprac.nazwisko
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika =  kprac.id_pracownika
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
LEFT JOIN księgowość.premii kprem ON kw.id_premii = kprem.id_premii
ORDER BY kpen.kwota DESC, kprem.kwota DESC

--PODk)
SELECT kpen.stanowisko, COUNT(kprac.id_pracownika) AS ilość
FROM księgowość.pensje kpen
JOIN księgowość.wynagrodzenie kw ON kw.id_pensji = kpen.id_pensji
JOIN księgowość.pracownicy kprac ON kw.id_pracownika =  kprac.id_pracownika
GROUP BY kpen.stanowisko

--PODl)
SELECT kpen.stanowisko, AVG(cast(kpen.kwota::numeric AS float) + cast(COALESCE(kprem.kwota::numeric,0) AS float)), MIN((cast(kpen.kwota::numeric AS float) )+ cast(COALESCE(kprem.kwota::numeric,0) AS float)), MAX(cast(kpen.kwota::numeric AS float)+ cast(COALESCE(kprem.kwota::numeric,0) AS float))
FROM księgowość.pensje kpen
JOIN księgowość.wynagrodzenie kw ON kw.id_pensji = kpen.id_pensji
LEFT JOIN księgowość.premii kprem ON kw.id_premii=  kprem.id_premii
WHERE kpen.stanowisko LIKE 'kierownik'
GROUP BY kpen.stanowisko

--PODm)
SELECT SUM(cast (kpen.kwota::numeric AS float) + cast(COALESCE(kprem.kwota::numeric,0) AS float))
FROM księgowość.wynagrodzenie kw
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
LEFT JOIN księgowość.premii kprem ON kprem.id_premii = kw.id_premii

--PODn)
SELECT kpen.stanowisko, SUM(cast (kpen.kwota::numeric AS float) + cast(COALESCE(kprem.kwota::numeric,0) AS float))
FROM księgowość.wynagrodzenie kw
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
LEFT JOIN księgowość.premii kprem ON kprem.id_premii = kw.id_premii
GROUP BY kpen.stanowisko

--PODo)
SELECT kpen.stanowisko, COUNT(kprem.kwota)
FROM księgowość.wynagrodzenie kw
JOIN księgowość.pensje kpen ON kw.id_pensji = kpen.id_pensji
LEFT JOIN księgowość.premii kprem ON kprem.id_premii = kw.id_premii
GROUP BY kpen.stanowisko

--PODo)
ALTER table księgowość.godziny
drop constraint godziny_id_pracownika_fkey,
add constraint godziny_id_pracownika_fkey
   foreign key (id_pracownika)
   references księgowość.pracownicy(id_pracownika)
   on delete cascade;

ALTER table księgowość.wynagrodzenie
drop constraint wynagrodzenie_id_pracownika_fkey,
add constraint wynagrodzenie_id_pracownika_fkey
   foreign key (id_pracownika)
   references księgowość.pracownicy(id_pracownika)
   on delete cascade;

ALTER table księgowość.wynagrodzenie
drop constraint wynagrodzenie_id_godziny_fkey,
add constraint wynagrodzenie_id_godziny_fkey
   foreign key (id_godziny)
   references księgowość.godziny(id_godziny)
   on delete cascade;

DELETE FROM księgowość.pracownicy
WHERE id_pracownika IN
(
	SELECT kprac.id_pracownika
	FROM księgowość.pracownicy kprac
	JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika = kprac.id_pracownika
	JOIN księgowość.pensje kpen ON kpen.id_pensji = kw.id_pensji
	WHERE kpen.kwota < cast(1200 AS money)
)
