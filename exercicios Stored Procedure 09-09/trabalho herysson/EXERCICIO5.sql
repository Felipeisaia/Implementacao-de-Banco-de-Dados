CREATE PROCEDURE Livros_Categoria @categoria VARCHAR (50)
AS
BEGIN
	SELECT * 
	FROM Livro AS L
	INNER JOIN Categoria AS C ON L.fk_categoria = C.id
	WHERE C.tipo_categoria = @categoria;


END

EXEC Livros_Categoria 'Ficção Científica';

