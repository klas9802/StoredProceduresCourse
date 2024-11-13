--USE AdventureWorks2022
--GO

--CREATE FUNCTION fnLengthyDate
--	(
--		@EntireDate AS DATETIME
--	)
--RETURNS VARCHAR(MAX) --�`�NRETURN�n�[S
--AS
--BEGIN

--	--���������϶�
--	RETURN DATENAME(DW, @EntireDate) + ' '+
--	DATENAME(D, @EntireDate) + ' '+
--	DATENAME(M, @EntireDate) + ' '+
--	DATENAME(YY, @EntireDate)
--END

--����
SELECT
	Name,
	SellStartDate,
	[dbo].[fnLengthyDate](SellStartDate)
FROM
	Production.Product

--�ק�
--ALTER FUNCTION fnLengthyDate
--	(
--		@EntireDate AS DATETIME
--	)
--RETURNS VARCHAR(MAX) --�`�NRETURN�n�[S
--AS
--BEGIN

--	--���������϶�
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

--�B�z�@�ǽ������y�y
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
