CREATE DATABASE db_museu_treze_maio;
USE db_museu_treze_maio;

---Criacao Tabela Doador
CREATE TABLE DOADOR (
    id_doador INT IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    CONSTRAINT PK_Doador PRIMARY KEY (id_doador),
    CONSTRAINT UQ_Doador_Nome UNIQUE (nome)
);
GO

---Criacao Tabela Usuario
CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1),
    login_usuario VARCHAR(30) NOT NULL,
    senha VARCHAR(150) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario),
    CONSTRAINT UQ_Usuario_Login UNIQUE (login_usuario),
    CONSTRAINT CHK_Tipo_usuario CHECK (tipo_usuario IN ('Administrador', 'Visitante'))
);
GO

---Criacao Tabela Autor
CREATE TABLE AUTOR (
    id_autor INT IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    CONSTRAINT PK_Autor PRIMARY KEY (id_autor)
);
GO

---Criacao Tabela Assunto
CREATE TABLE ASSUNTO (
    id_assunto INT IDENTITY(1,1),
    descricao VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Assunto PRIMARY KEY (id_assunto),
    CONSTRAINT UQ_Assunto_Descricao UNIQUE (descricao)
);
GO

---Criacao Tabela Serie
CREATE TABLE SERIE (
    id_serie INT IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Serie PRIMARY KEY (id_serie),
    CONSTRAINT UQ_Serie_Nome UNIQUE (nome)
);
GO

---Criacao Tabela Pai Item Acervo
CREATE TABLE ITEM_ACERVO (
    id_item_acervo INT IDENTITY(1,1),
    titulo VARCHAR(400) NOT NULL,
    data_aquisicao DATE NOT NULL,
    tipo_item VARCHAR(30) NOT NULL,
    link_midia VARCHAR(2048) NULL,
    CONSTRAINT PK_ItemAcervo PRIMARY KEY (id_item_acervo),
    CONSTRAINT CHK_ItemAcervo_Tipo CHECK (tipo_item IN ('Livro', 'Periodico', 'ItemHistorico')) 
);
GO

-- Altera Tabela Item Acervo para inserir a rela��o com Doador
ALTER TABLE ITEM_ACERVO 
    ADD id_doador INT,
    CONSTRAINT FK_ItemAcervo_Doador FOREIGN KEY (id_doador) REFERENCES DOADOR(id_doador);
GO

--Criacao Tabela Log Operacao
CREATE TABLE LOG_OPERACAO (
    id_log INT IDENTITY(1,1),
    operacao VARCHAR(100) NOT NULL,
    data_operacao DATETIME NOT NULL,
    id_usuario INT NOT NULL,
    id_item_acervo INT,
    CONSTRAINT PK_Log PRIMARY KEY (id_log),
    CONSTRAINT FK_Log_Usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_Log_ItemAcervo FOREIGN KEY (id_item_acervo) REFERENCES ITEM_ACERVO(id_item_acervo) ON DELETE SET NULL
);
GO

--Criacao Tabela Publicacao
CREATE TABLE PUBLICACAO (
    id_publicacao INT IDENTITY(1,1),
    local_publicacao VARCHAR(255),
    editora VARCHAR(100),
    ano INT,
    id_item_acervo INT NOT NULL,
    CONSTRAINT PK_Publicacao PRIMARY KEY (id_publicacao),
    CONSTRAINT FK_Publicacao_ItemAcervo FOREIGN KEY (id_item_acervo) REFERENCES ITEM_ACERVO(id_item_acervo) ON DELETE CASCADE
);
GO

---Criacao Tabela Especializada Livro
CREATE TABLE LIVRO (
    id_item_acervo INT,
    local_chamada VARCHAR(50) NOT NULL,
    edicao VARCHAR(100),
    desc_fisica VARCHAR(300),
    notas VARCHAR(MAX),
    serie_descricao VARCHAR(100), 
    titulo_original VARCHAR(200),
    isbn VARCHAR(100),
    id_serie INT,
    CONSTRAINT PK_Livro PRIMARY KEY (id_item_acervo),
    CONSTRAINT UQ_Livro_ISBN UNIQUE (isbn),
    CONSTRAINT FK_Livro_ItemAcervo FOREIGN KEY (id_item_acervo) REFERENCES ITEM_ACERVO(id_item_acervo) ON DELETE CASCADE,
    CONSTRAINT FK_Livro_Serie FOREIGN KEY (id_serie) REFERENCES SERIE(id_serie)
);
GO

