USE AdventureWorks2022

--�ŧi�Ȧs��
DECLARE @TempProducts TABLE
(
	Name VARCHAR(MAX),
	SellStartDate DATETIME
)

--�N��Ʃ�J�ܼƪ�
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
�Q��: @TempTable �� #TempTable �F��

�H�U�O `@Tempdb` �M `#Tempdb` �������G

| �S��                   | `@Tempdb`�]�ܼƪ�^                    | `#Tempdb`�]�{�ɪ�^                                |
|------------------------|---------------------------------------|----------------------------------------------------|
| **�w�q**               | `DECLARE @Tempdb TABLE (...)`         | `CREATE TABLE #Tempdb (...)`                       |
| **�@�νd��**           | ��e�妸�B��Ʃ��x�s�L�{��           | ��e�|�ܡ]Session�^�A�Y�ϥ� `##` �h������@��       |
| **�x�s��m**           | �O����                                | `tempdb` ��Ʈw                                    |
| **�A�θ�ƶ�**         | �p����ƶ�                            | �j����ƶ�                                        |
| **���ޤ䴩**           | ���䴩 `CREATE INDEX`�A�Ȥ䴩 Primary Key �� Unique Constraint | �䴩�h�د��ޡA�A�X�i������d��                     |
| **��ƪ�ާ@�䴩**     | ���䴩 ALTER TABLE �����c�ܧ�       | �䴩 ALTER TABLE �����c�ܧ�                       |
| **�ʯ�**               | �O����ާ@�A�A�X�p���ƾڳB�z�A�į���� | �s�b��ϺСA�i�B�z���j�q��ơA���|���� I/O �귽       |
| **�A�α���**           | ²��B�u�Ȫ���ƳB�z                  | �����B�h�B�J�ާ@�A�λݻP��L�x�s�L�{�@�ɪ����      |

### �ϥΫ�ĳ

- **`@Tempdb`**�G�A�X�p���ƾڶ��A�u�ȩ�²���ƳB�z�A�L�ݽ����ާ@�ɨϥΡC
- **`#Tempdb`**�G�A�X�j���ƾڶ��A�ݭn�i��h���d�ߡB���ީν����ާ@�ɨϥΡC
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
		AND JobTitle = 'Production Technician - W50'  -- �󥿤F "Techician" �� "Technician"

	INSERT INTO @t
	SELECT 
		LoginID,
		HireDate,
		'Quality Assurance Technician'
	FROM
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = @HireYear
		AND JobTitle = 'Quality Assurance Technician'  -- �󥿤F "Techician" �� "Technician"
	
	RETURN
END

SELECT
	LoginID,
	HireDate,
	JobTitle
FROM
	dbo.EmployeeHireYear(2009)