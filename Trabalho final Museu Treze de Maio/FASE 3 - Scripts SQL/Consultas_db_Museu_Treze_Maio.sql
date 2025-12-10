-- 10 CONSULTAS SQL
--1. View: Livros publicados após 2010 que tratam do tema "História Afro-Brasileira"
CREATE OR ALTER VIEW VW_Livros_Tema_Ano AS
SELECT 
    ia.id_item_acervo,
    ia.titulo,
    p.ano,
    a.descricao AS assunto
FROM ITEM_ACERVO ia
JOIN LIVRO l ON l.id_item_acervo = ia.id_item_acervo
JOIN PUBLICACAO p ON p.id_item_acervo = ia.id_item_acervo
JOIN LIVRO_ASSUNTO la ON la.id_livro = ia.id_item_acervo
JOIN ASSUNTO a ON a.id_assunto = la.id_assunto;
GO

SELECT *
FROM VW_Livros_Tema_Ano
WHERE ano > 2010
  AND assunto = 'História Afro-Brasileira';


-- 2. Listar todos os documentos históricos doados por um doador específico
SELECT 
    ia.titulo,
    ia.data_aquisicao,
    d.nome AS doador,
    ih.descricao
FROM ITEM_ACERVO ia
JOIN ITEM_HISTORICO ih ON ih.id_item_acervo = ia.id_item_acervo
JOIN DOADOR d ON d.id_doador = ia.id_doador
WHERE d.nome = 'Acervo da Comunidade Negra';


--3. Qual o autor com mais livros cadastrados?
DECLARE @maior INT;

SELECT @maior = COUNT(*)
FROM LIVRO_AUTOR
GROUP BY id_autor
ORDER BY COUNT(*) ASC;

SELECT 
    au.nome AS autor,
    COUNT(*) AS total_livros
FROM LIVRO_AUTOR la
JOIN AUTOR au ON au.id_autor = la.id_autor
GROUP BY au.nome
HAVING COUNT(*) = @maior;

-- 4.Quais itens históricos ainda não foram digitalizados?
SELECT 
    ia.id_item_acervo,
    ia.titulo,
    ia.data_aquisicao,
    ia.link_midia
FROM ITEM_ACERVO ia
JOIN ITEM_HISTORICO ih ON ih.id_item_acervo = ia.id_item_acervo
WHERE ia.link_midia IS NULL;

-- 5.Livros por autor
CREATE OR ALTER PROCEDURE SP_LivrosPorAutor
    @autor VARCHAR(200)
AS
BEGIN
    SELECT 
        ia.titulo,
        a.nome AS autor
    FROM ITEM_ACERVO ia
    JOIN LIVRO_AUTOR la ON la.id_livro = ia.id_item_acervo
    JOIN AUTOR a ON a.id_autor = la.id_autor
    WHERE a.nome = @autor
    ORDER BY ia.titulo;
END;
GO
--chamada do procedure
EXEC SP_LivrosPorAutor 'Conceição Evaristo';

-- 6.Listar total de obras por assunto
SELECT 
    ass.descricao AS assunto,
    COUNT(*) AS qtd_livros
FROM LIVRO_ASSUNTO la
JOIN ASSUNTO ass ON ass.id_assunto = la.id_assunto
GROUP BY ass.descricao
HAVING COUNT(*) >= 2
ORDER BY qtd_livros DESC;

--7.Listar todos os livros com seus autores
SELECT 
    ia.titulo,
    au.nome AS autor
FROM ITEM_ACERVO ia
JOIN LIVRO_AUTOR la ON la.id_livro = ia.id_item_acervo
JOIN AUTOR au ON au.id_autor = la.id_autor
ORDER BY ia.titulo;

--8.Listar periódicos e seus exemplares
SELECT 
    ia.titulo AS periodico,
    ex.volume,
    ex.numero_exemplar,
    ex.ano_publicacao
FROM PERIODICO p
JOIN ITEM_ACERVO ia ON ia.id_item_acervo = p.id_item_acervo
LEFT JOIN EXEMPLAR ex ON ex.id_periodico = p.id_item_acervo
ORDER BY ia.titulo, ex.ano_publicacao DESC;

--9. Itens do acervo ordenados por tipo, título e data
SELECT 
    ia.titulo,
    ia.tipo_item,
    ia.data_aquisicao,
    (SELECT COUNT(*) 
     FROM PUBLICACAO p 
     WHERE p.id_item_acervo = ia.id_item_acervo) AS qtd_publicacoes
FROM ITEM_ACERVO ia
ORDER BY 
    CASE ia.tipo_item
        WHEN 'Livro' THEN 1
        WHEN 'Periodico' THEN 2
        WHEN 'ItemHistorico' THEN 3
    END,
    ia.titulo;

--10.Log de alterações
SELECT 
    l.id_log,
    l.operacao,
    l.data_operacao,
    u.login_usuario AS usuario,
    ia.titulo AS item
FROM LOG_OPERACAO l
JOIN USUARIO u ON u.id_usuario = l.id_usuario
LEFT JOIN ITEM_ACERVO ia ON ia.id_item_acervo = l.id_item_acervo
ORDER BY l.data_operacao DESC;
