--DECLARE @NumProducts INT

--SET @NumProducts = (SELECT COUNT(*) 
--					FROM Production.ProductSubcategory 
--					WHERE ProductCategoryID = 4)

---- IFªº©w¸q
--IF @NumProducts > 20
--	BEGIN
--		PRINT 'CAUTION!'
--		PRINT 'There are too many accessories'
--	END
--ELSE
--	BEGIN
--		PRINT 'VERIFICATION'
--		PRINT 'There are no more than  accessories'
--	END

--±äª¬IF
--DECLARE @Accesories INT
--DECLARE @Clothing INT

--SET @Accesories = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 4)
--SET @Clothing = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 2)

--IF @Accesories > 7
--	BEGIN
--		PRINT 'CAUTION!'
--		PRINT 'There are too many accessories'
--		IF @Clothing > 10
--			BEGIN
--				PRINT 'Good, we have enough clothing items to compenstate for it'
--			END
--		ELSE
--			BEGIN
--				PRINT 'There are not enough clothing products'
--			END
--	END
--ELSE
--	BEGIN
--		PRINT 'VERIFICATION'
--		PRINT 'There are no more than  accessories'
--	END

ALTER PROC spGenderData
	(
		@GetInfo VARCHAR(10)
	)
AS
BEGIN
	IF @GetInfo = 'ALL'
		BEGIN
			(SELECT * FROM HumanResources.Employee)
			RETURN
		END

	IF @GetInfo = 'FEMALE'
		BEGIN
			(SELECT * FROM HumanResources.Employee WHERE Gender = 'F')
			RETURN
		END
	
	IF @GetInfo = 'MALE'
		BEGIN
			(SELECT * FROM HumanResources.Employee WHERE Gender = 'M')
			RETURN
		END

	SELECT 'Please choose ALL,FEMALE or  MALE'

END

EXEC spGenderData @GetInfo = 'MALE'