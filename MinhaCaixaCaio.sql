SET DATEFORMAT YMD --setando o padr�o de data: ano, mes e dia
GO
USE master 
go
IF EXISTS (SELECT * FROM SYS.databases WHERE NAME = 'MinhaCaixa')
	BEGIN 
		ALTER DATABASE MinhaCaixa SET SINGLE_USER WITH ROLLBACK IMMEDIATE 
		DROP database MinhaCaixa
	END

CREATE DATABASE MinhaCaixa --criar o banco e nomear
GO 
USE MinhaCaixa --seleciona o banco criado
GO
--CRIANDO A TABELA 1 - GRUPO

CREATE TABLE Grupo --cria uma tabela no banco em que foi dado o comando USE
(
GrupoCodigo INT IDENTITY(1,1) CONSTRAINT /*restricao*/ PK_Grupo PRIMARY KEY, 
/*criando coluna acima tipo inteiro e com incremento iniciando em 1 e somand
1 a cada inser��o autom�tica no INSERT, com CONSTRAINT de chave prim�ria para
criar indice unico*/
GrupoNome VARCHAR(50),--VARCHAR = o tamanho � o dos dados inseridos
GrupoRazaoSocial VARCHAR(50),
GrupoCNPJ VARCHAR(20),
)
/*Usa-se PRIMARY KEY para identificar a linha de uma tabela
A variavel que carrega a PRIMARY � o identificador principal do indice da linha*/

INSERT Grupo --Inserir dados; n�o esquecer do VALUES ap�s inserir as colunas
			 --no INSERT
        (
		  --n�o inserir valor no IDENTITY (GrupoCodigo)	
          GrupoNome,
          GrupoRazaoSocial ,
          GrupoCNPJ
		)  
VALUES  (--colocar aspas simples ao declarar VALUES
		'MyBank',
		'MyBank International SA',
		'11.222.333/0001-44'
		)

CREATE TABLE CLIENTES
(
ClienteCodigo		int IDENTITY CONSTRAINT PK_CLIENTES PRIMARY KEY,
ClienteNome			VARCHAR(50),
ClienteRua			VARCHAR(50),
ClienteCidade		VARCHAR(50),
ClienteNascimento	DATETIME
)
--ON [PRIMARY] --modelo de dados (nao entendi)
--GO
INSERT CLIENTES VALUES ('Ana','XV de Novembro','Joinville','1980-08-06')
GO
insert Clientes values ('Laura','07 de Setembro','Blumenau','1981-08-08')
GO
insert Clientes values ('V�nia','01 de Maio','Blumenau','1982-08-06')
GO
insert Clientes values ('Franco','Felipe Schmidt','Florianopolis','1985-08-06')
GO
insert Clientes values ('Eduardo', 'Beria Mar Norte', 'Florian�polis','1970-11-10')
GO
insert Clientes values ('Bruno', '24 de maio','Crici�ma','1982-07-05')
GO
insert Clientes values ('Rodrigo','06 de agosto','Joinville','1981-08-06')
GO
insert Clientes values ('Ricardo','Jo�o Colin','Joinville','1980-02-15')
GO
insert Clientes values ('Alexandre','Margem esquerda','Blumenau','1980-03-07')
GO
insert Clientes values ('Luciana','Estreito','Florian�polis','1987-09-06')
GO
insert Clientes values ('Juliana','Iririu','Joinville','1970-01-06')
GO
insert Clientes values ('Pedro','Aventureiro','Joinville','1975-06-08')
GO
insert Clientes values ('Julia','Nova Bras�lia','Joinville','1985-03-18')
go

CREATE TABLE Agencias
(
AgenciaCodigo INT IDENTITY CONSTRAINT PK_Agencias PRIMARY KEY,
AgenciaNome VARCHAR (50),
AgenciaCidade varchar (50),
AgenciaFundos MONEY,
GrupoCodigo int
)
GO
ALTER TABLE Agencias ADD CONSTRAINT FK_GRUPOS_AGENCIAS FOREIGN KEY  (GrupoCodigo) REFERENCES Grupo
GO
INSERT Agencias VALUES  ('Verde Vale','Blumenau', 900000,1)
GO
INSERT Agencias VALUES  ('Cidade das Flores','Joinville', 800000,1)
GO
INSERT Agencias VALUES  ('Universit�ria', 'Florian�polis', 750000,1)
GO
INSERT Agencias VALUES  ('Joinville', 'Joinville', 950000,1)
GO
INSERT Agencias VALUES  ('Beira Mar', 'Florian�polis', 600000,1)
GO
INSERT Agencias VALUES  ('Crici�ma', 'Crici�ma', 500000,1)
GO
INSERT Agencias VALUES  ('Blumenau', 'Blumenau', 1100000,1)
GO
INSERT Agencias VALUES  ('Germ�nia', 'Blumenau', 400000,1)
GO

