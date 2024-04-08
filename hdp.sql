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

CREATE DATABASE HDP;
USE HDP;

-- Tabela Funcionario ---------------------------------------------------------------------------------------------------------

CREATE TABLE Funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(15) NOT NULL,
dataNascimento DATE NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

INSERT INTO Funcionario VALUES
(DEFAULT, 'Eduardo da Silva Lima', '413810@2268', '11935685087', 'edu.Silva@gmail.com', '042416756', '1995-10-31',3),
(DEFAULT, 'Fabíola Santos Monteiro', '148350987$4', '11948286002', 'fabiola2456@hotmail.com', '042418292','1991-12-25',1),
(DEFAULT, 'Carlos Roberto Figueiredo', '032&0101254', '11972785070', 'carlosfigueiredo@yahoo.com', '042419094', '1970-03-20',2),
(DEFAULT, 'Ana Bela Costa', '19321694234', '119637#2481', 'ana.bela@outlook.com', '042410678', '1963-04-15',1);

DESCRIBE Funcionario;
SELECT * FROM Funcionario;

SELECT f.nome AS 'Nome do Funcionário', e.idEmpresa AS 'ID da Empresa', e.nome AS 'Nome da Empresa' FROM Funcionario AS f INNER JOIN Empresa AS e ON fkEmpresa=idEmpresa;
SELECT nome AS 'Nome do Funcionário', senha AS 'Senha do Funcionário' FROM Funcionario;

-- SELECT nome AS 'Nome', email AS 'Email', senha AS 'Senha' FROM Funcionario;
-- SELECT nome AS 'Nome', cpf AS 'CPF', telefone AS 'Contato', dataNascimento AS 'Data de Nascimento';
-- UPDATE Funcionario SET nome = 'Carlos Roberto Arruda' WHERE idFuncionario = 3;
-- DELETE FROM Funcionario WHERE idFuncionario = 4;
-- SELECT * FROM Funcionario ORDER BY nome ASC;

-- Tabela Livro ---------------------------------------------------------------------------------------------------------

CREATE TABLE Livro (
idLivro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(70) NOT NULL,
categoria VARCHAR(70) NOT NULL,
dataPublicacao DATE,
integridade VARCHAR(40) NOT NULL,
fkSala INT NOT NULL,
CONSTRAINT fkLivroSala FOREIGN KEY (fkSala) REFERENCES Sala(idSala)
);

INSERT INTO Livro VALUES 
(DEFAULT, 'Carta de Pero Vaz de Caminha', 'Manuscrito','1500-05-01', 'Boa',4),
(DEFAULT, 'Os Lusíadas','Poesia','1572-03-12','Ruim',1),
(DEFAULT, 'Constituição Imperial Brasileira ','Legislação','1824-03-25','Ruim',3),
(DEFAULT, 'Lei Áurea','Legislação','1888-05-13','Média',2);

DESCRIBE Livro;
SELECT * FROM Livro;
ALTER TABLE Livro ADD CONSTRAINT chkIntegridade CHECK(integridade IN('Ruim', 'Média', 'Boa'));

SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento', integridade AS 'COndição do Documento' FROM Livro ORDER BY integridade;

SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM Livro WHERE integridade='Boa';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM Livro WHERE integridade='Média';
SELECT idLivro AS 'ID do Documento', nome AS 'Nome do Documento' FROM Livro WHERE integridade='Ruim';

SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala INNER JOIN Sensor AS se INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.temperatura<15 ORDER BY r.temperatura; 
SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala INNER JOIN Sensor AS se INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.temperatura>25 ORDER BY r.temperatura DESC; 
SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala INNER JOIN Sensor AS se INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.umidade<55 ORDER BY r.umidade;
SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala INNER JOIN Sensor AS se INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.umidade>65 ORDER BY r.umidade DESC; 


-- SELECT nome AS 'Título', dataPublicacao AS 'Data de Publicação', categoria AS 'Categoria' FROM Livro;
-- SELECT concat('O livro "', nome,'" está com a condição: ',integridade) AS 'Condição do livro' FROM Livro;
-- SELECT l.nome AS 'Nome do Livro e/ou Documento', s.nome AS 'Nome da Sala', s.descricao AS 'Descrição sobre a Sala' FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala;
-- SELECT concat('O documento ',l.nome,', cujo a condição está ',l.integridade,', está localizado na sala: ',s.nome) AS "Localização de Livros" FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala ORDER BY l.integridade DESC;
-- SELECT concat('O documento ',l.nome,', cujo a condição está ',l.integridade,', está localizado na sala: ',s.nome) AS "Localização de Livros" FROM Livro AS l INNER JOIN Sala AS s ON fkSala=idSala ORDER BY l.integridade;
-- UPDATE Livro SET integridade = 'Boa' WHERE idLivro = 4;
-- SELECT * FROM Livro ORDER BY dataPublicacao DESC;

-- Tabela Registro ---------------------------------------------------------------------------------------------------------

