-- �Ĥ@��CTE
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

-- �ר�: �C��P��H����ID�������P�ⶵ�ؼ�
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

-- �}�n�g�k��CTE
--WITH ItemCounts(SalesPerson, NumberOfItemsSold) AS --CTE��[�Ѽ�
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
--	-- AVG(NumberOfItemsSold)  �L�ġA�]�����å��]�t�b�J�`�禡�� GROUP BY �l�y���C
--	--��W�g�i�H
--FROM
--	ItemCounts


--�h��CTE
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
