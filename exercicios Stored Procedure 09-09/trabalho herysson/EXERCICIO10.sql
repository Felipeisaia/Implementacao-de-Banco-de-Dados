ALTER PROCEDURE Qtd_Livros_Categoria	
AS
BEGIN
	SELECT C.tipo_categoria, COUNT(L.isbn) AS 'Quantidade de livros'
	FROM LIVRO AS L
	JOIN Categoria AS C ON L.fk_categoria = C.id
	GROUP BY C.tipo_categoria;
	
END

EXEC Qtd_Livros_Categoria;
