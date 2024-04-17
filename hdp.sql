-- HDP (Historical Document Preservation)
-- Grupo 1

-- Integrantes do Grupo
-- Bruna Santana Reginato RA: 04241007
-- Beatriz Guimarães Pinto Fernades RA:04241048 
-- Gabriel Cerejo Bellintani RA:04241045 
-- Felipe Ribeiro Patroni RA:04241051 
-- Vinícius Miralha Augusto Gomes RA:04241021 
-- Kamilly Rebeca Poggi Silva RA:04241028 

-- ----------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE hdp;
USE hdp;

-- Tabela Empresa ---------------------------------------------------------------------------------------------------------

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(70) NOT NULL,
responsavel VARCHAR(50) NOT NULL,
cep CHAR(8) NOT NULL,
numero VARCHAR(4) NOT NULL
);

INSERT INTO empresa VALUES
(DEFAULT,'63025530000104', 'Museu Ipiranga', 'Eduardo', '04207030', '100'),
(DEFAULT,'10233223000233','Museu da Língua Portuguesa','Fátima','01120010','1130'),
(DEFAULT,'33663683002917','Museu Nacional','Leandro','20940040','269');

SELECT * FROM empresa;

-- Tabela Funcionario ---------------------------------------------------------------------------------------------------------

CREATE TABLE funcionario (
idFuncionario INT AUTO_INCREMENT,
fkEmpresa INT,
CONSTRAINT pkFuncionarioEmpresa PRIMARY KEY (idFuncionario, fkEmpresa),
nome VARCHAR(80) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(15) NOT NULL,
dataNascimento DATE NOT NULL,
CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO funcionario VALUES
(DEFAULT, 1, 'Eduardo da Silva Lima', '41381092268', '11935685087', 'edu.Silva@gmail.com', '042$16756', '1995-10-31'),
(DEFAULT, 1, 'Fabíola Santos Monteiro', '14835098714', '11948286002', 'fabiola2456@hotmail.com', '04241829&','1991-12-25'),
(DEFAULT, 2, 'Carlos Roberto Figueiredo', '03220101254', '11972785070', 'carlosfigueiredo@yahoo.com', '0424@9094', '1970-03-20'),
(DEFAULT, 2, 'Alexandre Alves Reis', '24833018154', '11928282202', 'alexandre@hotmail.com', '022#18292','1993-02-15'),
(DEFAULT, 3, 'Danilo Lopez Faria', '00260104251', '11942445040', 'danilo@yahoo.com', '0323&9394', '1984-04-10'),
(DEFAULT, 3, 'Ana Bela Costa', '19311694234', '11963732481', 'ana.bela@outlook.com', '04241&678', '1963-04-15');

SELECT * FROM funcionario;
SELECT nome AS 'Nome do Funcionário', senha AS 'Senha do Funcionário' FROM funcionario;

-- Tabela Métrica ---------------------------------------------------------------------------------------------------------

CREATE TABLE metrica(
idMetrica INT PRIMARY KEY AUTO_INCREMENT,
temperaturaMax INT,
temperaturaMin INT,
umidadeMax INT,
umidadeMin INT
);

INSERT INTO metrica VALUES
(DEFAULT,25,15,65,55);

SELECT * FROM metrica;

-- Tabela Sala ----------------------------------------------------------------------------------------------------------------------

CREATE TABLE sala (
idSala INT AUTO_INCREMENT,
fkEmpresa INT,
fkMetrica INT,
CONSTRAINT pkSalaEmpresaMetrica PRIMARY KEY (idSala, fkEmpresa, fkMetrica),
nome VARCHAR(80) NOT NULL,
descricao TEXT NOT NULL,
CONSTRAINT fkSalaEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT fkSalaMetrica FOREIGN KEY (fkMetrica) REFERENCES metrica(idMetrica)
);

INSERT INTO sala VALUES 
(DEFAULT, 1,1, 'Leis Brasileiras', 'Sala onde se armazena documentos de leis brasileiras'),
(DEFAULT, 1,1, 'Poemas Brasileiros','Sala onde se armazena importantes poemas brasileiros'),
(DEFAULT, 2,1, 'Estados Unidos', 'Sala onde se armazena documentos de acontecimentos, pessoas ou histórias ficticías dos Estados Unidos'),
(DEFAULT, 2,1, 'Poemas internacionais','Sala onde se armazena importantes poemas internacionais'),
(DEFAULT, 3,1, 'Acontecimentos Brasileiros','Sala onde se armazena documentos narrando importantes acontecimentos do Brasil'),
(DEFAULT, 3,1, 'Inglaterra','Sala onde se armazena documentos de acontecimentos, pessoas ou histórias ficticías da Inglaterra');

SELECT * FROM sala;

-- Tabela Livro ---------------------------------------------------------------------------------------------------------

CREATE TABLE livro (
idLivro INT AUTO_INCREMENT,
fkSala INT,
CONSTRAINT pkLivroSala PRIMARY KEY (idLivro, fkSala),
nome VARCHAR(70) NOT NULL,
categoria VARCHAR(70) NOT NULL,
dataPublicacao DATE,
integridade VARCHAR(40) NOT NULL,
CONSTRAINT fkLivroSala FOREIGN KEY (fkSala) REFERENCES sala(idSala)
);

INSERT INTO livro VALUES 
(DEFAULT, 1, 'Carta de Pero Vaz de Caminha', 'Manuscrito','1500-05-01', 'Boa'),
(DEFAULT, 2, 'Os Lusíadas','Poesia','1572-03-12','Média'),
(DEFAULT, 3, 'Constituição Imperial Brasileira ','Legislação','1824-03-25','Ruim'),
(DEFAULT, 4, 'Lei Áurea','Legislação','1888-05-13','Boa'),
(DEFAULT, 5, 'Livro de Kells', 'Manuscrito','1615-10-13', 'Média'),
(DEFAULT, 6, 'Magna Carta','Manuscrito','1450-07-01','Ruim'),
(DEFAULT, 1, 'Diário de Anne Frank ','Manuscrito','1770-02-14','Boa'),
(DEFAULT, 2, 'Poemas de Safo','Poesia','1102-09-21','Média'),
(DEFAULT, 3, 'Manuscritos da Guerra de Canudos', 'Manuscrito','1289-03-19', 'Ruim'),
(DEFAULT, 4, 'Manifesto da Comuna de Canudos','Manuscrito','1347-11-24','Boa'),
(DEFAULT, 5, 'A Moreninha ','Manuscrito','1899-03-30','Média'),
(DEFAULT, 6, 'Os Sertões ','Manuscrito','1205-03-09','Ruim'),
(DEFAULT, 1, 'Diário de Anchieta', 'Manuscrito','1752-05-20', 'Boa'),
(DEFAULT, 2, 'Proclamação da República','Legislação','1481-12-12','Média'),
(DEFAULT, 3, 'Diário de Hans Staden','Manuscrito','1799-02-25','Ruim'),
(DEFAULT, 4, 'Auto da Pregação do Frade Bartolomeu de Gusmão','Poesia','1544-10-23','Boa'),
(DEFAULT, 5, 'Inuíto','Poesia','1745-07-11','Média'),
(DEFAULT, 6, 'Declaração da Independência dos Estados Unidos','Legislação','1890-08-07','Ruim');

SELECT * FROM livro;

ALTER TABLE livro ADD CONSTRAINT chkIntegridade CHECK(integridade IN('Ruim', 'Média', 'Boa'));

SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento', integridade AS 'Condição do Documento' FROM livro ORDER BY integridade;
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Boa';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Média';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Ruim';

-- Tabela Sensor -----------------------------------------------------------------------------------------------------------------

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSala INT NOT NULL,
CONSTRAINT fkSensorSala FOREIGN KEY (fkSala) REFERENCES sala(idSala)
);

