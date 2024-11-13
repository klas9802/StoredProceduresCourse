--USE AdventureWorks2022
--GO

---- 1. 宣告變數
--DECLARE @Date AS DATETIME

----值存到變數中
--SET	@Date = '2014-05-31'

---- 更改日期作為變數
--SELECT 
--	TransactionID, TransactionDate, 'Transactions' AS [Type]
--FROM
--	Production.TransactionHistory
--WHERE
--	--TransactionDate >= '2012-05-31 00:00:00.000' --靜態
--	TransactionDate >= @Date --動態

--UNION ALL

--SELECT
--	SalesOrderID, OrderDate, 'SalesOrders'
--FROM
--	Sales.SalesOrderHeader
--WHERE
--	--OrderDate >= '2012-05-31 00:00:00.000'--靜態
--	OrderDate >= @Date --動態


---- 2. Query結果存到變數之中
---- 假設我們想取得一組結果中的交易數量和銷售數量
--USE AdventureWorks2022
--GO

---- 宣告變數
--DECLARE @Date AS DATETIME
--DECLARE @NumTran INT
--DECLARE @NumSales INT

----值存到變數中
--SET	@Date = '2014-05-31'

----取得總筆數
--SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate >= @Date)
--SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate >= @Date)

--SELECT 'Number of Transactions', @NumTran --顯示Transactions交易數量
--UNION
--SELECT 'Number of Sales Order', @NumSales --顯示Sales Order交易數量


---- 更改日期作為變數
--SELECT 
--	TransactionID, TransactionDate, 'Transactions' AS [Type]
--FROM
--	Production.TransactionHistory
--WHERE
--	--TransactionDate >= '2012-05-31 00:00:00.000' --靜態
--	TransactionDate >= @Date --動態

--UNION ALL

--SELECT
--	SalesOrderID, OrderDate, 'SalesOrders'
--FROM
--	Sales.SalesOrderHeader
--WHERE
--	--OrderDate >= '2012-05-31 00:00:00.000'--靜態
--	OrderDate >= @Date --動態


-- 3. 在訊息中PRINT出筆數
--USE AdventureWorks2022
--GO

--SET NOCOUNT ON --不顯示XXX個資料列受到影響

---- 宣告變數
--DECLARE @Date AS DATETIME
--DECLARE @NumTran INT
--DECLARE @NumSales INT

----值存到變數中
--SET	@Date = '2014-05-31'

----取得總筆數
--SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate >= @Date)
--SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate >= @Date)

--PRINT 'Number of transactions = ' + CAST(@NumTran AS VARCHAR(MAX)) --不能字串 + 數字所以要CAST
--PRINT 'Number of Sales = ' + CAST(@NumSales AS VARCHAR(MAX)) --顯示Sales Order交易數量

-- 4. 把某一筆紀錄的資料存入一組變數中，方便在後續程序中使用這些資料。
/*
這種用法適合需要重複使用查詢結果的情況，
因為將查詢結果存入變數後，便可以在儲存程序中方便地使用這些資料，
而不需要再次從資料表查詢。
*/

--USE AdventureWorks2022
--GO

--DECLARE @SalesOrderID INT
--DECLARE @ProdName VARCHAR(MAX)
--DECLARE @OrderDate DATETIME

--SELECT TOP 1
--	@SalesOrderID = so.SalesOrderID,
--	@ProdName = p.Name,
--	@OrderDate = so.OrderDate
--FROM
--	Sales.SalesOrderHeader so
--	INNER JOIN Sales.SalesOrderDetail sod ON so.SalesOrderID = sod.SalesOrderID
--	INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
--WHERE
--	so.OrderDate >= '2012-01-01'
--ORDER BY
--	so.OrderDate DESC

--SELECT @SalesOrderID, @ProdName, @OrderDate

-- 5. 收集變數中的值
--USE AdventureWorks2022
--GO

--DECLARE @ProdList VARCHAR(MAX)
--SET @ProdList = ''

--SELECT 
--	@ProdList = @ProdList + NAME + ', ' + CHAR(10)
--FROM
--	Production.Product
--WHERE
--	YEAR(SellStartDate) = 2008

--PRINT @ProdList

-- 6. 全域變數
--SELECT @@SERVERNAME
--SELECT @@VERSION
--SELECT * FROM Production.Product
--SELECT @@ROWCOUNT


