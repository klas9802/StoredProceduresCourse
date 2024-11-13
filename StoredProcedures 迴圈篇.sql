--DECLARE @Marker INT
--DECLARE @MaxVacationHours INT
--DECLARE @NumEmployees INT

--SET @MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)
--SET @Marker = 0

--WHILE @Marker <= @MaxVacationHours
--	BEGIN
--		SET @NumEmployees =
--			(SELECT COUNT(*) FROM HumanResources.Employee WHERE VacationHours = @Marker)
		
--		--IF @Marker = 20
--		--BREAK
		
--		PRINT 
--			CAST(@NumEmployees AS VARCHAR(3)) + 'employees still hava'+
--			CAST(@Marker AS VARCHAR(2)) + 'Vacatiom Hours'

--		--SET @Marker = @Marker +1
--	END

-- CURSOR用法
DECLARE @ProductCategoryID INT
DECLARE @ProdCatName VARCHAR(MAX)

/*ProdCatCursor 是一個游標，用來遍歷 
Production.ProductCategory 表中的每一行。*/
DECLARE ProdCatCursor CURSOR FOR
	SELECT ProductCategoryID, Name FROM Production.ProductCategory

--OPEN 指令用於打開游標，讓它準備好開始遍歷查詢結果。
OPEN ProdCatCursor

/*
FETCH NEXT 指令用於從游標中提取下一行數據，並將 ProductCategoryID 和 Name 欄位的值分別儲存在變數 @ProductCategoryID 和 @ProdCatName 中。 
這行是第一次提取操作，之後的每次提取都在 WHILE 迴圈中進行。
*/
FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName

/*
@@FETCH_STATUS 系統變數會指示 FETCH 操作的狀態。如果值為 0，表示成功提取一行；如果為 -1 或 -2，則表示到達游標的末尾或沒有更多行。
只要 @@FETCH_STATUS 為 0，WHILE 迴圈就會繼續執行。
*/
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Subcategories in Category' + @ProdCatName
		SELECT Name FROM Production.ProductSubcategory WHERE ProductCategoryID = @ProductCategoryID
		
		--每次迴圈結束時，FETCH NEXT 會提取下一行數據，將其存入 @ProductCategoryID 和 @ProdCatName，以便在下一次迴圈中使用。
		FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName
	END

CLOSE ProdCatCursor
DEALLOCATE ProdCatCursor
/*
CLOSE 關閉游標，使游標不可再用。
DEALLOCATE 釋放游標資源，徹底移除游標。
*/