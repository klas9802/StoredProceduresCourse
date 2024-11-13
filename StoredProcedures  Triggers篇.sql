USE AdventureWorks2022
GO

-- ======================
-- �Ĥ@��Ĳ�o��: ��������ܧ󴣥�
-- ======================

-- �إ�Ĳ�o���]���ѱ�����l�����^
-- CREATE TRIGGER trgDepartmentModified
-- ON HumanResources.Department
-- AFTER INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     PRINT 'A change was made to the HumanResources.Department table'
-- END

-- ������ƿ�X
SET NOCOUNT ON;

-- �s�W�@���O���� HumanResources.Department ��
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')

-- ��s HumanResources.Department �����O��
UPDATE HumanResources.Department
SET ModifiedDate = GETDATE()
WHERE DepartmentID = 7

-- �R�� HumanResources.Department �����O��
DELETE FROM HumanResources.Department
WHERE GroupName = 'Data Science'

-- �ק�Ĳ�o��: ��s�T������
ALTER TRIGGER [HumanResources].[trgDepartmentModified] 
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    PRINT 'A change occurred to the HumanResources.Department table'
END

-- �R��Ĳ�o���]���ѱ�����l�����^
-- DROP TRIGGER [HumanResources].[trgDepartmentModified] 

-- ======================
-- INSTEAD OF / RAISERROR ����
-- ======================

/*
INSTEAD OF Ĳ�o���O�@�دS��Ĳ�o���A�ΨӦb�S�w�ƥ�o�ͮɰ���۩w�q�޿�A���N�쥻�����檺�ާ@�C
�`���γ~�]�A��s�ΧR���Y�Ǹ�Ʈɪ��������A�άO��չ϶i��Y�ǭק諸 SQL �d�߶i��w�B�z�C

RAISERROR �O�ΨӦb SQL Server ���ߥX�۩w�q���~�T�����y�k�A�i�H�ΨӶǻ��S�w�����~�X�B�T���M�Y���ʡC
�ҡGRAISERROR ('An error occurred in the process.', 16, 1);
���~�T���G�i�H�w�q���~�T���A�̦h 4000 �Ӧr���C
�Y���� (Severity)�G�w�q���~���Y���ʯŧO�]0-25�^�C�@����~�ϥ� 16�C
���A�X (State)�G�ΨӪ�ܿ��~�����A�A��K�b�h�h�������ɿ��Ѥ��P���A�����~���ҡC
*/

-- �إ� INSTEAD OF INSERT Ĳ�o���]���ѱ�����l�����^
-- CREATE TRIGGER trgDepartmentInserted
-- ON HumanResources.Department
-- INSTEAD OF INSERT
-- AS
-- BEGIN
--     RAISERROR('Cannot insert a new department', 16, 1)
-- END

-- ======================
-- ���հϰ�
-- ======================

-- ������ƿ�X
SET NOCOUNT ON;

-- ���զb HumanResources.Department �����J�@���s�O��
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')

-- �d�� HumanResources.Department ���W�٬� 'Data Engineering' ���O��
SELECT * FROM HumanResources.Department WHERE Name = 'Data Engineering'

-- �ק�Ĳ�o��: �b���J��d�߷s���J�����
ALTER TRIGGER HumanResources.trgDepartmentInserted
ON HumanResources.Department
AFTER INSERT
AS
BEGIN
    SELECT * FROM inserted
END

-- ���J�s�������O��
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('DevOps Engineer', 'DevOps & SRE')
GO

--DDL Trigger
--CREATE TRIGGER trgNewTablesNotAllowed
--ON DATABASE  --��Ӹ�Ʈw���n��u�H�U�W�w
--FOR�@CREATE_TABLE
--AS
--BEGIN
--	PRINT 'Please do not create new table'
--	ROLLBACK
--END

----����
--USE Lab
--GO

--CREATE TABLE Lab(ID INT)
--GO

--sp_tables 'Lab'

--�ק�DDL trigger
--ALTER TRIGGER trgNewTablesNotAllowed
--ON DATABASE  --��Ӹ�Ʈw���n��u�H�U�W�w
--FOR�@CREATE_TABLE
--AS
--BEGIN
--	PRINT 'Please do not create new table or make change to existing tables'
--	ROLLBACK
--END

--USE AdventureWorks2022
--GO

--CREATE TABLE Lab(ID INT)
--GO

--sp_tables 'Lab'

--�ȮɸT��trigger
--tigger >> �S�� >> ����
--DISABLE TRIGGER trgNewTablesNotAllowed ON DATABASE ����
--ENABLE TRIGGER trgNewTablesNotAllowed ON DATABASE �ҥ�
-- DISABLE TRIGGER ALL ON DATABASE �T�Υ���
-- ENABLE TRIGGER ALL ON DATABASE �ҥΥ���
-- �NON DATABASE ����  ON  ALL SERVER �O�����A�������O