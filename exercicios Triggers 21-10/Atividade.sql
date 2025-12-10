USE BIBLIOTECA;
GO


-- Exercicio 1
CREATE OR ALTER TRIGGER trg_Livro_NoTituloDuplicado
ON dbo.Livro
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN dbo.Livro l ON l.titulo = i.titulo AND l.isbn <> i.isbn
    )
    OR EXISTS (
        SELECT 1
        FROM inserted i1
        JOIN inserted i2 ON i1.titulo = i2.titulo AND i1.isbn <> i2.isbn
    )
    BEGIN
        RAISERROR ('Não é permitido inserir livros com TÍTULO repetido.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


-- Exercicio 2
CREATE OR ALTER TRIGGER trg_Livro_AnoAtualAoInserir
ON dbo.Livro
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE l
       SET l.ano = YEAR(GETDATE())
    FROM dbo.Livro l
    JOIN inserted i ON i.isbn = l.isbn;
END;
GO

-- Exercicio 3
CREATE OR ALTER TRIGGER trg_Livro_ApagaVinculosAutor
ON dbo.Livro
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE la
      FROM dbo.LivroAutor la
      JOIN deleted d ON d.isbn = la.fk_livro;
END;
GO

-- Exercicios 4
IF COL_LENGTH('dbo.Categoria', 'total_livros') IS NULL
    ALTER TABLE dbo.Categoria ADD total_livros INT NOT NULL CONSTRAINT DF_Categoria_TotalLivros DEFAULT(0);
GO

CREATE OR ALTER TRIGGER trg_Categoria_ContaAoInserirLivro
ON dbo.Livro
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
       SET c.total_livros = v.qtd
    FROM dbo.Categoria c
    JOIN (
        SELECT fk_categoria, COUNT(*) AS qtd
        FROM dbo.Livro
        GROUP BY fk_categoria
    ) v ON v.fk_categoria = c.id
    WHERE c.id IN (SELECT DISTINCT fk_categoria FROM inserted);
END;
GO

-- Exercicio 5
CREATE OR ALTER TRIGGER trg_Categoria_BloqueiaDeleteSeTemLivro
ON dbo.Categoria
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN dbo.Livro l ON l.fk_categoria = d.id
    )
    BEGIN
        RAISERROR ('Não é permitido excluir categorias com livros associados.', 16, 1);
        RETURN;
    END

    DELETE c
      FROM dbo.Categoria c
      JOIN deleted d ON d.id = c.id;
END;
GO

-- Exercicio 6
IF OBJECT_ID('dbo.Livro_Auditoria') IS NULL
BEGIN
    CREATE TABLE dbo.Livro_Auditoria
    (
        id_aud        INT IDENTITY PRIMARY KEY,
        isbn          VARCHAR(50) NOT NULL,
        titulo_antigo VARCHAR(100) NULL,
        titulo_novo   VARCHAR(100) NULL,
        ano_antigo    INT NULL,
        ano_novo      INT NULL,
        fk_editora_ant INT NULL,
        fk_editora_novo INT NULL,
        fk_categoria_ant INT NULL,
        fk_categoria_novo INT NULL,
        data_alteracao DATETIME NOT NULL DEFAULT(GETDATE()),
        usuario        SYSNAME NULL DEFAULT(SUSER_SNAME())
    );
END
GO

CREATE OR ALTER TRIGGER trg_Livro_AuditoriaUpdate
ON dbo.Livro
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Livro_Auditoria
        (isbn, titulo_antigo, titulo_novo, ano_antigo, ano_novo,
         fk_editora_ant, fk_editora_novo, fk_categoria_ant, fk_categoria_novo)
    SELECT
        i.isbn,
        d.titulo, i.titulo,
        d.ano,    i.ano,
        d.fk_editora, i.fk_editora,
        d.fk_categoria, i.fk_categoria
    FROM inserted i
    JOIN deleted  d ON d.isbn = i.isbn;
END;
GO

-- Exercicio 7
IF COL_LENGTH('dbo.Autor', 'total_livros') IS NULL
    ALTER TABLE dbo.Autor ADD total_livros INT NOT NULL CONSTRAINT DF_Autor_TotalLivros DEFAULT(0);
GO

CREATE OR ALTER TRIGGER trg_Autor_ContaAoVincularLivro
ON dbo.LivroAutor
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE a
       SET a.total_livros = x.qtd
    FROM dbo.Autor a
    JOIN (
        SELECT fk_autor, COUNT(*) AS qtd
        FROM dbo.LivroAutor
        GROUP BY fk_autor
    ) x ON x.fk_autor = a.id
    WHERE a.id IN (SELECT DISTINCT fk_autor FROM inserted);
END;
GO