--Criacao Tabela Associataiva Livro Autor
CREATE TABLE LIVRO_AUTOR (
    id_autor INT,
    id_livro INT,
    CONSTRAINT PK_LivroAutor PRIMARY KEY (id_autor, id_livro),
    CONSTRAINT FK_LivroAutor_Autor FOREIGN KEY (id_autor) REFERENCES AUTOR(id_autor),
    CONSTRAINT FK_LivroAutor_Livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_item_acervo) ON DELETE CASCADE
);
GO

--Criacao Tabela Associativa Livro Assunto
CREATE TABLE LIVRO_ASSUNTO (
    id_assunto INT,
    id_livro INT,
    CONSTRAINT PK_LivroAssunto PRIMARY KEY (id_assunto, id_livro),
    CONSTRAINT FK_LivroAssunto_Assunto FOREIGN KEY (id_assunto) REFERENCES ASSUNTO(id_assunto),
    CONSTRAINT FK_LivroAssunto_Livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_item_acervo) ON DELETE CASCADE
);
GO

---Criacao Tabela Especializada Periodico
CREATE TABLE PERIODICO (
    id_item_acervo INT,
    issn VARCHAR(100),
    periodicidade VARCHAR(100) NOT NULL,
    data_inicio_publicacao DATE,
    data_fim_publicacao DATE,
    titulo_original VARCHAR(200),
    CONSTRAINT PK_Periodico PRIMARY KEY (id_item_acervo),
    CONSTRAINT UQ_Periodico_Issn UNIQUE (issn),
    CONSTRAINT FK_Periodico_ItemAcervo FOREIGN KEY (id_item_acervo) REFERENCES ITEM_ACERVO(id_item_acervo) ON DELETE CASCADE
);
GO

--Criacao Tabela Exemplar
CREATE TABLE EXEMPLAR (
    id_exemplar INT IDENTITY(1,1),
    volume VARCHAR(100),
    numero_exemplar VARCHAR(100),
    ano_publicacao INT,
    local_chamada VARCHAR(50) NOT NULL,
    id_periodico INT NOT NULL,
    CONSTRAINT PK_Exemplar PRIMARY KEY (id_exemplar),
    CONSTRAINT FK_Exemplar_Periodico FOREIGN KEY (id_periodico) REFERENCES PERIODICO (id_item_acervo) ON DELETE CASCADE
);
GO

-- Criacao da Tabela Especializada Item Historico
CREATE TABLE ITEM_HISTORICO (
    id_item_acervo INT,
    data_criacao DATE,
    descricao VARCHAR(MAX),
    dimensoes VARCHAR(50),
    material VARCHAR(100),
    local_armazenado VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ItemHistorico PRIMARY KEY (id_item_acervo),
    CONSTRAINT FK_ItemHistorico_ItemAcervo FOREIGN KEY (id_item_acervo) REFERENCES ITEM_ACERVO(id_item_acervo) ON DELETE CASCADE
);
GO

-- Trigger para inserir registros na tabela LOG_OPERACAO, sempre que houver INSERT ou UPDATE em ITEM_ACERVO
CREATE OR ALTER TRIGGER TRG_Registra_Operacao_Insert_Update_ItemAcervo
ON ITEM_ACERVO
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @id_usuario_logado INT = 1; -- ID DO ADMIN

    -- Verifica se foi realizado um INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO LOG_OPERACAO (operacao, data_operacao, id_usuario, id_item_acervo)
        SELECT 'INSERT - Novo item criado: ' + i.titulo, GETDATE(), @id_usuario_logado, i.id_item_acervo
        FROM inserted i;
    END

    -- Verifica se foi um UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO LOG_OPERACAO (operacao, data_operacao, id_usuario, id_item_acervo)
        SELECT 'UPDATE - Item "' + d.titulo + '" foi atualizado.', GETDATE(), @id_usuario_logado, i.id_item_acervo
        FROM inserted i INNER JOIN deleted d ON i.id_item_acervo = d.id_item_acervo;
    END
END;
GO

-- Trigger INSTEAD OF DELETE para deletar registros de forma segura no banco
CREATE OR ALTER TRIGGER TRG_Registra_Operacao_Delete_ItemAcervo
ON ITEM_ACERVO
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @id_usuario_logado INT = 1; -- ID DO ADMIN

    INSERT INTO LOG_OPERACAO (operacao, data_operacao, id_usuario, id_item_acervo)
    SELECT 'DELETE - Item removido: ' + d.titulo, GETDATE(), @id_usuario_logado, d.id_item_acervo
    FROM deleted d;

    DELETE FROM ITEM_ACERVO
    WHERE id_item_acervo IN (SELECT id_item_acervo FROM deleted);
END;
GO
