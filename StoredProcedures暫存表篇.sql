/*
1. Tempdb僅對建立他的表連接可見
2. 命名可重複_______後會有唯一識別符 
*/

-- 建立暫存表第一種方法
--SELECT 
--	NAME,
--	SellStartDate
--INTO #TempName -- 暫存到表內
--FROM
--	Production.Product
--WHERE
--	Name LIKE '%Thin%'
--SELECT * FROM #TempName --從暫存區中找東西


-- 建立暫存表第二種方法
IF OBJECT_ID('tempdb..#TempName') IS NOT NULL
	DROP TABLE #TempName
GO

CREATE TABLE #TempName
(
	Name VARCHAR(MAX),
	SellStarDate DATETIME
)
INSERT INTO #TempName
SELECT
	Name,
	SellStartDate
FROM 
	Production.Product
WHERE
	Name LIKE '%Thin%'

SELECT * FROM #TempName