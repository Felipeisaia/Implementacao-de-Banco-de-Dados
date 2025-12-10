CREATE PROCEDURE Livro_Editora @editora VARCHAR (50)
AS
BEGIN
	SELECT *
	FROM Livro AS L
	JOIN Editora AS E ON L.fk_editora = E.id
	WHERE E.nome = @editora;

END

EXEC Livro_Editora @editora = 'Rocco';