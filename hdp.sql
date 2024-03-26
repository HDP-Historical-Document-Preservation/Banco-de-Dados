-- Grupo 7
-- HDP (Historical Document Preservation)
-- Isadora Piffer Marques RA: 04241010
-- Julia Costa Apolinario RA: 04241006
-- Anne Caroline de Andrade Oliveira RA: 04241035
-- Bruna Santana Reginato RA: 04241007
-- Luiza Câmara Moreira RA:0424065
-- Gustavo Presilli RA:04241056
-- Diego Campos RA:04241019

-- ----------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE HDP;
USE HDP;

-- Tabela Funcionario ---------------------------------------------------------------------------------------------------------

CREATE TABLE Funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
cpf CHAR(14) NOT NULL UNIQUE,
telefone CHAR(14) NOT NULL,
email VARCHAR(60) NOT NULL,
senha varchar(45) NOT NULL,
dataNascimento DATE NOT NULL
);

INSERT INTO Funcionario VALUES
(DEFAULT, 'Eduardo da Silva Lima', '413.810.922-68', '(11)93568-5087', 'edu.Silva@gmail.com', '042416756', '1995-10-31'),
(DEFAULT, 'Fabíola Santos Monteiro', '148.350.987-24', '(11)94828-6002', 'fabiola2456@hotmail.com', '042418292','1991-12-25'),
(DEFAULT, 'Carlos Roberto Figueiredo', '032.401.012-54', '(11)97278-5070', 'carlosfigueiredo@yahoo.com', '042419094', '1970-03-20'),
(DEFAULT, 'Ana Bela Costa', '193.216.942-34', '(11)96378-2481', 'ana.bela@outlook.com', '042410678', '1963-04-15');

SELECT nome AS 'Nome', email AS 'Email', senha AS 'Senha' FROM Funcionario;
SELECT nome AS 'Nome', cpf AS 'CPF', telefone AS 'Contato', dataNascimento AS 'Data de Nascimento';

UPDATE Funcionario SET nome = 'Carlos Roberto Arruda' WHERE idFuncionario = 3;

DELETE FROM Funcionario WHERE idFuncionario = 4;

SELECT * FROM Funcionario ORDER BY nome ASC;

DESCRIBE Funcionario;

-- Tabela Livro ---------------------------------------------------------------------------------------------------------

CREATE TABLE Livro (
idLivro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(70) NOT NULL,
categoria VARCHAR(70) NOT NULL,
dataPublicacao DATE,
integridade VARCHAR(40) NOT NULL
);

INSERT INTO Livro VALUES 
(DEFAULT, 'Carta de Pero Vaz de Caminha', 'Manuscrito','1500-05-01', 'Boa'),
(DEFAULT, 'Os Lusíadas','Poesia','1572-03-12','Ruim'),
(DEFAULT, 'Constituição Imperial Brasileira ','Legislação','1824-03-25','Ruim'),
(DEFAULT, 'Lei Áurea','Legislação','1888-05-13','Média');

ALTER TABLE Livro ADD CONSTRAINT chkIntegridade CHECK(integridade IN('Ruim', 'Média', 'Boa'));

SELECT nome AS 'Título', dataPublicacao AS 'Data de Publicação', categoria AS 'Categoria' FROM Livro;
SELECT concat('O livro "', nome,'" está com a condição: ',integridade) AS 'Condição do livro' FROM Livro;

UPDATE Livro SET integridade = 'Boa' WHERE idLivro = 4;

SELECT * FROM Livro ORDER BY dataPublicacao DESC;

DESCRIBE Livro;

-- Tabela Registro ---------------------------------------------------------------------------------------------------------

CREATE TABLE Registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
temperatura DOUBLE NOT NULL,
umidade DOUBLE NOT NULL,
dataHora DATETIME NOT NULL
);

INSERT INTO Registro VALUES
(DEFAULT, '28', '80', '2024-01-10 10:25:10'),
(DEFAULT, '15', '20', '2024-05-25 10:30:00'),
(DEFAULT, '18', '40', '2024-09-04 10:20:30');

SELECT concat('A temperatura: ', temperatura, 'Cº, e a umidade: ', umidade, '% foram registradas às ', date_format(dataHora, '%H:%i:%s do dia %d/%m/%y ')) AS 'Registros de temperatura e umidade' from Registro;

DESCRIBE Registro;

-- Tabela Empresa ---------------------------------------------------------------------------------------------------------

CREATE TABLE Empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(18) NOT NULL UNIQUE,
nome VARCHAR(70) NOT NULL,
responsavel VARCHAR(50) NOT NULL,
cep CHAR(9) NOT NULL,
numero VARCHAR(4) NOT NULL
);

INSERT INTO Empresa VALUES
(DEFAULT,'63.025.530/0001-04', 'Museu Ipiranga', 'Eduardo', '04207-030', '100'),
(DEFAULT,'10.233.223/0002-33','Museu da Língua Portuguesa','Fátima','01120-010','1130'),
(DEFAULT,'33.663.683/0029-17','Museu Nacional','Leandro','20940-040','269');

SELECT nome AS 'Nome - Empresa', cnpj AS 'CNPJ - Empresa', responsavel AS 'Responsável - Empresa' FROM Empresa;
SELECT concat('O ',nome,', cujo CNPJ é ',cnpj,', está sobre cuidados do(a) senhor(a)',responsavel) AS 'Responsável da Empresa' from Registro;

UPDATE Empresa SET responsavel = 'Osmar' WHERE idEmpresa=1;
ALTER TABLE Empresa RENAME COLUMN responsavel TO gestor;

SELECT * FROM Empresa ORDER BY nome;

DESCRIBE Empresa;

-- Tabela para Métrica ---------------------------------------------------------------------------------------------------------

CREATE TABLE Metrica(
idMetrica INT PRIMARY KEY AUTO_INCREMENT,
temperaturaIdeal INT,
umidadeIdeal INT
);

INSERT INTO Metrica VALUES
(DEFAULT,15,40),
(DEFAULT,16,43),
(DEFAULT,17,50),
(DEFAULT,18,51),
(DEFAULT,19,53),
(DEFAULT,20,55);

SELECT concat('A temperatura ideal é de ', temperaturaIdeal, ' e a umidade ideal é de ', umidadeIdeal) AS 'Medidas ideais' FROM Metrica;
SELECT temperaturaIdeal FROM Metrica ORDER BY temperaturaIdeal DESC;
SELECT umidadeIdeal FROM Metrica ORDER BY umidadeIdeal DESC;

DESCRIBE Metrica;

-- Testes ----------------------------------------------------------------------------------------------------------------------



-- ------------------------------------------------------------------------------------------------------------------------------