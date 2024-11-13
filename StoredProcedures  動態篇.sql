-- 第一個動態參數(方法一)
--EXEC ('SELECT * FROM Production.Product')

-- UNICODE 字串開頭要N(方法二)
--EXEC sp_executesql N'SELECT * FROM Production.Product'

/*
| 特性                          | `EXEC ('SELECT * FROM Production.Product')`                   | `EXEC sp_executesql N'SELECT * FROM Production.Product'`                           |
|-------------------------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------|
| **參數化查詢支持**             | 不支援參數化，所有參數需直接嵌入 SQL 字串中                 | 支援參數化，可以將參數作為變數傳遞，提高安全性並降低 SQL 注入風險                  |
| **效能**                      | 每次執行都會重新解析和編譯查詢，效率較低                    | 支援快取查詢計劃，對相同查詢減少重新編譯，提高效能                                 |
| **SQL 注入風險**              | 較高，因為變數必須直接嵌入 SQL 字串                          | 較低，因為允許使用參數化的方式傳遞變數                                             |
| **變數類型**                  | 不支援參數化變數傳遞，需要在查詢中直接寫入變數值             | 支援 Unicode 查詢字串和參數類型，使查詢更靈活                                     |
| **應用場景**                  | 適用於不需要參數化的簡單查詢或單次執行                       | 適用於需要參數化、避免 SQL 注入、或頻繁執行的查詢                                 |
*/

-- SQL string concatenation

--DECLARE @TableName NVARCHAR(128)
--DECLARE @SQLString NVARCHAR(MAX)

--SET @TableName = N'Production.ProductDescription'
--SET @SQLString = ' SELECT * FROM ' + @TableName

--EXEC sp_executesql @SQLString

--帶入數字參數
--DECLARE @Number INT
--DECLARE @NumberString NVARCHAR(4)
--DECLARE @SQLString NVARCHAR(MAX)

--SET @Number = 5
--SET @NumberString = CAST(@Number AS NVARCHAR(4))

--SET @SQLString = 'SELECT TOP ' + @NumberString + '* FROM Production.Product ORDER BY SellStartDate DESC'

--EXEC sp_executesql @SQLString

--帶一個store procedures
--CREATE PROC spTableVariable
--(
--	@TName NVARCHAR(128)
--)
--AS
--BEGIN
--	DECLARE @SQLString NVARCHAR(MAX)

--	SET @SQLString = N'SELECT * FROM ' + @TName

--	EXEC sp_executesql @SQLString
--END

--EXEC spTableVariable 'HumanResources.Employee'

--帶多個參數的 store procedures
--ALTER PROC spTableVariable
--(
--	@TName NVARCHAR(128),
--	@Number INT
--)
--AS
--BEGIN
--	DECLARE @SQLString NVARCHAR(MAX)
--	DECLARE @NumberStr NVARCHAR(6)

--	SET @NumberStr = CAST(@Number AS NVARCHAR(6))

--	SET @SQLString = N'SELECT TOP ' + @NumberStr +' * FROM ' + @TName

--	EXEC sp_executesql @SQLString
--END

--EXEC spTableVariable 'HumanResources.Employee',10

--執行一個sp_executesql參數
EXEC sp_executesql
	N'SELECT e.BussinessEntityID, p.FirstName, p.LastName
	FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
	WHERE e.BusinessEntityID > @BusinessEID
	AND p.FirstName LIKE @FirstLetter + ''%'''
	,N'@BusinessEID INT, @FirstLetter VARCHAR(3)' --定義參數型別
	,@BusinessEID = 200 --傳入參數值
	,@FirstLetter = 'A'