CREATE TABLE Contas
(
AgenciaCodigo int,
ContaNumero VARCHAR (10) CONSTRAINT PK_CONTA PRIMARY KEY,
ClienteCodigo int,
ContaSaldo MONEY,
ContaAbertura datetime
)
GO
ALTER TABLE Contas ADD CONSTRAINT FK_CLIENTES_CONTAS FOREIGN KEY  (ClienteCodigo) REFERENCES Clientes
GO
ALTER TABLE Contas ADD CONSTRAINT FK_AGENCIA_CONTAS FOREIGN KEY  (AgenciaCodigo) REFERENCES Agencias
GO
INSERT Contas VALUES  (4,'C-401',1,500,'2014-01-01')
GO
INSERT Contas VALUES  (4,'C-402',2,200,'2014-02-27')
GO
INSERT Contas VALUES  (4,'C-403',3,350,'2013-07-21')
GO
INSERT Contas VALUES  (4,'C-404',7,870,'2013-08-11')
GO
INSERT Contas VALUES  (1,'C-101',11,800,'2013-08-03')
GO
INSERT Contas VALUES(2,'C-201',4,800,'2013-04-12')
GO
INSERT Contas VALUES(3,'C-301',5,400,'2014-07-04')
GO
INSERT Contas VALUES(5,'C-501',6,300,'2011-03-23')
GO
INSERT Contas VALUES(6,'C-601',8,900,'2013-10-12')
GO
INSERT Contas VALUES(7,'C-701',9,550,'2011-09-02')
GO
INSERT Contas VALUES(8,'C-801',10,1000,'2007-08-01')
GO

create table Emprestimos
(
AgenciaCodigo INT,
ClienteCodigo int,
EmprestimoCodigo varchar (10),
EmprestimoTotal money
)
GO
ALTER TABLE Emprestimos ADD CONSTRAINT FK_EMPRESTIMOS_CLIENTES FOREIGN KEY  (ClienteCodigo) REFERENCES Clientes
GO
ALTER TABLE Emprestimos ADD CONSTRAINT FK_EMPRESTIMOS_AGENGIA FOREIGN KEY  (AgenciaCodigo) REFERENCES Agencias
GO
insert Emprestimos values (4,1,'L-10',2000)
GO
insert Emprestimos values (2,4,'L-20',1500)
GO
insert Emprestimos values (4,2,'L-15',1800)
GO
insert Emprestimos values (4,3,'L-30',2500)
GO
insert Emprestimos values (6,8,'L-40',3000)
GO
insert Emprestimos values (1,11,'L-35',2800)
GO
insert Emprestimos values (4,7,'L-50',2300)
GO

create table Depositantes
(
AgenciaCodigo INT,
ContaNumero varchar(10),
ClienteCodigo int,
DepositoValor MONEY,
DepositoData DATETIME
)
ALTER TABLE Depositantes ADD CONSTRAINT FK_CONTA_AGENGIA FOREIGN KEY  (AgenciaCodigo) REFERENCES Agencias
GO
ALTER TABLE Depositantes ADD CONSTRAINT FK_DEPOSITANTES_CONTAS FOREIGN KEY  (ContaNumero) REFERENCES Contas
GO
ALTER TABLE Depositantes ADD CONSTRAINT FK_DEPOSITANTES_CLIENTES FOREIGN KEY  (ClienteCodigo) REFERENCES Clientes
GO
insert Depositantes values (4,'C-401',1,500,'2014-01-01')
GO
insert Depositantes values (4,'C-402',2,200,'2014-02-27')
GO
insert Depositantes values (4,'C-403',3,350,'2013-07-21')
GO
insert Depositantes values (2,'C-201',4,800,'2013-04-12')
GO
insert Depositantes values (3,'C-301',5,400,'2014-07-04')
GO
insert Depositantes values (4,'C-404',7,870,'2013-08-11')
GO
insert Depositantes values (5,'C-501',6,300,'2011-03-23')
GO
insert Depositantes values (6,'C-601',8,900,'2013-10-12')
GO
insert Depositantes values (7,'C-701',9,550,'2011-09-02')
GO
insert Depositantes values (8,'C-801',10,1000,'2007-08-01')
GO
insert Depositantes values (1,'C-101',11,800,'2013-08-03')
GO
create table Devedores
(
AgenciaCodigo INT,
ClienteCodigo int,
EmprestimoCodigo varchar (10),
DevedorSaldo MONEY
)
ALTER TABLE Devedores ADD CONSTRAINT FK_DEVEDORES_AGENGIA 
FOREIGN KEY  (AgenciaCodigo) REFERENCES Agencias
GO
ALTER TABLE Devedores ADD CONSTRAINT FK_DEVEDORES_CONTAS 
FOREIGN KEY  (ClienteCodigo) REFERENCES Clientes
GO
insert Devedores values (4,1,'L-10',1000)
GO
insert Devedores values (2,4,'L-20',500)
GO
insert Devedores values (4,2,'L-15',800)
GO
insert Devedores values (4,3,'L-30',2000)
GO
insert Devedores values (6,8,'L-40',2000)
GO
insert Devedores values (1,11,'L-35',2600)
GO
insert Devedores values (4,7,'L-50',2300)
GO
create table CartaoCredito
(
AgenciaCodigo INT,
ClienteCodigo int,
CartaoCodigo varchar (20),
CartaoLimite MONEY
)
ALTER TABLE CartaoCredito ADD CONSTRAINT FK_CARTAOCREDITO_AGENGIA FOREIGN KEY  (AgenciaCodigo) REFERENCES Agencias
GO
ALTER TABLE CartaoCredito ADD CONSTRAINT FK_CARTAOCREDITO_CLIENTES FOREIGN KEY  (ClienteCodigo) REFERENCES Clientes
GO
--insert simples
INSERT dbo.CartaoCredito VALUES  (1,12,'1111-2222-3333-4444',1000)
GO
INSERT dbo.CartaoCredito VALUES  (4,13,'1234-4567-8910-1112',1000)
GO
INSERT dbo.CartaoCredito VALUES  (4,7,'2222-3333-4444-5555',2000)
GO


