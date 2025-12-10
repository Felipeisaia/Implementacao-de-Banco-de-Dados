ALTER PROCEDURE Atualizar_Livro
AS
BEGIN

	UPDATE Livro
	SET ano = '2024', fk_categoria = '6'
	WHERE isbn = '8532511015';


END

EXEC Atualizar_Livro;

SELECT * FROM Livro;