INSERT INTO sensor VALUES
(DEFAULT,1),
(DEFAULT,1),
(DEFAULT,2),
(DEFAULT,2),
(DEFAULT,3),
(DEFAULT,3),
(DEFAULT,4),
(DEFAULT,4),
(DEFAULT,5),
(DEFAULT,5),
(DEFAULT,6),
(DEFAULT,6);

SELECT * FROM sensor;

-- Tabela RegSimulacao -----------------------------------------------------------------------------------------------------

CREATE TABLE regSimulacao (
idRegSimulacao INT PRIMARY KEY AUTO_INCREMENT,
regTemperatura DOUBLE,
regUmidade DOUBLE,
fkSensor INT,
CONSTRAINT fkregSimulacaoSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

INSERT INTO regSimulacao VALUES
(DEFAULT, '12', '47',1),
(DEFAULT, '13', '45',1),
(DEFAULT, '15', '20',2),
(DEFAULT, '20', '60',2),
(DEFAULT, '20', '61',3),
(DEFAULT, '20', '62',3),
(DEFAULT, '23', '59',4),
(DEFAULT, '25', '58',4),
(DEFAULT, '20', '60',5),
(DEFAULT, '28', '50',5),
(DEFAULT, '32', '80',6),
(DEFAULT, '28', '77',6),
(DEFAULT, '10', '45',7),
(DEFAULT, '13', '42',7),
(DEFAULT, '30', '20',8),
(DEFAULT, '30', '60',8),
(DEFAULT, '16', '63',9),
(DEFAULT, '11', '52',9),
(DEFAULT, '23', '60',10),
(DEFAULT, '21', '80',10),
(DEFAULT, '10', '60',11),
(DEFAULT, '28', '58',11),
(DEFAULT, '32', '70',12),
(DEFAULT, '20', '57',12);

-- Tabela Registro ---------------------------------------------------------------------------------------------------------

CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
umidade FLOAT,
temperatura FLOAT
);

