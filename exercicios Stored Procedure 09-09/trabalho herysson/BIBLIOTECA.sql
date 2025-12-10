USE BIBLIOTECA;
/* Cria todas as tabelas do banco de dados - Categoria - Autor - Editora - Livro - LivroAutor */
CREATE TABLE Categoria (
  id INT NOT NULL IDENTITY,
  tipo_categoria VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE Autor (
  id INT NOT NULL IDENTITY,
  nome VARCHAR(100) NOT NULL,
  nacionalidade VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE Editora (
  id INT NOT NULL IDENTITY,
  nome VARCHAR(100) UNIQUE,
  PRIMARY KEY (id)
);

/* Tratamento do ISBN como varchar para armazenar valores maiores que int */
CREATE TABLE Livro (
  isbn VARCHAR(50) NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  ano INT NOT NULL,
  fk_editora INT NOT NULL,
  fk_categoria INT NOT NULL,
  PRIMARY KEY (isbn),
  CONSTRAINT FK_Livro_fk_categoria FOREIGN KEY (fk_categoria) REFERENCES Categoria(id),
  CONSTRAINT FK_Livro_fk_editora FOREIGN KEY (fk_editora) REFERENCES Editora(id)
);

CREATE TABLE LivroAutor (
  id INT NOT NULL IDENTITY,
  fk_autor INT NOT NULL,
  fk_livro VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_LivroAutor_fk_autor FOREIGN KEY (fk_autor) REFERENCES Autor(id),
  CONSTRAINT FK_LivroAutor_fk_livro FOREIGN KEY (fk_livro) REFERENCES Livro(isbn)
);

/* Insere valores na tabela Categoria */
INSERT INTO Categoria (tipo_categoria) VALUES ('Literatura Juvenil');
INSERT INTO Categoria (tipo_categoria) VALUES ('Ficção Científica');
INSERT INTO Categoria (tipo_categoria) VALUES ('Humor');
INSERT INTO Categoria (tipo_categoria) VALUES ('Ação');
INSERT INTO Categoria (tipo_categoria) VALUES ('Romance');

/* Altera o atributo da tabela Categoria onde o id é 3 */
UPDATE Categoria
SET tipo_categoria = 'Humor'
WHERE id = 3;

/* Insere valores na tabela Autor */
INSERT INTO Autor (nome) VALUES ('J.K. Rowling');
INSERT INTO Autor (nome, nacionalidade) VALUES ('Clive Staples Lewis', 'Inglaterra');
INSERT INTO Autor (nome, nacionalidade) VALUES ('Affonso Solano', 'Brasil');
INSERT INTO Autor (nome, nacionalidade) VALUES ('Marcos Piangers', 'Brasil');
INSERT INTO Autor (nome, nacionalidade) VALUES ('Ciro Botelho - Tiririca', 'Brasil');
INSERT INTO Autor (nome, nacionalidade) VALUES ('Bianca Müller', 'Brasil');

/* Insere valores na tabela Editora */
INSERT INTO Editora (nome) VALUES ('Rocco');
INSERT INTO Editora (nome) VALUES ('Wmf Martins Fontes');
INSERT INTO Editora (nome) VALUES ('Casa da Palavra');
INSERT INTO Editora (nome) VALUES ('Belas Letras');
INSERT INTO Editora (nome) VALUES ('Matrix');

/* Insere valores na tabela Livro */
INSERT INTO Livro VALUES('8532511015', 'Harry Potter e A Pedra Filosofal', 2000, 1, 1);
INSERT INTO Livro VALUES('9788578270698', 'As Crônicas de Nárnia', 2009, 2, 1);
INSERT INTO Livro VALUES('9788577343348', 'O Espadachim de Carvão', 2013, 3, 2);
INSERT INTO Livro VALUES('9788581742458', 'O Papai é Pop', 2015, 4, 3);
INSERT INTO Livro VALUES('9788582302026', 'Pior Que Tá Não Fica', 2015, 5, 3);
INSERT INTO Livro VALUES('9788577345670', 'Garota Desdobrável', 2015, 3, 1);
INSERT INTO Livro VALUES('8532512062', 'Harry Potter e o Prisioneiro de Azkaban', 2000, 1, 1);

/* Insere valores na tabela LivroAutor */
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('8532511015', 1);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('9788578270698', 2);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('9788577343348', 3);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('9788581742458', 4);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('9788582302026', 5);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('9788577345670', 6);
INSERT INTO LivroAutor (fk_livro, fk_autor) VALUES('8532512062', 1);

/* Remove o registro incorreto */
DELETE FROM LivroAutor WHERE fk_livro = '8532512062' AND fk_autor = 2;

/* Selects para verificação das tabelas */
SELECT * FROM Livro;
SELECT * FROM Autor;
SELECT * FROM Categoria;
SELECT * FROM Editora;
SELECT * FROM LivroAutor;

/* Recupera todos os livros da categoria "Literatura Juvenil" */
SELECT livro.titulo, categoria.tipo_categoria
FROM Livro livro
JOIN Categoria categoria ON livro.fk_categoria = categoria.id
WHERE categoria.tipo_categoria = 'Literatura Juvenil';

/* Recupera todos os livros escritos por J.K. Rowling */
SELECT livro.titulo, autor.nome
FROM LivroAutor livroautor
JOIN Livro livro ON livroautor.fk_livro = livro.isbn
JOIN Autor autor ON livroautor.fk_autor = autor.id
WHERE autor.nome LIKE '%Rowl%';

/* Ex. 7: Relaciona todos os dados dos livros disponíveis na biblioteca em ordem alfabética */
SELECT livro.isbn AS 'ISBN', livro.titulo AS 'Título', livro.ano AS 'Ano', 
  editora.nome AS 'Editora', categoria.tipo_categoria AS 'Categoria'
FROM Livro livro
JOIN Editora editora ON livro.fk_editora = editora.id
JOIN Categoria categoria ON livro.fk_categoria = categoria.id
ORDER BY livro.titulo;

/* Ex. 8: Relaciona todos os livros em ordem alfabética de Autor */
SELECT livro.isbn AS 'ISBN', livro.titulo AS 'Título', livro.ano AS 'Ano', 
  editora.nome AS 'Editora', CONCAT(autor.nome, ' (', autor.nacionalidade, ')') AS 'Autor/Nacionalidade', 
  categoria.tipo_categoria AS 'Categoria'
FROM Livro livro
JOIN Editora editora ON livro.fk_editora = editora.id
JOIN Categoria categoria ON livro.fk_categoria = categoria.id
JOIN LivroAutor livroautor ON livro.isbn = livroautor.fk_livro
JOIN Autor autor ON livroautor.fk_autor = autor.id
ORDER BY autor.nome;

/* Ex. 9: Livros da categoria de Literatura Juvenil em ordem de ano */
SELECT livro.isbn AS 'ISBN', livro.titulo AS 'Título', livro.ano AS 'Ano', 
  editora.nome AS 'Editora', CONCAT(autor.nome, ' (', autor.nacionalidade, ')') AS 'Autor/Nacionalidade', 
  categoria.tipo_categoria AS 'Categoria'
FROM Livro livro
JOIN Editora editora ON livro.fk_editora = editora.id
JOIN Categoria categoria ON livro.fk_categoria = categoria.id
JOIN LivroAutor livroautor ON livro.isbn = livroautor.fk_livro
JOIN Autor autor ON livroautor.fk_autor = autor.id
WHERE categoria.tipo_categoria LIKE '%Juve%'
ORDER BY livro.ano;

/* Ex. 10: Livros de humor ou ficção científica com ano entre 2000 e 2015 */
SELECT livro.isbn AS 'ISBN', livro.titulo AS 'Título', livro.ano AS 'Ano', 
  editora.nome AS 'Editora', CONCAT(autor.nome, ' (', autor.nacionalidade, ')') AS 'Autor/Nacionalidade', 
  categoria.tipo_categoria AS 'Categoria'
FROM Livro livro
JOIN Editora editora ON livro.fk_editora = editora.id
JOIN Categoria categoria ON livro.fk_categoria = categoria.id
JOIN LivroAutor livroautor ON livro.isbn = livroautor.fk_livro
JOIN Autor autor ON livroautor.fk_autor = autor.id
WHERE categoria.tipo_categoria IN ('Humor', 'Ficção Científica')
AND livro.ano BETWEEN 2000 AND 2015
ORDER BY livro.ano;
