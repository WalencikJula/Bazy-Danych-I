USE AdventureWorksLT2022;
USE AdventureWorks2022;

--Zad1)
CREATE TABLE ##TempEmployeeInfo
(
	BusinessEntityID int,
	Rate money,
	Title varchar(8),
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	PRIMARY KEY (BusinessEntityID)
)

INSERT INTO ##TempEmployeeInfo
SELECT PP.BusinessEntityID, SUM(HEPH.Rate) AS Rate, PP.Title, PP.FirstName, PP.LastName
FROM AdventureWorks2022.Person.Person PP
INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory HEPH ON HEPH.BusinessEntityID = PP.BusinessEntityID
GROUP BY PP.BusinessEntityID, PP.Title, PP.FirstName, PP.LastName
ORDER BY PP.BusinessEntityID

SELECT * FROM ##TempEmployeeInfo

--Zad2)
SELECT CONCAT(SC.CompanyName,' (',SC.FirstName,' ',SC.LastName,')') AS CompanyContact, SSH.TotalDue AS Revenue
FROM AdventureWorksLT2022.SalesLT.SalesOrderHeader SSH
INNER JOIN AdventureWorksLT2022.SalesLT.Customer SC ON SC.CustomerID = SSH.CustomerID

--Zad3)
SELECT SPC.Name AS Category, ROUND(SUM(SOD.LineTotal),2) AS SalesValue
FROM AdventureWorksLT2022.SalesLT.Product SP
JOIN AdventureWorksLT2022.SalesLT.ProductCategory SPC ON SPC.ProductCategoryID = SP.ProductCategoryID
JOIN AdventureWorksLT2022.SalesLT.SalesOrderDetail SOD ON SOD.ProductID = SP.ProductID
GROUP BY SP.ProductCategoryID, SPC.Name