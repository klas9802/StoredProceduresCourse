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

-- CURSOR�Ϊk
DECLARE @ProductCategoryID INT
DECLARE @ProdCatName VARCHAR(MAX)

/*ProdCatCursor �O�@�Ӵ�СA�ΨӹM�� 
Production.ProductCategory �����C�@��C*/
DECLARE ProdCatCursor CURSOR FOR
	SELECT ProductCategoryID, Name FROM Production.ProductCategory

--OPEN ���O�Ω󥴶}��СA�����ǳƦn�}�l�M���d�ߵ��G�C
OPEN ProdCatCursor

/*
FETCH NEXT ���O�Ω�q��Ф������U�@��ƾڡA�ñN ProductCategoryID �M Name ��쪺�Ȥ��O�x�s�b�ܼ� @ProductCategoryID �M @ProdCatName ���C 
�o��O�Ĥ@�������ާ@�A���᪺�C���������b WHILE �j�餤�i��C
*/
FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName

/*
@@FETCH_STATUS �t���ܼƷ|���� FETCH �ާ@�����A�C�p�G�Ȭ� 0�A��ܦ��\�����@��F�p�G�� -1 �� -2�A�h��ܨ�F��Ъ������ΨS����h��C
�u�n @@FETCH_STATUS �� 0�AWHILE �j��N�|�~�����C
*/
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Subcategories in Category' + @ProdCatName
		SELECT Name FROM Production.ProductSubcategory WHERE ProductCategoryID = @ProductCategoryID
		
		--�C���j�鵲���ɡAFETCH NEXT �|�����U�@��ƾڡA�N��s�J @ProductCategoryID �M @ProdCatName�A�H�K�b�U�@���j�餤�ϥΡC
		FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName
	END

CLOSE ProdCatCursor
DEALLOCATE ProdCatCursor
/*
CLOSE ������СA�ϴ�Ф��i�A�ΡC
DEALLOCATE �����и귽�A����������СC
*/