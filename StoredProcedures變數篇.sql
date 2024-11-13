--USE AdventureWorks2022
--GO

---- 1. �ŧi�ܼ�
--DECLARE @Date AS DATETIME

----�Ȧs���ܼƤ�
--SET	@Date = '2014-05-31'

---- ������@���ܼ�
--SELECT 
--	TransactionID, TransactionDate, 'Transactions' AS [Type]
--FROM
--	Production.TransactionHistory
--WHERE
--	--TransactionDate >= '2012-05-31 00:00:00.000' --�R�A
--	TransactionDate >= @Date --�ʺA

--UNION ALL

--SELECT
--	SalesOrderID, OrderDate, 'SalesOrders'
--FROM
--	Sales.SalesOrderHeader
--WHERE
--	--OrderDate >= '2012-05-31 00:00:00.000'--�R�A
--	OrderDate >= @Date --�ʺA


---- 2. Query���G�s���ܼƤ���
---- ���]�ڭ̷Q���o�@�յ��G��������ƶq�M�P��ƶq
--USE AdventureWorks2022
--GO

---- �ŧi�ܼ�
--DECLARE @Date AS DATETIME
--DECLARE @NumTran INT
--DECLARE @NumSales INT

----�Ȧs���ܼƤ�
--SET	@Date = '2014-05-31'

----���o�`����
--SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate >= @Date)
--SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate >= @Date)

--SELECT 'Number of Transactions', @NumTran --���Transactions����ƶq
--UNION
--SELECT 'Number of Sales Order', @NumSales --���Sales Order����ƶq


---- ������@���ܼ�
--SELECT 
--	TransactionID, TransactionDate, 'Transactions' AS [Type]
--FROM
--	Production.TransactionHistory
--WHERE
--	--TransactionDate >= '2012-05-31 00:00:00.000' --�R�A
--	TransactionDate >= @Date --�ʺA

--UNION ALL

--SELECT
--	SalesOrderID, OrderDate, 'SalesOrders'
--FROM
--	Sales.SalesOrderHeader
--WHERE
--	--OrderDate >= '2012-05-31 00:00:00.000'--�R�A
--	OrderDate >= @Date --�ʺA


-- 3. �b�T����PRINT�X����
--USE AdventureWorks2022
--GO

--SET NOCOUNT ON --�����XXX�Ӹ�ƦC����v�T

---- �ŧi�ܼ�
--DECLARE @Date AS DATETIME
--DECLARE @NumTran INT
--DECLARE @NumSales INT

----�Ȧs���ܼƤ�
--SET	@Date = '2014-05-31'

----���o�`����
--SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate >= @Date)
--SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate >= @Date)

--PRINT 'Number of transactions = ' + CAST(@NumTran AS VARCHAR(MAX)) --����r�� + �Ʀr�ҥH�nCAST
--PRINT 'Number of Sales = ' + CAST(@NumSales AS VARCHAR(MAX)) --���Sales Order����ƶq

-- 4. ��Y�@����������Ʀs�J�@���ܼƤ��A��K�b����{�Ǥ��ϥγo�Ǹ�ơC
/*
�o�إΪk�A�X�ݭn���ƨϥάd�ߵ��G�����p�A
�]���N�d�ߵ��G�s�J�ܼƫ�A�K�i�H�b�x�s�{�Ǥ���K�a�ϥγo�Ǹ�ơA
�Ӥ��ݭn�A���q��ƪ�d�ߡC
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

-- 5. �����ܼƤ�����
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

-- 6. �����ܼ�
--SELECT @@SERVERNAME
--SELECT @@VERSION
--SELECT * FROM Production.Product
--SELECT @@ROWCOUNT


