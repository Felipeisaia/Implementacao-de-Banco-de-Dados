ALTER PROCEDURE Livros_Autor @autor VARCHAR (50)
AS
BEGIN
	/*SELECT *
	FROM Autor AS A
	INNER JOIN LivroAutor AS LA ON LA.fk_autor = A.id
	WHERE A.id = @autor; */

	SELECT *
	FROM Livro AS L
	JOIN LivroAutor AS LA ON L.isbn = LA.fk_livro
	JOIN Autor AS A ON LA.fk_autor = A.id
	WHERE A.nome LIKE '%' + @autor + '%'

END

EXEC Livros_Autor @autor = 'Picasso';