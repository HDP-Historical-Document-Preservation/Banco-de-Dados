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

-- Tabela Funcionario ---------------------------------------------------------------------------------------------------------

CREATE TABLE funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(15) NOT NULL,
dataNascimento DATE NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO funcionario VALUES
(DEFAULT, 'Eduardo da Silva Lima', '41381092268', '11935685087', 'edu.Silva@gmail.com', '042$16756', '1995-10-31',1),
(DEFAULT, 'Fabíola Santos Monteiro', '14835098714', '11948286002', 'fabiola2456@hotmail.com', '04241829&','1991-12-25',1),
(DEFAULT, 'Carlos Roberto Figueiredo', '03220101254', '11972785070', 'carlosfigueiredo@yahoo.com', '0424@9094', '1970-03-20',2),
(DEFAULT, 'Alexandre Alves Reis', '24833018154', '11928282202', 'alexandre@hotmail.com', '022#18292','1993-02-15',2),
(DEFAULT, 'Danilo Lopez Faria', '00260104251', '11942445040', 'danilo@yahoo.com', '0323&9394', '1984-04-10',3),
(DEFAULT, 'Ana Bela Costa', '19311694234', '11963732481', 'ana.bela@outlook.com', '04241&678', '1963-04-15',3);

SELECT * FROM funcionario;
SELECT nome AS 'Nome do Funcionário', senha AS 'Senha do Funcionário' FROM funcionario;

-- Tabela Livro ---------------------------------------------------------------------------------------------------------

CREATE TABLE livro (
idLivro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(70) NOT NULL,
categoria VARCHAR(70) NOT NULL,
dataPublicacao DATE,
integridade VARCHAR(40) NOT NULL,
fkSala INT NOT NULL,
CONSTRAINT fkLivroSala FOREIGN KEY (fkSala) REFERENCES sala(idSala)
);

INSERT INTO livro VALUES 
(DEFAULT, 'Carta de Pero Vaz de Caminha', 'Manuscrito','1500-05-01', 'Boa',5),
(DEFAULT, 'Os Lusíadas','Poesia','1572-03-12','Média',2),
(DEFAULT, 'Constituição Imperial Brasileira ','Legislação','1824-03-25','Ruim',1),
(DEFAULT, 'Lei Áurea','Legislação','1888-05-13','Boa',1),
(DEFAULT, 'Livro de Kells', 'Manuscrito','1615-10-13', 'Média',5),
(DEFAULT, 'Magna Carta','Manuscrito','1450-07-01','Ruim',6),
(DEFAULT, 'Diário de Anne Frank ','Manuscrito','1770-02-14','Boa',6),
(DEFAULT, 'Poemas de Safo','Poesia','1102-09-21','Média',6),
(DEFAULT, 'Manuscritos da Guerra de Canudos', 'Manuscrito','1289-03-19', 'Ruim',5),
(DEFAULT, 'Manifesto da Comuna de Canudos','Manuscrito','1347-11-24','Boa',5),
(DEFAULT, 'A Moreninha ','Manuscrito','1899-03-30','Média',5),
(DEFAULT, 'Os Sertões ','Manuscrito','1205-03-09','Ruim',5),
(DEFAULT, 'Diário de Anchieta', 'Manuscrito','1752-05-20', 'Boa',5),
(DEFAULT, 'Proclamação da República','Legislação','1481-12-12','Média',1),
(DEFAULT, 'Diário de Hans Staden','Manuscrito','1799-02-25','Ruim',3),
(DEFAULT, 'Auto da Pregação do Frade Bartolomeu de Gusmão','Poesia','1544-10-23','Boa',4),
(DEFAULT, 'Inuíto','Poesia','1745-07-11','Média',2),
(DEFAULT, 'Declaração da Independência dos Estados Unidos','Legislação','1890-08-07','Ruim',3);

SELECT * FROM livro;

ALTER TABLE livro ADD CONSTRAINT chkIntegridade CHECK(integridade IN('Ruim', 'Média', 'Boa'));

SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento', integridade AS 'Condição do Documento' FROM livro ORDER BY integridade;
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Boa';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Média';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM livro WHERE integridade='Ruim';

-- Tabela Registro ---------------------------------------------------------------------------------------------------------

CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
temperatura DOUBLE NOT NULL,
umidade DOUBLE NOT NULL,
fkSensor INT,
CONSTRAINT fkRegistroSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

INSERT INTO registro VALUES
(DEFAULT, '12', '47',1),
(DEFAULT, '13', '45',2),
(DEFAULT, '15', '20',3),
(DEFAULT, '20', '60',4),
(DEFAULT, '20', '61',5),
(DEFAULT, '20', '62',6),
(DEFAULT, '23', '59',1),
(DEFAULT, '25', '58',2),
(DEFAULT, '20', '60',3),
(DEFAULT, '28', '50',4),
(DEFAULT, '32', '80',5),
(DEFAULT, '28', '77',6),
(DEFAULT, '18', '70',1),
(DEFAULT, '15', '69',2),
(DEFAULT, '13', '60',3),
(DEFAULT, '12', '65',4),
(DEFAULT, '11', '69',5),
(DEFAULT, '10', '67',6);

