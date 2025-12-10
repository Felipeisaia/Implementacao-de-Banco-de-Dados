--Insercao de dados nas tabelas 

-- AUTORES
INSERT INTO AUTOR (nome) VALUES
('Machado de Assis'),
('George Orwell'),
('J.K. Rowling'),
('Isaac Asimov'),
('J.R.R. Tolkien'),
('Clarice Lispector'),
('Santo Agostinho'),
('Djamila Ribeiro'),
('Conceição Evaristo'),
('Nei Lopes'),
('Kabengele Munanga'),
('Lélia Gonzalez');

-- ASSUNTOS
INSERT INTO ASSUNTO (descricao) VALUES
('Literatura Brasileira'),
('Distopia'),
('Fantasia'),
('Romance'),
('Ficção Científica'),
('Suspense Psicológico'),
('História Afro-Brasileira'),
('Cultura Negra no Brasil'),
('Movimento Negro'),
('Sociologia'),
('Filosofia Africana');

-- SERIES
INSERT INTO SERIE (nome) VALUES
('Harry Potter'),
('O Senhor dos Anéis'),
('Fundação'),
('As Crônicas de Nárnia'),
('Duna'),
('O Guia do Mochileiro das Galáxias'),
('Jogos Vorazes'),
('Biblioteca Negra'),
('Pensadores Africanos');

-- DOADORES
INSERT INTO DOADOR (nome) VALUES
('Família Imperial Brasileira'),
('Colecionador Anônimo'),
('Acervo da Comunidade Negra'),
('Fundação Palmares');

-- USUARIOS
INSERT INTO USUARIO (login_usuario, senha, tipo_usuario) VALUES
('admin', 'admin123', 'Administrador'),
('visitante', 'visit321', 'Visitante');

-- ITEM_ACERVO (LIVROS + PERIÓDICOS + HISTÓRICOS)
INSERT INTO ITEM_ACERVO (titulo, data_aquisicao, tipo_item, link_midia, id_doador) VALUES
('Dom Casmurro', '2023-01-10', 'Livro', NULL, 2),
('Harry Potter e a Pedra Filosofal', '2023-02-15', 'Livro', NULL, NULL),
('1984', '2023-03-20', 'Livro', NULL, NULL),
('Eu, Robô', '2023-04-05', 'Livro', NULL, NULL),
('A Sociedade do Anel', '2023-05-12', 'Livro', NULL, NULL),
('A Hora da Estrela', '2023-06-18', 'Livro', NULL, NULL),
('Memórias Póstumas de Brás Cubas', '2023-07-22', 'Livro', NULL, NULL),
('Comentário aos Salmos (Salmos 101-150)', '2025-11-29', 'Livro', '/media/comentario_salmos_agostinho.jpg', NULL),
('O que é Lugar de Fala?', '2023-08-02', 'Livro', NULL, 3),
('Quarto de Despejo', '2022-04-20', 'Livro', NULL, 4),
('Olhos d’Água', '2022-10-20', 'Livro', NULL, 3),
('Introdução ao Pensamento Negro Contemporâneo', '2024-02-10', 'Livro', NULL, 4),
('A História da África', '2024-03-12', 'Livro', NULL, 3),
('Revista de História da Biblioteca Nacional', '2024-05-20', 'Periodico', NULL, NULL),
('National Geographic Brasil', '2024-06-01', 'Periodico', NULL, NULL),
('Moeda de 40 Réis do Império', '2022-03-11', 'ItemHistorico', NULL, 1),
('Fotografia da Irmandade do Rosário', '2021-06-10', 'ItemHistorico', NULL, 1),
('Documento da Sociedade Protetora dos Homens Pretos', '2021-07-11', 'ItemHistorico', NULL, 3),
('Recibo de Alforria (Reprodução)', '2022-01-05', 'ItemHistorico', NULL, 4);

