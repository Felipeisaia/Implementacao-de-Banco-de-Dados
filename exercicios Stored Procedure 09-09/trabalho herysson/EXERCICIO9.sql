CREATE PROCEDURE Listar_Isbn
AS
BEGIN
	SELECT *
	FROM Livro
	WHERE isbn LIKE '9%8';

END

EXEC Listar_Isbn;