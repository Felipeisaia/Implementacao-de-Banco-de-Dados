CREATE PROCEDURE  Excluir_Autor @id_autor INT
AS 
BEGIN
	DELETE
	FROM LivroAutor
	WHERE fk_autor = @id_autor;

END

EXEC Excluir_Autor '4';

SELECT *
FROM LivroAutor;