SELECT * FROM registro;

-- JOINS -----------------------------------------------------------------------------------------------------------------------

SELECT s.nome AS 'Nome da Sala', m.temperaturaMax AS 'Temperatura Máxima Permitida', m.temperaturaMin AS 'Temperatura Miníma Permitida', 
m.umidadeMax AS 'Umidade Máxima Permitida', m.umidadeMin AS 'Umidade Miníma Permitida' 
FROM sala AS s JOIN metrica AS m ON s.fkMetrica = m.idMetrica;

-- MUSEU IPIRANGA ---------------------------------------

SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
WHERE e.nome LIKE 'Museu Ipiranga';

SELECT s.nome, se.idSensor, rs.temperatura, rs.umidade, e.nome 
FROM sala AS s JOIN sensor AS se ON s.idSala = se.fkSala JOIN regSimulacao AS rs ON rs.fkSensor = se.idSensor JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa
WHERE e.nome LIKE 'Museu Ipiranga';

SELECT 
e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha', f.dataNascimento AS 'Data de Nascimento'
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu Ipiranga';

SELECT e.nome AS 'Nome da Empresa', f.nome AS 'Nome do Funcionário' 
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu Ipiranga';

-- MUSEU DA LÍNGUA PORTUGUESA ---------------------------------------

SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
WHERE e.nome LIKE 'Museu da Língua Portuguesa';

SELECT s.nome, se.idSensor, rs.temperatura, rs.umidade, e.nome 
FROM sala AS s JOIN sensor AS se ON s.idSala = se.fkSala JOIN regSimulacao AS rs ON rs.fkSensor = se.idSensor JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa
WHERE e.nome LIKE 'Museu da Língua Portuguesa';

SELECT 
e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha', f.dataNascimento AS 'Data de Nascimento'
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu da Língua Portuguesa';

SELECT e.nome AS 'Nome da Empresa', f.nome AS 'Nome do Funcionário' 
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu da Língua Portuguesa';

-- MUSEU NACIONAL ---------------------------------------

SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
WHERE e.nome LIKE 'Museu Nacional';

SELECT s.nome, se.idSensor, rs.temperatura, rs.umidade, e.nome 
FROM sala AS s JOIN sensor AS se ON s.idSala = se.fkSala JOIN regSimulacao AS rs ON rs.fkSensor = se.idSensor JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa
WHERE e.nome LIKE 'Museu Nacional';

SELECT 
e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha', f.dataNascimento AS 'Data de Nascimento'
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu Nacional';

SELECT e.nome AS 'Nome da Empresa', f.nome AS 'Nome do Funcionário' 
FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
WHERE e.nome LIKE 'Museu Nacional';

-- Testes ----------------------------------------------------------------------------------------------------------------------

SHOW TABLES;

DESCRIBE funcionario;
DESCRIBE livro;
DESCRIBE registro;
DESCRIBE empresa;
DESCRIBE metrica;
DESCRIBE sala;
DESCRIBE sensor;

DROP DATABASE hdp;

-- Testes ---------------------------------------------------------------------------------------------------------------------

















-- Alguns comandos que podem ser necessários --------------------------------------------------------------------------------------------

-- SELECT nome AS 'Nome', email AS 'Email', senha AS 'Senha' FROM funcionario;
-- SELECT nome AS 'Nome', cpf AS 'CPF', telefone AS 'Contato', dataNascimento AS 'Data de Nascimento' FROM funcionario;
-- UPDATE funcionario SET nome = 'Carlos Roberto Arruda' WHERE idFuncionario = 3;
-- DELETE FROM funcionario WHERE idFuncionario = 4;
-- SELECT * FROM funcionario ORDER BY nome ASC;

-- SELECT nome AS 'Título', dataPublicacao AS 'Data de Publicação', categoria AS 'Categoria' FROM livro;
-- SELECT concat('O livro "', nome,'" está com a condição: ',integridade) AS 'Condição do livro' FROM livro;
-- UPDATE livro SET integridade = 'Boa' WHERE idLivro = 4;
-- SELECT * FROM livro ORDER BY dataPublicacao DESC;

-- SELECT nome AS 'Nome - Empresa', cnpj AS 'CNPJ - Empresa', responsavel AS 'Responsável - Empresa' FROM empresa;
-- SELECT concat('O ',nome,', cujo CNPJ é ',cnpj,', está sobre cuidados do(a) senhor(a)',responsavel) AS 'Responsável da Empresa' FROM empresa;
-- UPDATE empresa SET responsavel = 'Osmar' WHERE idEmpresa=1;
-- ALTER TABLE empresa RENAME COLUMN responsavel TO gestor;
-- SELECT * FROM empresa ORDER BY nome;

-- SELECT nome AS 'Nome', descricao AS 'Descrição' FROM sala WHERE nome = 'Poemas Brasileiros';

-- ------------------------------------------------------------------------------------------------------------------------------
