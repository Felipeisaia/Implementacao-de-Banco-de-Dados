-- exercicios em aula:

--exercicio1:
CREATE FUNCTION fn_SalarioAnualComBonus(
	@Salario DECIMAL(10,2),
	@BonusPercentual DECIMAL(5,2)
)
RETURNS DECIMAL (10,2)
AS
BEGIN
	DECLARE @SalarioAnual DECIMAL(10,2);

	SET @SalarioAnual = (@Salario * 12) * (1 + @BonusPercentual);

	RETURN @SalarioAnual;

END;

SELECT Pnome,
	   Unome,
	   Salario,
	   dbo.fn_SalarioAnualComBonus(Salario, 10) AS Salario_Anual_10_porcento,
	   dbo.fn_SalarioAnualComBonus(Salario, 20) AS Salario_Anual_20_porcento
FROM FUNCIONARIO;

--exercicio 2:

CREATE FUNCTION fn_funcionariosDepartamento(@NomeDpt VARCHAR(15))
RETURNS TABLE
AS
RETURN
(
SELECT F.Pnome, F.Unome, F.Salario
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = @NomeDpt
);
GO

SELECT * FROM dbo.fn_funcionariosDepartamento('Pesquisa');

SELECT *
FROM FUNCIONARIO,DEPARTAMENTO

-exercicio 3:

CREATE FUNCTION fn_SalarioAnual(@Cpf VARCHAR(11))
RETURNS @Tabela TABLE
(
NomeCompleto Varchar(150),
SalarioMensal DECIMAL(10,2),
SalarioAnual DECIMAL(10,2)
)
AS
BEGIN
	INSERT INTO @Tabela
	SELECT CONCAT(Pnome, '  ', Unome),
	Salario, Salario * 12
	FROM FUNCIONARIO AS F;
	WHERE F.Cpf = @Cpf

	RETURN;
END;

SELECT * FROM dbo.fn_SalarioAnual()



-- exercicios do git:

-- questão 1:
CREATE FUNCTION fn_projetosPorFuncionario (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN
(
    SELECT P.Projnome
    FROM TRABALHA_EM T
    INNER JOIN PROJETO P
        ON T.Pnr = P.Projnumero
    WHERE T.Fcpf = @Cpf
);
GO

SELECT * 
FROM dbo.fn_projetosPorFuncionario('12345678966');


-- questão 2:
CREATE FUNCTION fn_listardependentes (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN
(
    SELECT Nome_dependente, Parentesco
    FROM DEPENDENTE
    WHERE Fcpf = @Cpf
);
GO

SELECT * 
FROM dbo.fn_listardependentes('33344555587');

-- questão 3:
CREATE FUNCTION fn_nomesupervisor (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        S.Pnome + ' ' + S.Minicial + '. ' + S.Unome AS NomeCompleto
    FROM FUNCIONARIO F
    INNER JOIN FUNCIONARIO S
        ON F.Cpf_supervisor = S.Cpf
    WHERE F.Cpf = @Cpf
);
GO

SELECT * 
FROM dbo.fn_nomesupervisor('98765432168');

--questão 9:

CREATE FUNCTION fn_custodepartamento (@Dnumero INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Custo DECIMAL(10,2);

    SELECT @Custo = SUM(Salario)
    FROM FUNCIONARIO
    WHERE Dnr = @Dnumero;

    -- Se não houver funcionários, vai retornar 0
    IF @Custo IS NULL
        SET @Custo = 0;

    RETURN @Custo;
END;
GO

SELECT dbo.fn_custodepartamento(5) AS CustoDepartamento;


--questão 10:
SELECT 
    D.Dnumero,
    D.Dnome,
    dbo.fn_custodepartamento(D.Dnumero) AS CustoMensal
FROM DEPARTAMENTO D;
