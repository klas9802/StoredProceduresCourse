USE AdventureWorks2022
Go

-- 穝PROC
--CREATE PROC spProductInfo
--AS
--BEGIN
--	SELECT
--		ProductID,
--		Name,
--		ProductNumber
--	FROM
--		Production.Product
--	ORDER BY
--		Name ASC
--END

-- эPROC
--ALTER PROC spProductInfo
--AS
--BEGIN
--	SELECT
--		ProductID,
--		Name,
--		ProductNumber,
--		SafetyStockLevel
--	FROM
--		Production.Product
--	ORDER BY
--		Name DESC
--END

-- 埃PROC
--DROP PROC spProductInfo

-- 糤把计
--CREATE PROC spProdList(@MinListPrice AS INT)
--AS
--BEGIN
--	SELECT
--		NAME,
--		ListPrice
--	FROM
--		Production.Product
--	WHERE
--		ListPrice > @MinListPrice
--	ORDER BY
--		Name ASC
--END
	
-- 把计
-- EXEC spProdList @MinListPrice = 100, @MaxListPrice =200
-- 磅︽菠跑计嘿
-- EXEC spProdList 100, 200

--ALTER PROC spProdList
--	(
--		@MinListPrice AS INT, 
--		@MaxListPrice AS INT
--	)
--AS
--BEGIN
--SELECT
--		NAME,
--		ListPrice
--	FROM
--		Production.Product
--	WHERE
--		ListPrice >= @MinListPrice
--		AND ListPrice <= @MaxListPrice
--	ORDER BY
--		Name ASC
--END

-- 块﹃把计
--ALTER PROC spProdList
--	(
--		@MinListPrice AS INT, 
--		@MaxListPrice AS INT,
--		@ProdName AS VARCHAR(MAX)
--	)
--AS
--BEGIN
--SELECT
--		NAME,
--		ListPrice
--	FROM
--		Production.Product
--	WHERE
--		ListPrice >= @MinListPrice
--		AND ListPrice <= @MaxListPrice
--		AND Name Like '%' + @ProdName + '%'
--	ORDER BY
--		Name ASC
--END
-- EXEC spProdList @MinListPrice = 100, @MaxListPrice =200, @ProdName = 'road'

-- ﹚竡匡把计
--ALTER PROC spProdList
--	(
--		@MinListPrice AS INT = 0, --﹚竡﹍琌0 
--		@MaxListPrice AS INT, 
--		@ProdName AS VARCHAR(MAX)
--	)
--AS
--BEGIN
--SELECT
--		NAME,
--		ListPrice
--	FROM
--		Production.Product
--	WHERE
--		ListPrice >= @MinListPrice
--		AND ListPrice <= @MaxListPrice
--		AND Name Like '%' + @ProdName + '%'
--	ORDER BY
--		Name ASC
--END

-- NULL ﹚竡
ALTER PROC spProdList
	(
		@MinListPrice AS INT = NULL,
		@MaxListPrice AS INT = NULL, 
		@ProdName AS VARCHAR(MAX)
	)
AS
BEGIN
	SELECT
		NAME,
		ListPrice
	FROM
		Production.Product
	WHERE
		(@MinListPrice IS NULL OR ListPrice >= @MinListPrice)
		AND (@MaxListPrice IS NULL OR ListPrice <= @MaxListPrice)
		AND Name Like '%' + @ProdName + '%'
	ORDER BY
		Name ASC
END