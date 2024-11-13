USE AdventureWorks2022
GO

-- ======================
-- 第一個觸發器: 部門資料變更提示
-- ======================

-- 建立觸發器（註解掉的原始版本）
-- CREATE TRIGGER trgDepartmentModified
-- ON HumanResources.Department
-- AFTER INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     PRINT 'A change was made to the HumanResources.Department table'
-- END

-- 關閉行數輸出
SET NOCOUNT ON;

-- 新增一筆記錄到 HumanResources.Department 表
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')

-- 更新 HumanResources.Department 表中的記錄
UPDATE HumanResources.Department
SET ModifiedDate = GETDATE()
WHERE DepartmentID = 7

-- 刪除 HumanResources.Department 表中的記錄
DELETE FROM HumanResources.Department
WHERE GroupName = 'Data Science'

-- 修改觸發器: 更新訊息提示
ALTER TRIGGER [HumanResources].[trgDepartmentModified] 
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    PRINT 'A change occurred to the HumanResources.Department table'
END

-- 刪除觸發器（註解掉的原始版本）
-- DROP TRIGGER [HumanResources].[trgDepartmentModified] 

-- ======================
-- INSTEAD OF / RAISERROR 說明
-- ======================

/*
INSTEAD OF 觸發器是一種特殊的觸發器，用來在特定事件發生時執行自定義邏輯，取代原本應執行的操作。
常見用途包括更新或刪除某些資料時的限制條件，或是對試圖進行某些修改的 SQL 查詢進行預處理。

RAISERROR 是用來在 SQL Server 中拋出自定義錯誤訊息的語法，可以用來傳遞特定的錯誤碼、訊息和嚴重性。
例：RAISERROR ('An error occurred in the process.', 16, 1);
錯誤訊息：可以定義錯誤訊息，最多 4000 個字元。
嚴重性 (Severity)：定義錯誤的嚴重性級別（0-25）。一般錯誤使用 16。
狀態碼 (State)：用來表示錯誤的狀態，方便在多層次除錯時辨識不同狀態的錯誤情境。
*/

-- 建立 INSTEAD OF INSERT 觸發器（註解掉的原始版本）
-- CREATE TRIGGER trgDepartmentInserted
-- ON HumanResources.Department
-- INSTEAD OF INSERT
-- AS
-- BEGIN
--     RAISERROR('Cannot insert a new department', 16, 1)
-- END

-- ======================
-- 測試區域
-- ======================

-- 關閉行數輸出
SET NOCOUNT ON;

-- 嘗試在 HumanResources.Department 表中插入一筆新記錄
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')

-- 查詢 HumanResources.Department 表中名稱為 'Data Engineering' 的記錄
SELECT * FROM HumanResources.Department WHERE Name = 'Data Engineering'

-- 修改觸發器: 在插入後查詢新插入的資料
ALTER TRIGGER HumanResources.trgDepartmentInserted
ON HumanResources.Department
AFTER INSERT
AS
BEGIN
    SELECT * FROM inserted
END

-- 插入新的部門記錄
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('DevOps Engineer', 'DevOps & SRE')
GO

--DDL Trigger
--CREATE TRIGGER trgNewTablesNotAllowed
--ON DATABASE  --整個資料庫都要遵守以下規定
--FOR　CREATE_TABLE
--AS
--BEGIN
--	PRINT 'Please do not create new table'
--	ROLLBACK
--END

----測試
--USE Lab
--GO

--CREATE TABLE Lab(ID INT)
--GO

--sp_tables 'Lab'

--修改DDL trigger
--ALTER TRIGGER trgNewTablesNotAllowed
--ON DATABASE  --整個資料庫都要遵守以下規定
--FOR　CREATE_TABLE
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

--暫時禁用trigger
--tigger >> 又鍵 >> 停用
--DISABLE TRIGGER trgNewTablesNotAllowed ON DATABASE 停用
--ENABLE TRIGGER trgNewTablesNotAllowed ON DATABASE 啟用
-- DISABLE TRIGGER ALL ON DATABASE 禁用全部
-- ENABLE TRIGGER ALL ON DATABASE 啟用全部
-- 將ON DATABASE 換成  ON  ALL SERVER 是全伺服器的指令