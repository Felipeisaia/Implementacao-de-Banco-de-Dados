ALTER PROCEDURE Inserir_Categoria
AS
BEGIN
	INSERT INTO Categoria (tipo_categoria)
	VALUES ('Suspense');

		
END

EXEC Inserir_Categoria;

SELECT * FROM Categoria;