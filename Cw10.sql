--Zad1)
BEGIN TRANSACTION
UPDATE Production.Product
SET ListPrice = 1.1*ListPrice
WHERE ProductID = 680
COMMIT TRANSACTION

--Zad2)
ALTER TABLE Production.Product
DROP COLUMN rowguid

SET IDENTITY_INSERT Production.Product ON

BEGIN TRANSACTION
INSERT INTO Production.Product
([ProductID], [Name], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [Size], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ModifiedDate])
VALUES 
(1000, 'Blade 2.0', 'BL-2336', 1, 0, 'Silver', 800, 400, 12, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '2008-01-30 00:00:00.000', NULL, NULL, '2023-12-27 20:33:36.827')
COMMIT TRANSACTION

--Zad3)
BEGIN TRANSACTION
DELETE FROM Production.Product
WHERE ProductID =1000
ROLLBACK TRANSACTION

--Zad4)
BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = 1.1 * StandardCost
IF ( (SELECT SUM(StandardCost)
FROM Production.Product) <= 50000  )
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION

--Zad5)
DECLARE @ProdNum varchar(25);
SET @ProdNum = 'BL-2346';

BEGIN TRANSACTION
IF (EXISTS
(
	SELECT PP.ProductID
	FROM Production.Product PP
	WHERE ProductNumber = @ProdNum
))
BEGIN
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	INSERT INTO Production.Product
	([ProductID], [Name], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [Size], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ModifiedDate])
	VALUES 
	(1001, 'Blade 2.2', @ProdNum, 1, 0, 'Silver', 800, 400, 12, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, '2008-01-30 00:00:00.000', NULL, NULL, '2023-12-27 20:33:36.827')
	COMMIT TRANSACTION
END


--Zad6)
BEGIN TRANSACTION
IF (EXISTS
(
	SELECT SSOD.OrderQty
	FROM Sales.SalesOrderDetail SSOD
	WHERE OrderQty = 0
))
BEGIN
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty = 2 * OrderQty
	COMMIT TRANSACTION
END

--Zad7)
DECLARE @Ave money;
SET @Ave= (SELECT AVG(PP.StandardCost) FROM Production.Product PP);

BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = @Ave
WHERE StandardCost > @Ave
IF @@ROWCOUNT > 200
BEGIN
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	COMMIT TRANSACTION
END