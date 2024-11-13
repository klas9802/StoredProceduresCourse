-- 第一個CTE
--WITH SoldEarly AS
--(
--	SELECT
--		Name,
--		SellStartDate,
--		ListPrice
--	FROM
--		Production.Product
--)

--SELECT * FROM SoldEarly WHERE ListPrice > 200;

-- 案例: 每位銷售人員的ID的平均銷售項目數
--WITH ItemCounts AS
--(
--	SELECT
--		SalesPersonID,
--		COUNT(*) AS [NumberOfItemsSold]
--	FROM
--		Sales.Store
--	GROUP BY
--		SalesPersonID
--)
--SELECT
--	AVG(NumberOfItemsSold)
--FROM
--	ItemCounts

-- 良好寫法的CTE
--WITH ItemCounts(SalesPerson, NumberOfItemsSold) AS --CTE後加參數
--(
--	SELECT
--		SalesPersonID,
--		COUNT(*)
--	FROM
--		Sales.Store
--	GROUP BY
--		SalesPersonID
--)
--SELECT
--	SalesPerson,
--	NumberOfItemsSold
--	-- AVG(NumberOfItemsSold)  無效，因為它並未包含在彙總函式或 GROUP BY 子句中。
--	--單獨寫可以
--FROM
--	ItemCounts


--多重CTE
WITH Sales_CTE(SalesPersonID, TotalSales, SalesYear)
AS
(
	SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
		GROUP BY SalesPersonID, YEAR(OrderDate)
),
Sales_Quota_CTE(BusinessEntityID, SalesQuota, SalesQuotaYear)
AS
(
	SELECT BusinessEntityID, SUM(SalesQuota) AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear
	FROM Sales.SalesPersonQuotaHistory
	GROUP BY BusinessEntityID, Year(QuotaDate)
)
SELECT 
	SalesPersonID,
	SalesYear,
	TotalSales,
	SalesQuotaYear,
	SalesQuota
FROM
	Sales_CTE
	INNER JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID  = Sales_CTE.SalesPersonID
		AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear
ORDER BY
	SalesPersonID, SalesYear
