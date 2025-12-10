/* Questão 1

R: Transações são operações planejadas e personalizaveis no banco de dados. 
Elas são usadas para garatir que ações complexas sejam executadas corretamente e de forma segura.
Com isso, é possivel controlar melhor as operações e  assegurar que tudo seja concluido de maneira
consistente e confiavel;

Propiedades acid:
			Atomicidade: A transação é tudo ou nada, se uma parte falhar, tudo é cancelado.
			Consistencia: Após a transação, o banco deve continuar válido e com regras respeitadas. Nada fica incoerente.
			Isolamento: Uma transação não interfere na outra, mesmo que aconteça ao mesmo temo.
			Durabilidade: Depois de concluida, a transação é permanente, mesmo se o sistema cair ou desligar.
*/

-- Questão 2

BEGIN TRANSACTION atualizacao;
	declare @preco_Venda INT;

	SELECT @preco_Venda = PrecoVenda
	FROM Produtos
	WHERE Descricao = 'Caneta BIC cristal';

	IF EXISTS (SELECT 6 FROM Produtos WHERE @preco_Venda = PrecoVenda)
	BEGIN
		UPDATE Produtos
		SET PrecoVenda = 5.00
		WHERE Produtos.Descricao = 'Caneta BIC cristal';
		COMMIT TRANSACTION
	END

	ELSE
	BEGIN
		PRINT 'Produto não existente';
		ROLLBACK TRANSACTION;
	END
	



/* Questao 3

R: Triggers são mecanismos automaticos que são ativads no banco de dados qando uma condição especifica
ocorre ou quando uma ação é executada. Elas podem ser disparadas antes ou depois de operações como inserir,
atualizar ou excluir dados.
*/

-- questao 4

/* CREATE OR ALTER TRIGGER dbo.verifica_estoque
ON dbo.Vendas
*/




-- Questao 5

/*CREATE OR ALTER TRIGGER LogID
ON Produtos
AFTER INSERT 
AS 
BEGIN
	DECARE @
	*/




-- Questao 6

CREATE OR ALTER TRIGGER trg_inativarCliente
ON clientes
AFTER UPDATE
AS
BEGIN
	declare @clienteID INT;

	SELECT @clienteID = I.ClienteID
	FROM INSERTED AS I;
	
	insert into Clientes
	values (@clienteID, 'update');
END
UPDATE Clientes
SET Status = 'i'
WHERE ClienteID = 1;



/* Questao 7

R: Elas asseguram a integridade dos dados. São essenciais porque podem, ou não, permitir a remoção de informações que estão sendo
utilizadas em outras tabelas.
*/

-- Questao 8

ALTER TABLE ItensVenda
WITH CHECK ADD CONSTRAINT fk_CodigoBarras
FOREIGN KEY (CodigoBarras) REFERENCES produtos(CodigoBarras)
ON UPDATE CASCADE;

UPDATE Produtos
SET CodigoBarras = '111111111'
WHERE CodigoBarras = '0005113190827'

SELECT * FROM Produtos

-- Agora o identificador poderá fazer a atualização, caso a logistica recis corrigir o Codigo de barras.


/* Questao 9

R: Views são consultas prontas que facilitam o acesso aos dados. Elas permitem criar pesquisas especificas, reutilizaveis 
e com possiveis filtros de restrição. São muito uteis para consultas frequentes ou padroes de pesquisas recorrentes.
*/

-- Questao 10

CREATE OR ALTER VIEW vw_RelatorioDetalhadoVendas
AS

SELECT V.VendaID,
	   V.DataVenda,
	   C.Nome AS 'NomeCliente',
	   P.Nome AS 'NomeProduto',
	   C.Nome AS 'NomeCategoria',
	   I.Quantidade,
	   I.PrecoUnitario AS 'PrecoVendaUnitario'

FROM Clientes AS C
JOIN Vendas AS V ON C.ClienteID = V.ClienteID
JOIN ItensVenda AS I ON V.VendaID = I.VendaID
JOIN Produtos AS P ON I.CodigoBarras = P.CodigoBarras
GO

-- Questao 11

/*SELECT *
FROM vw_RelatorioDetalhadoVendas;
*/

-- Questao 12

CREATE OR ALTER VIEW vw_ProductCatalog
AS

SELECT P.Nome AS 'NomeProduto',
	   C.Nome as 'NomeCategoria',
	   P.PrecoVenda

FROM Produtos AS P
JOIN Categorias AS C ON P.CategoriaID = C.CategoriaID
GO

SELECT * FROM vw_ProductCatalog



select * from Clientes
select * from Produtos
select * from Vendas
select * from ItensVenda
select * from Clientes
