USE AdventureWorks2022
GO

-- 談有關output的議題
ALTER PROC spSellStartInYear
	(
		@Year INT,
		@ProductList VARCHAR(MAX) OUTPUT,
		@ProductCount INT OUTPUT
	)
AS
BEGIN

	DECLARE @Products VARCHAR(MAX)
	SET @Products = ''

	SELECT
		@Products = @Products + NAME +', '
	FROM
		Production.Product
	WHERE
		YEAR(SellStartDate) = @Year
	ORDER BY
		Name ASC

	SET @ProductCount = @@ROWCOUNT
	SET @ProductList = @Products
END

--呼叫檢索輸出參數的結果
DECLARE @ProdNames VARCHAR(MAX)
DECLARE @Count INT

EXEC spSellStartInYear 
	@Year = 2013, 
	@ProductList = @ProdNames OUTPUT,
	@ProductCount = @Count OUTPUT

SELECT @Count AS [Number of Products], @ProdNames AS [List of Products]

/*
輸出參數: 可以有很多個跟任意type
回傳變數: 只能有一個必須指定type

*/