-- �Ĥ@�ӰʺA�Ѽ�(��k�@)
--EXEC ('SELECT * FROM Production.Product')

-- UNICODE �r��}�Y�nN(��k�G)
--EXEC sp_executesql N'SELECT * FROM Production.Product'

/*
| �S��                          | `EXEC ('SELECT * FROM Production.Product')`                   | `EXEC sp_executesql N'SELECT * FROM Production.Product'`                           |
|-------------------------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------|
| **�ѼƤƬd�ߤ��**             | ���䴩�ѼƤơA�Ҧ��Ѽƻݪ����O�J SQL �r�ꤤ                 | �䴩�ѼƤơA�i�H�N�ѼƧ@���ܼƶǻ��A�����w���ʨí��C SQL �`�J���I                  |
| **�į�**                      | �C�����泣�|���s�ѪR�M�sĶ�d�ߡA�Ĳv���C                    | �䴩�֨��d�߭p���A��ۦP�d�ߴ�֭��s�sĶ�A�����į�                                 |
| **SQL �`�J���I**              | �����A�]���ܼƥ��������O�J SQL �r��                          | ���C�A�]�����\�ϥΰѼƤƪ��覡�ǻ��ܼ�                                             |
| **�ܼ�����**                  | ���䴩�ѼƤ��ܼƶǻ��A�ݭn�b�d�ߤ������g�J�ܼƭ�             | �䴩 Unicode �d�ߦr��M�Ѽ������A�Ϭd�ߧ��F��                                     |
| **���γ���**                  | �A�Ω󤣻ݭn�ѼƤƪ�²��d�ߩγ榸����                       | �A�Ω�ݭn�ѼƤơB�קK SQL �`�J�B���W�c���檺�d��                                 |
*/

-- SQL string concatenation

--DECLARE @TableName NVARCHAR(128)
--DECLARE @SQLString NVARCHAR(MAX)

--SET @TableName = N'Production.ProductDescription'
--SET @SQLString = ' SELECT * FROM ' + @TableName

--EXEC sp_executesql @SQLString

--�a�J�Ʀr�Ѽ�
--DECLARE @Number INT
--DECLARE @NumberString NVARCHAR(4)
--DECLARE @SQLString NVARCHAR(MAX)

--SET @Number = 5
--SET @NumberString = CAST(@Number AS NVARCHAR(4))

--SET @SQLString = 'SELECT TOP ' + @NumberString + '* FROM Production.Product ORDER BY SellStartDate DESC'

--EXEC sp_executesql @SQLString

--�a�@��store procedures
--CREATE PROC spTableVariable
--(
--	@TName NVARCHAR(128)
--)
--AS
--BEGIN
--	DECLARE @SQLString NVARCHAR(MAX)

--	SET @SQLString = N'SELECT * FROM ' + @TName

--	EXEC sp_executesql @SQLString
--END

--EXEC spTableVariable 'HumanResources.Employee'

--�a�h�ӰѼƪ� store procedures
--ALTER PROC spTableVariable
--(
--	@TName NVARCHAR(128),
--	@Number INT
--)
--AS
--BEGIN
--	DECLARE @SQLString NVARCHAR(MAX)
--	DECLARE @NumberStr NVARCHAR(6)

--	SET @NumberStr = CAST(@Number AS NVARCHAR(6))

--	SET @SQLString = N'SELECT TOP ' + @NumberStr +' * FROM ' + @TName

--	EXEC sp_executesql @SQLString
--END

--EXEC spTableVariable 'HumanResources.Employee',10

--����@��sp_executesql�Ѽ�
EXEC sp_executesql
	N'SELECT e.BussinessEntityID, p.FirstName, p.LastName
	FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
	WHERE e.BusinessEntityID > @BusinessEID
	AND p.FirstName LIKE @FirstLetter + ''%'''
	,N'@BusinessEID INT, @FirstLetter VARCHAR(3)' --�w�q�Ѽƫ��O
	,@BusinessEID = 200 --�ǤJ�Ѽƭ�
	,@FirstLetter = 'A'