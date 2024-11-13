--USE AdventureWorks2022
--GO

--CREATE FUNCTION fnLengthyDate
--	(
--		@EntireDate AS DATETIME
--	)
--RETURNS VARCHAR(MAX) --注意RETURN要加S
--AS
--BEGIN

--	--執行交易的區塊
--	RETURN DATENAME(DW, @EntireDate) + ' '+
--	DATENAME(D, @EntireDate) + ' '+
--	DATENAME(M, @EntireDate) + ' '+
--	DATENAME(YY, @EntireDate)
--END

--執行
SELECT
	Name,
	SellStartDate,
	[dbo].[fnLengthyDate](SellStartDate)
FROM
	Production.Product

--修改
--ALTER FUNCTION fnLengthyDate
--	(
--		@EntireDate AS DATETIME
--	)
--RETURNS VARCHAR(MAX) --注意RETURN要加S
--AS
--BEGIN

--	--執行交易的區塊
--	RETURN DATENAME(WEEKDAY, @EntireDate) + ' '+
--	DATENAME(D, @EntireDate) + ' '+
--	CASE
--		WHEN DAY(@EntireDate) IN (1, 21, 31) THEN 'st'
--		WHEN DAY(@EntireDate) IN (2, 22) THEN 'nd'
--		WHEN DAY(@EntireDate) IN (3, 23) THEN 'rd'
--		ELSE 'th'
--	END + ' '+
--	DATENAME(YY, @EntireDate)
--END

--處理一些複雜的語句
--CREATE FUNCTION fnFirstWordProdName
--	(
--		@ProdName VARCHAR(MAX)
--	)
--RETURNS VARCHAR(MAX)
--AS
--BEGIN
--	DECLARE @BlankPosition AS INT
--	DECLARE @Outcome AS VARCHAR(MAX)

--	SET @BlankPosition = CHARINDEX(' ', @ProdName)

--	IF @BlankPosition = 0
--		SET @Outcome = @ProdName
--	ELSE
--		SET @Outcome = LEFT(@ProdName, @BlankPosition - 1)

--	RETURN @Outcome
--END

--SELECT NAME, dbo.fnFirstWordProdName(Name) FROM Production.Product
