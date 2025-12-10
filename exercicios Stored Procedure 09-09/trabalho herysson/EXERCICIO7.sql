CREATE PROCEDURE Ano_Livros @ano INT
AS
BEGIN 

	SELECT*
	FROM Livro
	WHERE ano = @ano;

END

EXEC Ano_Livros '2015';