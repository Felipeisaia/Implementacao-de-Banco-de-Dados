GO
CREATE DATABASE VENDA;
GO
USE VENDA;
GO

-- Tabela de produtos
CREATE TABLE PRODUTO
(
	codigo INT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	categoria VARCHAR(25),
	preco DECIMAL(10,2) CHECK (preco >= 0)
);

-- Tabela de inventário
CREATE TABLE INVENTARIO
(
	id INT PRIMARY KEY IDENTITY(10,1),
	fk_idProduto INT NOT NULL,
	quantidade INT CHECK (quantidade >= 0),
	minLevel INT CHECK (minLevel >= 0),
	maxLevel INT CHECK (maxLevel >= 0),
	CONSTRAINT fk_inv_produto
		FOREIGN KEY (fk_idProduto)
		REFERENCES PRODUTO (codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- Tabela de vendas
CREATE TABLE VENDA
(
	id INT PRIMARY KEY IDENTITY,
	fk_idProduto INT NOT NULL,
	quantidade INT CHECK (quantidade > 0),
	total DECIMAL(10,2) CHECK (total >= 0)
);

ALTER TABLE VENDA
ADD CONSTRAINT fk_venda_prod
FOREIGN KEY (fk_idProduto)
REFERENCES PRODUTO (codigo)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO

-- Cadastro de produtos
INSERT INTO PRODUTO
VALUES	
(123, 'coca-cola KS', 'Bebida', 5.0),
(111, 'coca-cola lata', 'Bebida', 4.0),
(112, 'coca-cola lata 0', 'Bebida', 8.0),
(687, 'spaten 473ml', 'Bebida', 2.0),
(666, 'pinga 51', 'Bebida', 20.00),
(668, 'corote', 'Bebida', 3.00),
(777, 'energetico', 'Bebida', 9.0),
(999, 'joao andarilho', 'Bebida', 550.00);

-- Cadastro de inventário
INSERT INTO INVENTARIO (fk_idProduto, quantidade, minLevel, maxLevel)
VALUES
(123, 100, 30, 200),
(111, 200, 50, 500),
(112, 200, 50, 500),
(687, 1000, 500, 2000),
(666, 5, 2, 10),
(668, 15, 5, 20),
(777, 50, 30, 100),
(999, 20, 10, 25);

-- Teste da restrição CHECK (deve falhar)
INSERT INTO PRODUTO
VALUES (188, 'coca-cola 2L', 'Bebida', -15.00);

-- Consulta de produtos + inventário
SELECT 
	P.codigo,
	P.nome,
	I.quantidade,
	I.minLevel,
	I.maxLevel
FROM INVENTARIO AS I 
JOIN PRODUTO AS P ON I.fk_idProduto = P.codigo;
GO

SELECT * FROM INVENTARIO;

UPDATE PRODUTO
SET codigo = 0000
WHERE codigo = 666;

INSERT INTO VENDA
VALUES(666, 100, NULL);

---------------------------------------------------------
--- CRIAR UM TRIGGER QUE NÃO PERMITE VENDER MAIS QUE O ESTOQUE
---------------------------------------------------------
CREATE OR ALTER TRIGGER trg_verificaQuantidade
ON VENDA
AFTER INSERT 
AS 
BEGIN 
	SET NOCOUNT ON;

	DECLARE @qtdProduto INT,
			@codProduto INT,
			@qtdProdutoInv INT;

	SELECT @codProduto = i.fk_idProduto, @qtdProduto = i.quantidade
	FROM inserted AS i;

	SELECT @qtdProdutoInv = I.quantidade
	FROM INVENTARIO AS I
	WHERE I.fk_idProduto = @codProduto;

	IF @qtdProduto > @qtdProdutoInv
	BEGIN
		RAISERROR ('Nao ha produtos em estoque suficientes para esta venda',16,1);
		ROLLBACK TRANSACTION;
	END
	ELSE 
	BEGIN
		UPDATE INVENTARIO 
		SET quantidade = quantidade - @qtdProduto
		WHERE fk_idProduto = @codProduto;

		PRINT ('Venda realizada com sucesso !!!!');
	END
END;
GO