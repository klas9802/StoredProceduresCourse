-- 測試用的表
--IF OBJECT_ID(N'dbo.books', N'U') IS NOT NULL
--	DROP TABLE dbo.books;
--GO

--CREATE TABLE dbo.books
--(
--	id INT IDENTITY(1,1),
--	book_name VARCHAR(100) NOT NULL,
--	sold_copies INT NOT NULL
--);

--INSERT INTO dbo.books (book_name, sold_copies) VALUES
--('book_1', 10),
--('book_2', 20),
--('book_3', 30),
--('book_4', 40),
--('book_5', 50);

--SELECT * FROM books

--交易的判斷
--DECLARE @BookName INT

--BEGIN TRAN AddBook

--INSERT INTO dbo.books (book_name, sold_copies)
--VALUES ('book_6', 60)

----DELETE FROM dbo.books WHERE book_name = 'book_7';

--SELECT @BookName = COUNT(*) FROM books WHERE book_name = 'book_6';

--IF @BookName > 1
--	BEGIN
--		ROLLBACK　TRAN AddBook
--		PRINT 'book_6 already exists'
--	END
--ELSE
--	BEGIN
--		COMMIT TRAN AddBook
--		PRINT 'book_6 was added to the books table'
--	END

--IF ELSE不會是一個好方法所以要用try catch
-- 建立安全點方法 SAVE TRAN 錯誤後回滾到一定的安全點
BEGIN TRY
	BEGIN TRAN AddBook
	
		INSERT INTO books (book_name, sold_copies)
		VALUES ('book_7', 70)

	UPDATE books
	SET sold_copies = 'apple' --假設這裡錯誤會拋出例外
	WHERE book_name = 'book_7'

	COMMIT TRAN AddBook

END TRY
BEGIN CATCH --交易失敗後要做的事情
	ROLLBACK TRAN AddBook --拋出錯誤後ROLLBACK
	PRINT 'Adding new book failed'
END CATCH

SELECT * FROM books WHERE book_name = 'book_7'