CREATE TABLE Registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
temperatura DOUBLE NOT NULL,
umidade DOUBLE NOT NULL,
dataHora DATETIME NOT NULL,
fkSensor INT NOT NULL,
CONSTRAINT fkRegistroSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

INSERT INTO Registro VALUES
(DEFAULT, '28', '80', '2024-01-10 10:25:10',1),
(DEFAULT, '15', '20', '2024-05-25 10:30:00',2),
(DEFAULT, '18', '40', '2024-09-04 10:20:30',3);

DESCRIBE Registro;
SELECT * FROM Registro;

-- SELECT concat('A temperatura: ', temperatura, 'Cº, e a umidade: ', umidade, '% foram registradas às ', date_format(dataHora, '%H:%i:%s do dia %d/%m/%y ')) AS 'Registros de temperatura e umidade' from Registro;

-- Tabela Empresa ---------------------------------------------------------------------------------------------------------

CREATE TABLE Empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(70) NOT NULL,
responsavel VARCHAR(50) NOT NULL,
cep CHAR(8) NOT NULL,
numero VARCHAR(4) NOT NULL
);

INSERT INTO Empresa VALUES
(DEFAULT,'63025530000104', 'Museu Ipiranga', 'Eduardo', '04207030', '100'),
(DEFAULT,'10233223000233','Museu da Língua Portuguesa','Fátima','01120010','1130'),
(DEFAULT,'33663683002917','Museu Nacional','Leandro','20940040','269');

DESCRIBE Empresa;
SELECT * FROM Empresa;

-- SELECT nome AS 'Nome - Empresa', cnpj AS 'CNPJ - Empresa', responsavel AS 'Responsável - Empresa' FROM Empresa;
-- SELECT concat('O ',nome,', cujo CNPJ é ',cnpj,', está sobre cuidados do(a) senhor(a)',responsavel) AS 'Responsável da Empresa' from Registro;
-- UPDATE Empresa SET responsavel = 'Osmar' WHERE idEmpresa=1;
-- ALTER TABLE Empresa RENAME COLUMN responsavel TO gestor;
-- SELECT * FROM Empresa ORDER BY nome;

-- Tabela para Métrica ---------------------------------------------------------------------------------------------------------

CREATE TABLE Metrica(
idMetrica INT PRIMARY KEY AUTO_INCREMENT,
temperaturaMax INT,
temperaturaMin INT,
umidadeMax INT,
umidadeMin INT
);

INSERT INTO Metrica VALUES
(DEFAULT,25,15,65,55);

DESCRIBE Metrica;
SELECT * FROM Metrica;

-- Sala ----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Sala (
idSala INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
descricao TEXT NOT NULL,
fkEmpresa INT NOT NULL,
fkMetrica INT NOT NULL,
CONSTRAINT fkSalaEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
CONSTRAINT fkSalaMetrica FOREIGN KEY (fkMetrica) REFERENCES Metrica(idMetrica)
);

INSERT INTO Sala VALUES 
(DEFAULT, 'Leis Brasileiras', 'Sala onde se armazena documentos de leis brasileiras',3,1),
(DEFAULT,'Poemas Brasileiros','Sala onde se armazena importantes poemas brasileiros',1,1),
(DEFAULT,'Acontecimentos Brasileiros','Sala onde se armazena documentos narrando importantes acontecimentos do Brasil',2,1),
(DEFAULT,'Inglaterra','Sala onde se armazena documentos de acontecimentos, pessoas ou histórias ficticías da Inglaterra',3,1);

SELECT s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Sala AS s INNER JOIN Sensor AS se ON idSala=fkSala INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.temperatura<15 ORDER BY r.temperatura; 
SELECT s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Sala AS s INNER JOIN Sensor AS se ON idSala=fkSala INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.temperatura>25 ORDER BY r.temperatura DESC; 
SELECT s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Sala AS s INNER JOIN Sensor AS se ON idSala=fkSala INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.umidade<55 ORDER BY r.umidade; 
SELECT s.nome AS 'Nome da Sala', se.idSensor AS 'ID do Sensor', r.temperatura AS 'Temperatura', r.umidade AS 'Umidade', r.dataHora AS 'Data e Hora do Registro' FROM Sala AS s INNER JOIN Sensor AS se ON idSala=fkSala INNER JOIN Registro AS r ON fkSensor=idSensor WHERE r.dataHora='2024-05-25 10:30:00' AND r.umidade>65 ORDER BY r.umidade DESC; 

DESCRIBE Sala;
SELECT * FROM Sala;

-- SELECT nome AS 'Nome', descricao AS 'Descrição' FROM Sala WHERE nome = 'Poemas Brasileiros';

-- Sensor -----------------------------------------------------------------------------------------------------------------

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSala INT NOT NULL
);

INSERT INTO Sensor VALUES
(DEFAULT,1),
(DEFAULT,2),
(DEFAULT,3),
(DEFAULT,4);

DESCRIBE Sensor;
SELECT * FROM Sensor;

-- Testes ----------------------------------------------------------------------------------------------------------------------



-- ------------------------------------------------------------------------------------------------------------------------------