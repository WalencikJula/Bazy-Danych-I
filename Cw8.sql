--Zad1)
CREATE PROCEDURE Ciag_Fib(@max int)
AS
BEGIN
	DECLARE @numer TABLE(numer int)
	INSERT INTO @numer VALUES ( 0 )
	IF( @max > 1 )
	BEGIN
		INSERT INTO @numer VALUES ( 1 )

		DECLARE @n1 int = 0, @n2 int =1, @i int=2, @pomoc int
		WHILE  @i < @max
		BEGIN
			INSERT INTO @numer VALUES( @n2 + @n1 )
			SET @pomoc = @n2
			SET @n2 = @n2 + @n1
			SET @n1 = @pomoc
			SET @i += 1
		END
	END
	SELECT * FROM @numer
END

--Zad2)
CREATE TRIGGER new_Data
ON AdventureWorks2022.Person.Person
AFTER INSERT
AS
BEGIN
	DECLARE @pomoc INT;
	SELECT @pomoc = BusinessEntityID FROM inserted;
	UPDATE Person.Person
	SET LastName = UPPER(LastName)
	WHERE Person.BusinessEntityID = @pomoc;
END

--Zad3)
CREATE TRIGGER taxRateMonitoring
ON AdventureWorks2022.Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE @pomoc1 SMALLMONEY, @pomoc2 SMALLMONEY;
	SELECT @pomoc1 = TaxRate FROM inserted;
	SELECT @pomoc2 = TaxRate FROM deleted;
	IF ( @pomoc2/@pomoc1 > 30 )
	BEGIN
		RAISERROR(15600, -1, -1, 'Podniesienie TAXRATE')
	END
END