SELECT * FROM registro;

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
idSala INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
descricao TEXT NOT NULL,
fkEmpresa INT NOT NULL,
fkMetrica INT NOT NULL,
CONSTRAINT fkSalaEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO sala VALUES 
(DEFAULT, 'Leis Brasileiras', 'Sala onde se armazena documentos de leis brasileiras',1),
(DEFAULT,'Poemas Brasileiros','Sala onde se armazena importantes poemas brasileiros',1),
(DEFAULT, 'Estados Unidos', 'Sala onde se armazena documentos de acontecimentos, pessoas ou histórias ficticías dos Estados Unidos',2),
(DEFAULT,'Poemas internacionais','Sala onde se armazena importantes poemas internacionais',2),
(DEFAULT,'Acontecimentos Brasileiros','Sala onde se armazena documentos narrando importantes acontecimentos do Brasil',3),
(DEFAULT,'Inglaterra','Sala onde se armazena documentos de acontecimentos, pessoas ou histórias ficticías da Inglaterra',3);

SELECT * FROM sala;

-- Tabela Sensor -----------------------------------------------------------------------------------------------------------------

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSala INT NOT NULL,
fkMetrica INT NOT NULL,
CONSTRAINT fkSensorSala FOREIGN KEY (fkSala) REFERENCES sala(idSala),
CONSTRAINT fkSensorMetrica FOREIGN KEY (fkMetrica) REFERENCES metrica(idMetrica)
);

INSERT INTO sensor VALUES
(DEFAULT,1,1),
(DEFAULT,2,1),
(DEFAULT,3,1),
(DEFAULT,4,1),
(DEFAULT,5,1),
(DEFAULT,6,1);

SELECT * FROM sensor;

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

-- ------------------------------------------------------------------------------------------------------------------------------









-- Alguns comandos que podem ser necessários --------------------------------------------------------------------------------------------

-- SELECT nome AS 'Nome', email AS 'Email', senha AS 'Senha' FROM Funcionario;
-- SELECT nome AS 'Nome', cpf AS 'CPF', telefone AS 'Contato', dataNascimento AS 'Data de Nascimento';
-- UPDATE Funcionario SET nome = 'Carlos Roberto Arruda' WHERE idFuncionario = 3;
-- DELETE FROM Funcionario WHERE idFuncionario = 4;
-- SELECT * FROM Funcionario ORDER BY nome ASC;

-- SELECT nome AS 'Título', dataPublicacao AS 'Data de Publicação', categoria AS 'Categoria' FROM Livro;
-- SELECT concat('O livro "', nome,'" está com a condição: ',integridade) AS 'Condição do livro' FROM Livro;
-- SELECT l.nome AS 'Nome do Livro e/ou Documento', s.nome AS 'Nome da Sala', s.descricao AS 'Descrição sobre a Sala' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala;
-- SELECT concat('O documento ',l.nome,', cujo a condição está ',l.integridade,', está localizado na sala: ',s.nome) AS "Localização de Livros" FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala ORDER BY l.integridade DESC;
-- SELECT concat('O documento ',l.nome,', cujo a condição está ',l.integridade,', está localizado na sala: ',s.nome) AS "Localização de Livros" FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala ORDER BY l.integridade;
-- UPDATE Livro SET integridade = 'Boa' WHERE idLivro = 4;
-- SELECT * FROM Livro ORDER BY dataPublicacao DESC;

-- SELECT concat('A temperatura: ', temperatura, 'Cº, e a umidade: ', umidade, '% foram registradas às ', date_format(dataHora, '%H:%i:%s do dia %d/%m/%y ')) AS 'Registros de temperatura e umidade' from Registro;

-- SELECT nome AS 'Nome - Empresa', cnpj AS 'CNPJ - Empresa', responsavel AS 'Responsável - Empresa' FROM Empresa;
-- SELECT concat('O ',nome,', cujo CNPJ é ',cnpj,', está sobre cuidados do(a) senhor(a)',responsavel) AS 'Responsável da Empresa' from Registro;
-- UPDATE Empresa SET responsavel = 'Osmar' WHERE idEmpresa=1;
-- ALTER TABLE Empresa RENAME COLUMN responsavel TO gestor;
-- SELECT * FROM Empresa ORDER BY nome;

-- SELECT nome AS 'Nome', descricao AS 'Descrição' FROM Sala WHERE nome = 'Poemas Brasileiros';

-- ------------------------------------------------------------------------------------------------------------------------------