-- LIVRO (especialização)
INSERT INTO LIVRO (id_item_acervo, local_chamada, edicao, desc_fisica, isbn, id_serie) VALUES
(1,'869.93-3 ASS','3ª','256 p.','978-8535914849',NULL),
(2,'82-93 ROW','1ª','223 p.','978-8532530783',1),
(3,'82-311.9 ORW','Edição Especial','416 p.','978-8535914856',NULL),
(4,'82-311.9 ASI','1ª','224 p.','978-8576572008',NULL),
(5,'82-93 TOL','1ª','576 p.','978-8595084759',2),
(6,'869.93-3 LIS','Edição Comemorativa','88 p.','978-8532507167',NULL),
(7,'869.93-3 ASS','2ª','240 p.','978-8535914832',NULL),
(8,'223.2 AGO','1ª','600 p.','978-8534920739',NULL),
(9,'305.8 RIB','1ª','120 p.','978-8598349641',8),
(10,'869.93 JES','1ª','240 p.','978-8535912357',NULL),
(11,'869.93 EVA','1ª','140 p.','978-8535934328',8),
(12,'305.8 MUN','1ª','310 p.','978-8578312310',9),
(13,'960 HIS','2ª','500 p.','978-8573832121',9);

-- PERIODICO
INSERT INTO PERIODICO (id_item_acervo, issn, periodicidade, data_inicio_publicacao) VALUES
(14,'1808-4001','Mensal','2005-01-01'),
(15,'1517-7211','Mensal','2000-05-01');

-- ITEM_HISTORICO (especialização)
INSERT INTO ITEM_HISTORICO (id_item_acervo, data_criacao, descricao, material, local_armazenado) VALUES
(16,'1831-01-01','Moeda de 40 Réis do Império do Brasil.','Cobre','Sala de Numismática'),
(17,'1890-01-01','Fotografia da Irmandade do Rosário.','Papel Fotográfico','Arquivo Fotográfico'),
(18,'1888-05-10','Documento da Sociedade Protetora dos Homens Pretos.','Papel','Arquivo Histórico'),
(19,'1870-09-20','Recibo de alforria pertencente a família negra tradicional.','Papel','Arquivo Documental');

-- LIVRO_AUTOR
INSERT INTO LIVRO_AUTOR (id_livro, id_autor) VALUES
(1,1),(2,3),(3,2),(4,4),(5,5),(6,6),(7,1),(8,7),
(9,8),(10,9),(11,9),(12,10),(13,11);

-- LIVRO_ASSUNTO
INSERT INTO LIVRO_ASSUNTO (id_livro, id_assunto) VALUES
(1,1),(1,4),
(2,3),
(3,2),(3,5),
(4,5),
(5,3),
(6,1),
(7,1),(7,4),
(9,7),(9,8),
(10,1),
(11,8),(11,9),
(12,10),(12,11),
(13,7);

-- PUBLICACAO
INSERT INTO PUBLICACAO (id_item_acervo, editora, local_publicacao, ano) VALUES
(1,'Garnier','Rio de Janeiro',1899),
(2,'Rocco','Rio de Janeiro',2000),
(3,'Companhia Editora Nacional','São Paulo',1952),
(14,'SABIN','Rio de Janeiro',2024),
(15,'Editora Abril','São Paulo',2024),
(9,'Pólen','São Paulo',2017),
(10,'Ática','São Paulo',1960),
(11,'Pallas','Rio de Janeiro',2014),
(12,'UFBA','Salvador',2011),
(13,'Ática','São Paulo',2008);

-- EXEMPLAR
INSERT INTO EXEMPLAR (id_periodico, volume, numero_exemplar, ano_publicacao, local_chamada) VALUES
(14,'Ano 19','220',2024,'PER 001'),
(15,'Ano 25','292',2024,'PER 002'),
(14,'Ano 20','221',2025,'PER 003'),
(15,'Ano 26','293',2025,'PER 004');