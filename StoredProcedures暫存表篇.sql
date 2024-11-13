/*
1. Tempdb�ȹ�إߥL����s���i��
2. �R�W�i����_______��|���ߤ@�ѧO�� 
*/

-- �إ߼Ȧs��Ĥ@�ؤ�k
--SELECT 
--	NAME,
--	SellStartDate
--INTO #TempName -- �Ȧs���
--FROM
--	Production.Product
--WHERE
--	Name LIKE '%Thin%'
--SELECT * FROM #TempName --�q�Ȧs�Ϥ���F��


-- �إ߼Ȧs��ĤG�ؤ�k
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