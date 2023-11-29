--PODa)
ALTER TABLE księgowość.pracownicy
ADD telefon_n text;

UPDATE księgowość.pracownicy
SET telefon_n = ('(+48)' || cast(telefon AS text));

ALTER TABLE księgowość.pracownicy
DROP COLUMN telefon

ALTER TABLE księgowość.pracownicy
RENAME COLUMN telefon_n to telefon;

--PODb)
UPDATE księgowość.pracownicy
SET telefon = (LEFT(telefon,8)||'-'||LEFT(RIGHT(telefon,6),3)||'-'||RIGHT(telefon,3));

--PODc)
SELECT kprac.id_pracownika, UPPER(kprac.imie), UPPER(kprac.nazwisko), kprac.adres, kprac.telefon
FROM księgowość.pracownicy kprac
WHERE kprac.id_pracownika IN
(
	SELECT kprac.id_pracownika
	FROM księgowość.pracownicy kprac
	WHERE LENGTH(kprac.nazwisko) =
	(
		SELECT MAX(LENGTH(kprac.nazwisko))
		FROM księgowość.pracownicy kprac
	)
)

--PODd)
SELECT kprac.id_pracownika, MD5(kprac.imie) AS imie, MD5(kprac.nazwisko) AS nazwisko, MD5(kprac.adres) AS adres, MD5(kprac.telefon) AS telefon, kpen.kwota
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika = kprac.id_pracownika
JOIN księgowość.pensje kpen ON kpen.id_pensji = kw.id_pensji

--PODf)
SELECT kprac.imie, kprac.nazwisko, kpen.kwota, kprem.kwota
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika = kprac.id_pracownika
JOIN księgowość.pensje kpen ON kpen.id_pensji = kw.id_pensji
LEFT JOIN księgowość.premii kprem ON kprem.id_premii = kw.id_premii

--PODg)
SELECT CONCAT('Pracownik ', kprac.imie,' ', kprac.nazwisko,' na stanowisku: ', kpen.stanowisko,
			  ' otrzymal(a) pensje calkowita na kwote ', kpen.kwota+cast(COALESCE(kprem.kwota,0) AS money ),
			  ', gdzie wynagrodzenie zasadnicze wynosilo: ', kpen.kwota,
			  ', premia: ', cast(COALESCE(kprem.kwota,0) AS money ))
FROM księgowość.pracownicy kprac
JOIN księgowość.wynagrodzenie kw ON kw.id_pracownika = kprac.id_pracownika
JOIN księgowość.pensje kpen ON kpen.id_pensji = kw.id_pensji
LEFT JOIN księgowość.premii kprem ON kw.id_premii = kprem.id_premii