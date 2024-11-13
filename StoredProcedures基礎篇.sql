USE AdventureWorks2022
Go

-- �s�ؤ@��PROC
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

-- �ק�PROC
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

-- �R��PROC
--DROP PROC spProductInfo

-- �W�[�Ѽ�
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
	
-- �h�ӰѼ�
-- EXEC spProdList @MinListPrice = 100, @MaxListPrice =200
-- ����i�ٲ��ܼƦW��
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

-- ��J�r��Ѽ�
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

-- �w�q�i��Ѽ�
--ALTER PROC spProdList
--	(
--		@MinListPrice AS INT = 0, --�w�q��l�O0 
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

-- NULL �@���w�q
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