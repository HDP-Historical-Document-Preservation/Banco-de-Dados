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

DROP DATABASE hdp;
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
(DEFAULT,'63925980050204', 'Museu Ipiranga', 'Eduardo', '04809237', '100'),
(DEFAULT,'10132226000238','Museu da Língua Portuguesa','Fátima','00180050','1130'),
(DEFAULT,'13668656002917','Museu Nacional','Leandro','27919840','269');

SELECT * FROM empresa;

-- Tabela Funcionario ---------------------------------------------------------------------------------------------------------

CREATE TABLE funcionario (
idFuncionario INT AUTO_INCREMENT,
fkEmpresa INT,
CONSTRAINT pkFuncionarioEmpresa PRIMARY KEY (idFuncionario, fkEmpresa),
nome VARCHAR(80) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL UNIQUE,
email VARCHAR(60) NOT NULL UNIQUE,
senha VARCHAR(200) NOT NULL,
CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO funcionario VALUES
(DEFAULT, 1, 'Eduardo', '41381092268', '11935685087', 'eduardo@gmail.com', '1234567#');

-- INSERT INTO funcionario VALUES
-- (DEFAULT, 1, 'Eduardo', '41381092268', '11935685087', 'eduardo@gmail.com', MD5('1234567#'));

SELECT * FROM funcionario;
SELECT nome AS 'Nome do Funcionário', senha AS 'Senha do Funcionário' FROM funcionario;

-- Tabela Métrica ---------------------------------------------------------------------------------------------------------

CREATE TABLE metrica(
idMetrica INT PRIMARY KEY AUTO_INCREMENT,
temperaturaMax FLOAT NOT NULL,
temperaturaMin FLOAT NOT NULL,
umidadeMax FLOAT NOT NULL,
umidadeMin FLOAT NOT NULL
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
CONSTRAINT fkSalaEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT fkSalaMetrica FOREIGN KEY (fkMetrica) REFERENCES metrica(idMetrica)
);

INSERT INTO sala VALUES 
(DEFAULT, 1,1, 'Acontecimentos Misteriosos'),
(DEFAULT, 1,1, 'Livros Religiosos'),
(DEFAULT, 1,1, 'Leis Brasileiras'),
(DEFAULT, 1,1, 'Estados Unidos'),
(DEFAULT, 1,1, 'Inglaterra'),
(DEFAULT, 2,1, 'Matemáticos'),
(DEFAULT, 2,1, 'Mediterrâneo'),
(DEFAULT, 2,1, 'Escravidão'),
(DEFAULT, 2,1, 'Galeria dos Impressionistas'),
(DEFAULT, 2,1, 'Sala dos Mestres Antigos'),
(DEFAULT, 3,1, 'Religião e Mitos'),
(DEFAULT, 3,1, 'Mergulho na História'),
(DEFAULT, 3,1, 'Raízes da Nossa Terra'),
(DEFAULT, 3,1, 'História Local'),
(DEFAULT, 3,1, 'Biodiversidade Regional');

SELECT * FROM sala;

-- Tabela Sensor -----------------------------------------------------------------------------------------------------------------

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
fkSala INT,
CONSTRAINT pkSensorSala PRIMARY KEY (idSensor, fkSala),
nome VARCHAR(25) NOT NULL,
fator FLOAT NOT NULL,
CONSTRAINT fkSensorSala FOREIGN KEY (fkSala) REFERENCES sala(idSala)
);

INSERT INTO sensor VALUES
(DEFAULT, 1, 'Sensor1', 0.5),
(DEFAULT, 2, 'Sensor1', 1),
(DEFAULT, 3, 'Sensor1', 1.2),
(DEFAULT, 4, 'Sensor1', 0.7),
(DEFAULT, 5, 'Sensor1', 0.4),
(DEFAULT, 6, 'Sensor1', 0.6),
(DEFAULT, 7, 'Sensor1', 0.8),
(DEFAULT, 8, 'Sensor1', 1),
(DEFAULT, 9, 'Sensor1', 0.9),
(DEFAULT, 10, 'Sensor1', 1.2),
(DEFAULT, 11, 'Sensor1', 1),
(DEFAULT, 12, 'Sensor1', 0.7),
(DEFAULT, 13, 'Sensor1', 0.5),
(DEFAULT, 14, 'Sensor1', 1),
(DEFAULT, 15, 'Sensor1', 0.6);

SELECT * FROM sensor;

SELECT ROUND(r.umidade * s.fator) AS Umidade, ROUND(r.temperatura * s.fator) AS Temperatura, s.nome FROM registro AS r , sensor AS s;
 
SELECT (r.umidade * s.fator) AS Umidade, (r.temperatura * s.fator) AS Temperatura, s.nome 
FROM registro AS r , sensor AS s WHERE fkSala = 1; 

-- Tabela Registro ---------------------------------------------------------------------------------------------------------

CREATE TABLE registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
umidade FLOAT,
temperatura FLOAT,
diaHora TIME,
fkSensor INT,
CONSTRAINT registroSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

