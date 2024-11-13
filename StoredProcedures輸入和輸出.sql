USE AdventureWorks2022
GO

-- �ͦ���output��ĳ�D
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

--�I�s�˯���X�Ѽƪ����G
DECLARE @ProdNames VARCHAR(MAX)
DECLARE @Count INT

EXEC spSellStartInYear 
	@Year = 2013, 
	@ProductList = @ProdNames OUTPUT,
	@ProductCount = @Count OUTPUT

SELECT @Count AS [Number of Products], @ProdNames AS [List of Products]

/*
��X�Ѽ�: �i�H���ܦh�Ӹ���Ntype
�^���ܼ�: �u�঳�@�ӥ������wtype

*/