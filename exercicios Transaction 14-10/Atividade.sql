USE EMPRESA;

BEGIN TRY
  SELECT 1 / 0; 
  PRINT 'Não chegarei aqui';
END TRY
BEGIN CATCH
  PRINT 'Deu erro!';
  PRINT 'Número: ' + CAST(ERROR_NUMBER() AS varchar(10));
  PRINT 'Mensagem: ' + ERROR_MESSAGE();
END CATCH;


--------------------------------------


SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;

SELECT * 
FROM dbo.FUNCIONARIO;

PRINT 'SELECT concluído em: ' + CONVERT(varchar(23), SYSDATETIME(), 121);
RAISERROR('Segurando locks por 10s...', 0, 1) WITH NOWAIT;


WAITFOR DELAY '00:00:20';

COMMIT TRAN;
PRINT 'COMMIT em: ' + CONVERT(varchar(23), SYSDATETIME(), 121);

BEGIN TRANSACTION;

INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('João', 'D', 'Santos', '11122233344', '1988-03-22', 'Rua C, 789', 'M', 4000, NULL, 2);

COMMIT TRANSACTION;


--------------------------------


BEGIN TRANSACTION;

INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('Ana', 'E', 'Costa', '55544433322', '1987-09-01', 'Rua D, 321', 'F', 4500, NULL, 2);

COMMIT TRANSACTION;

SELECT * FROM FUNCIONARIO WHERE Cpf = '55544433322';


----------------------------------



--Exercicio 1:


INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Financeiro', 9);


BEGIN TRANSACTION;

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Logística', 10);


ROLLBACK TRANSACTION;

SELECT Dnumero, Dnome
FROM DEPARTAMENTO
WHERE Dnumero IN (9, 10);


--Exercicio 3:

BEGIN TRANSACTION;

UPDATE FUNCIONARIO
SET Endereco = 'Av. Brasil, 1000, São Paulo, SP'
WHERE Cpf = '12345678966';

SELECT Pnome, Unome, Endereco
FROM FUNCIONARIO
WHERE Cpf = '12345678966';

COMMIT TRANSACTION;
ROLLBACK TRANSACTION;

SELECT Pnome, Unome, Endereco
FROM FUNCIONARIO
WHERE Cpf = '12345678966';
