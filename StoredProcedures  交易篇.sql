-- ���եΪ���
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

--������P�_
--DECLARE @BookName INT

--BEGIN TRAN AddBook

--INSERT INTO dbo.books (book_name, sold_copies)
--VALUES ('book_6', 60)

----DELETE FROM dbo.books WHERE book_name = 'book_7';

--SELECT @BookName = COUNT(*) FROM books WHERE book_name = 'book_6';

--IF @BookName > 1
--	BEGIN
--		ROLLBACK�@TRAN AddBook
--		PRINT 'book_6 already exists'
--	END
--ELSE
--	BEGIN
--		COMMIT TRAN AddBook
--		PRINT 'book_6 was added to the books table'
--	END

--IF ELSE���|�O�@�Ӧn��k�ҥH�n��try catch
-- �إߦw���I��k SAVE TRAN ���~��^�u��@�w���w���I
BEGIN TRY
	BEGIN TRAN AddBook
	
		INSERT INTO books (book_name, sold_copies)
		VALUES ('book_7', 70)

	UPDATE books
	SET sold_copies = 'apple' --���]�o�̿��~�|�ߥX�ҥ~
	WHERE book_name = 'book_7'

	COMMIT TRAN AddBook

END TRY
BEGIN CATCH --������ѫ�n�����Ʊ�
	ROLLBACK TRAN AddBook --�ߥX���~��ROLLBACK
	PRINT 'Adding new book failed'
END CATCH

SELECT * FROM books WHERE book_name = 'book_7'