INSERT INTO registro (umidade, temperatura, diaHora, fkSensor) VALUES
(60, 20, NOW(), 1),
(60, 20, NOW(), 2),
(60, 20, NOW(), 3),
(60, 20, NOW(), 4),
(60, 20, NOW(), 5),
(60, 20, NOW(), 6),
(60, 20, NOW(), 7),
(60, 20, NOW(), 8),
(60, 20, NOW(), 9),
(60, 20, NOW(), 10),
(60, 20, NOW(), 11),
(60, 20, NOW(), 12),
(60, 20, NOW(), 13),
(60, 20, NOW(), 14),
(60, 20, NOW(), 15),
(86, 15, NOW(), 1),
(86, 15, NOW(), 2),
(86, 15, NOW(), 3),
(86, 15, NOW(), 4),
(86, 15, NOW(), 5),
(86, 15, NOW(), 6),
(86, 15, NOW(), 7),
(86, 15, NOW(), 8),
(86, 15, NOW(), 9),
(86, 15, NOW(), 10),
(86, 15, NOW(), 11),
(86, 15, NOW(), 12),
(86, 15, NOW(), 13),
(86, 15, NOW(), 14),
(86, 15, NOW(), 15),
(70, 22, NOW(), 1),
(70, 22, NOW(), 2),
(70, 22, NOW(), 3),
(70, 22, NOW(), 4),
(70, 22, NOW(), 5),
(70, 22, NOW(), 6),
(70, 22, NOW(), 7),
(70, 22, NOW(), 8),
(70, 22, NOW(), 9),
(70, 22, NOW(), 10),
(70, 22, NOW(), 11),
(70, 22, NOW(), 12),
(70, 22, NOW(), 13),
(70, 22, NOW(), 14),
(70, 22, NOW(), 15),
(61, 21, NOW(), 1),
(61, 21, NOW(), 2),
(61, 21, NOW(), 3),
(61, 21, NOW(), 4),
(61, 21, NOW(), 5),
(61, 21, NOW(), 6),
(61, 21, NOW(), 7),
(61, 21, NOW(), 8),
(61, 21, NOW(), 9),
(61, 21, NOW(), 10),
(61, 21, NOW(), 11),
(61, 21, NOW(), 12),
(61, 21, NOW(), 13),
(61, 21, NOW(), 14),
(61, 21, NOW(), 15);

SELECT * FROM registro;

SELECT ROUND(r.umidade * s.fator) AS Umidade, ROUND(r.temperatura * s.fator) AS Temperatura, s.nome FROM registro AS r , sensor AS s;

-- SELECTS ----------------------------------------------------------------------------------------------------------------

-- QUANTIDADE DE SALAS FORA DO IDEAL ------------------------------------------------------

SELECT COUNT(s.idSala) AS salas FROM sala AS s JOIN Empresa ON empresa.idEmpresa = s.fkEmpresa WHERE s.fkEmpresa = ${fkEmpresa};

-- QUANTIDADE DE SALAS FORA DO IDEAL ------------------------------------------------------

SELECT COUNT(DISTINCT sa.idSala) AS 'qtdSalasFora'
FROM sala AS sa
JOIN sensor AS s ON sa.idSala = s.fkSala
JOIN (
  SELECT r.fkSensor, r.umidade, r.temperatura, r.diaHora, r.idRegistro
  FROM registro AS r
  JOIN (
    SELECT fkSensor, MAX(diaHora) AS max_diaHora
    FROM registro
    GROUP BY fkSensor ORDER BY max_diaHora DESC
  ) AS lr ON r.fkSensor = lr.fkSensor AND r.diaHora = lr.max_diaHora
) AS r ON s.idSensor = r.fkSensor
JOIN empresa AS e ON e.idEmpresa = sa.fkEmpresa
WHERE e.idEmpresa = 1
  AND (ROUND(r.umidade * s.fator) >= 65 
       OR ROUND(r.umidade * s.fator) <= 55 
       OR ROUND(r.temperatura * s.fator) >= 25 
       OR ROUND(r.temperatura * s.fator) <= 15); 
       
-- GRÁFICO 1 -------------------------------------------------------------------
  
SELECT 
  s.idSensor,
  sa.nome AS nome_sala,
  ROUND(r.umidade * s.fator) AS umidade_ajustada,
  ROUND(r.temperatura * s.fator) AS temperatura_ajustada,
  r.diaHora AS hora_insercao
FROM sala AS sa
JOIN sensor AS s ON sa.idSala = s.fkSala
JOIN registro AS r ON r.fkSensor = s.idSensor
JOIN empresa AS e ON e.idEmpresa = sa.fkEmpresa
WHERE e.idEmpresa = ${fkEmpresa}
  AND s.idSensor = ${idSensor}
 ORDER BY hora_insercao DESC LIMIT 7;
  
  -- GRÁFICO 2 ------------------------------------------------------------------------
  
  SELECT 
  s.idSensor,
  sa.nome AS nome_sala,
  ROUND(r.umidade * s.fator) AS umidade_ajustada,
  ROUND(r.temperatura * s.fator) AS temperatura_ajustada,
  r.diaHora AS hora_insercao
