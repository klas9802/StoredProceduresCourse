USE AdventureWorks2022

--宣告暫存表
DECLARE @TempProducts TABLE
(
	Name VARCHAR(MAX),
	SellStartDate DATETIME
)

--將資料放入變數表中
INSERT INTO @TempProducts
SELECT
	Name,
	SellStartDate
FROM
	Production.Product
WHERE
	SellStartDate < '2012-01-01'

SELECT * FROM @TempProducts

/*
討論: @TempTable 跟 #TempTable 東西

以下是 `@Tempdb` 和 `#Tempdb` 的比較表：

| 特性                   | `@Tempdb`（變數表）                    | `#Tempdb`（臨時表）                                |
|------------------------|---------------------------------------|----------------------------------------------------|
| **定義**               | `DECLARE @Tempdb TABLE (...)`         | `CREATE TABLE #Tempdb (...)`                       |
| **作用範圍**           | 當前批次、函數或儲存過程內           | 當前會話（Session），若使用 `##` 則為全域共享       |
| **儲存位置**           | 記憶體                                | `tempdb` 資料庫                                    |
| **適用資料集**         | 小型資料集                            | 大型資料集                                        |
| **索引支援**           | 不支援 `CREATE INDEX`，僅支援 Primary Key 或 Unique Constraint | 支援多種索引，適合進行複雜查詢                     |
| **資料表操作支援**     | 不支援 ALTER TABLE 等表結構變更       | 支援 ALTER TABLE 等表結構變更                       |
| **性能**               | 記憶體操作，適合小型數據處理，效能較佳 | 存在於磁碟，可處理較大量資料，但會佔用 I/O 資源       |
| **適用情境**           | 簡單、短暫的資料處理                  | 複雜、多步驟操作，或需與其他儲存過程共享的資料      |

### 使用建議

- **`@Tempdb`**：適合小型數據集，短暫或簡單資料處理，無需複雜操作時使用。
- **`#Tempdb`**：適合大型數據集，需要進行多重查詢、索引或複雜操作時使用。
*/

/* 
	* value function
	ex: dbo.fnLengthyDate(SellStartDate)

CREATE FUNCTION SellStartDateInYear
(
	@SellStartDateYear INT
)
RETURNS TABLE
AS
RETURN
	SELECT
		Name,
		SellStartDate,
		ListPrice
	FROM
		Production.Product
	WHERE
		YEAR(SellStartDate) = @SellStartDateYear

SELECT
	Name,
	SellStartDate,
	ListPrice
FROM
	SellStartDateInYear(2011)
---

ALTER FUNCTION SellStartDateInYear
(
	@SellStartYear INT,
	@SellEndYear INT
)
RETURNS TABLE
AS
RETURN
	SELECT
		Name,
		SellStartDate,
		ListPrice
	FROM
		Production.Product
	WHERE
		YEAR(SellStartDate) BETWEEN @SellStartYear AND @SellEndYear

SELECT
	Name,
	SellStartDate,
	ListPrice
FROM
	SellStartDateInYear(2012,2015)  
*/

CREATE FUNCTION dbo.EmployeeHireYear(@HireYear INT)
RETURNS @t TABLE
(
	LoginID VARCHAR(MAX),
	HireDate DATETIME,
	JobTitle VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @t
	SELECT 
		LoginID,
		HireDate,
		'Production Technician - W50'
	FROM
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = @HireYear
		AND JobTitle = 'Production Technician - W50'  -- 更正了 "Techician" 為 "Technician"

	INSERT INTO @t
	SELECT 
		LoginID,
		HireDate,
		'Quality Assurance Technician'
	FROM
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = @HireYear
		AND JobTitle = 'Quality Assurance Technician'  -- 更正了 "Techician" 為 "Technician"
	
	RETURN
END

SELECT
	LoginID,
	HireDate,
	JobTitle
FROM
	dbo.EmployeeHireYear(2009)