FROM sala AS sa
JOIN sensor AS s ON sa.idSala = s.fkSala
JOIN registro AS r ON r.fkSensor = s.idSensor
JOIN empresa AS e ON e.idEmpresa = sa.fkEmpresa
WHERE e.idEmpresa = ${fkEmpresa}
  AND s.idSensor = ${idSensor}
 ORDER BY hora_insercao DESC LIMIT 24;
 
  -- GRÁFICO PIZZA ------------------------------------------------------------------------
  
  SELECT 
  'Salas Fora do Ideal' AS tipo,
  COUNT(DISTINCT sa.idSala) AS quantidade
FROM sala AS sa
JOIN sensor AS s ON sa.idSala = s.fkSala
JOIN (
  SELECT r.fkSensor, r.umidade, r.temperatura, r.diaHora, r.idRegistro
  FROM registro AS r
  JOIN (
    SELECT fkSensor, MAX(diaHora) AS max_diaHora
    FROM registro
    GROUP BY fkSensor
  ) AS lr ON r.fkSensor = lr.fkSensor AND r.diaHora = lr.max_diaHora
) AS r ON s.idSensor = r.fkSensor
JOIN empresa AS e ON e.idEmpresa = sa.fkEmpresa
WHERE e.idEmpresa = 1
  AND (ROUND(r.umidade * s.fator) >= 65 
       OR ROUND(r.umidade * s.fator) <= 55 
       OR ROUND(r.temperatura * s.fator) >= 25 
       OR ROUND(r.temperatura * s.fator) <= 15)
UNION ALL
SELECT 
  'Salas Dentro do Ideal' AS tipo,
  COUNT(DISTINCT sa.idSala) AS quantidade
FROM sala AS sa
JOIN sensor AS s ON sa.idSala = s.fkSala
JOIN (
  SELECT r.fkSensor, r.umidade, r.temperatura, r.diaHora, r.idRegistro
  FROM registro AS r
  JOIN (
    SELECT fkSensor, MAX(diaHora) AS max_diaHora
    FROM registro
    GROUP BY fkSensor
  ) AS lr ON r.fkSensor = lr.fkSensor AND r.diaHora = lr.max_diaHora
) AS r ON s.idSensor = r.fkSensor
JOIN empresa AS e ON e.idEmpresa = sa.fkEmpresa
WHERE e.idEmpresa = 1
  AND (ROUND(r.umidade * s.fator) <= 65 
       AND ROUND(r.umidade * s.fator) >= 55 
       AND ROUND(r.temperatura * s.fator) <= 25 
       AND ROUND(r.temperatura * s.fator) >= 15);
 
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

-- SELECT s.nome AS 'Nome da Sala', m.temperaturaMax AS 'Temperatura Máxima Permitida', m.temperaturaMin AS 'Temperatura Miníma Permitida', 
-- m.umidadeMax AS 'Umidade Máxima Permitida', m.umidadeMin AS 'Umidade Miníma Permitida' 
-- FROM sala AS s JOIN metrica AS m ON s.fkMetrica = m.idMetrica;

-- MUSEU IPIRANGA ---------------------------------------

-- SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
-- FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Ipiranga';

-- SELECT 
-- e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
-- f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha'
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Ipiranga';

-- SELECT e.nome AS 'Nome da Empresa', e.idEmpresa AS 'Código da Empresa', f.nome AS 'Nome do Funcionário' 
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Ipiranga';

-- MUSEU DA LÍNGUA PORTUGUESA ---------------------------------------

-- SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
-- FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
-- WHERE e.nome LIKE 'Museu da Língua Portuguesa';

-- SELECT 
-- e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
-- f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha'
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu da Língua Portuguesa';

-- SELECT e.nome AS 'Nome da Empresa', e.idEmpresa AS 'Código da Empresa', f.nome AS 'Nome do Funcionário' 
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu da Língua Portuguesa';

-- MUSEU NACIONAL ---------------------------------------

-- SELECT l.nome AS 'Nome do Documento', s.idSala AS 'ID da Sala', s.nome AS 'Nome da Sala', e.nome 
-- FROM livro AS l JOIN sala AS s ON l.fkSala = s.idSala JOIN empresa AS e ON e.idEmpresa = s.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Nacional';

-- SELECT 
-- e.nome AS 'NomeEmpresa', e.cnpj AS 'CNPJ', e.responsavel AS 'ResponsávelEmpresa', e.cep AS 'CEP', e.numero AS 'NúmeroEmpresa',
-- f.nome AS 'NomeFuncionário', f.cpf AS 'CPF', f.telefone AS 'ContatoCelular', f.email AS 'E-mail', f.senha AS 'Senha'
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Nacional';

-- SELECT e.nome AS 'Nome da Empresa', e.idEmpresa AS 'Código da Empresa', f.nome AS 'Nome do Funcionário' 
-- FROM empresa AS e JOIN funcionario AS f ON e.idEmpresa = f.fkEmpresa 
-- WHERE e.nome LIKE 'Museu Nacional';

-- --------------------------------------------------------------------------------------------------------------------------------------

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
