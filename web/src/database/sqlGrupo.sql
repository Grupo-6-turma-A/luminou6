CREATE DATABASE bd_luminousix;
USE bd_luminousix;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    identificacao_fiscal VARCHAR(45) NOT NULL,
    email_contato VARCHAR(100) NOT NULL,
    CONSTRAINT chkEmail_contato CHECK (email_contato LIKE '%@%'),
    telefone VARCHAR(20) NOT NULL,
    codigo_ativacao VARCHAR(45)
);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email_cadastro VARCHAR(100) NOT NULL,
    senha_cadastro VARCHAR(100) NOT NULL,
    fkEmpresa INT NOT NULL,
    fkSupervisor INT,
    CONSTRAINT chkEmail_cadastro CHECK (email_cadastro LIKE '%@%'),
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT fk_usuario_supervisor FOREIGN KEY (fkSupervisor) REFERENCES usuario(idUsuario)
);

CREATE TABLE parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    ppfdMinimo INT NOT NULL,
    ppfdMaximo INT NOT NULL,
    metaDLI DECIMAL(5,2) NOT NULL,
    faseDesenvolvimento VARCHAR(15) NOT NULL,
    CONSTRAINT chkFase_desenvolvimento CHECK (faseDesenvolvimento IN ('enraizamento','brotamento','crescimento','floracao'))
);

CREATE TABLE estufa (
    idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    percentual_sombreamento CHAR(3),
    fkEmpresa INT NOT NULL,
    fkParametro INT NOT NULL UNIQUE,
    CONSTRAINT fk_estufa_empresa
        FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT fk_estufa_parametro
        FOREIGN KEY (fkParametro) REFERENCES parametro(idParametro)
);


CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    status_sensor VARCHAR(45),
    fkEstufa INT NOT NULL,
    CONSTRAINT chkStatus CHECK (status_sensor IN ('Ativo','Inativo')),
    CONSTRAINT fk_sensor_estufa
        FOREIGN KEY (fkEstufa) REFERENCES estufa(idEstufa)
);

	
CREATE TABLE leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    valorPPFD INT NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT NOT NULL,
    CONSTRAINT fk_leitura_sensor
	FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);


INSERT INTO empresa (nome, identificacao_fiscal, email_contato, telefone, codigo_ativacao) VALUES
('Baunilha Brasil Ltda', '12345678000190', 'contato@baunilhabrasil.com', '11987654321','Urubu100'),
('Fazenda da Baunilha', '98765432000155', 'contato@fazendaBaunilha.com', '11976543210','sptech100'),
('Cultivo Vanilla', '45678912000133', 'contato@cultivovanilla.com', '11965432109','Sptech');

INSERT INTO usuario (nome, email_cadastro, senha_cadastro, fkEmpresa, fkSupervisor) VALUES
('Gabriel Silva', 'gabriel@baunilhabrasil.com', '123456', 1, NULL),
('João Santos', 'joao@baunilhabrasil.com', '123456', 1, NULL),
('Maria Oliveira', 'maria@fazendaBaunilha.com', '123456', 2, NULL),
('Pedro Souza', 'pedro@cultivovanilla.com', '123456', 3, NULL);


INSERT INTO parametro (ppfdMinimo, ppfdMaximo, metaDLI, faseDesenvolvimento) VALUES
(300, 500, 23.00, 'crescimento'),
(400, 600, 28.80, 'floracao'),   
(300, 500, 23.00, 'crescimento'),  
(400, 600, 28.80, 'floracao');     

INSERT INTO estufa (nome, percentual_sombreamento, fkEmpresa, fkParametro) VALUES
('Estufa 01', '50', 1, 1),
('Estufa 02', '60', 1, 2),
('Estufa Principal', '40', 2, 3),
('Estufa A', '50', 3, 4);


INSERT INTO sensor (nome, status_sensor, fkEstufa) VALUES
('Sensor Luminosidade 01', 'Ativo', 1),
('Sensor Luminosidade 02', 'Ativo', 1),
('Sensor Luminosidade 03', 'Inativo',  2),
('Sensor Luminosidade 04', 'Ativo', 3),
('Sensor Luminosidade 05', 'Ativo', 4);

INSERT INTO leitura (valorPPFD, data_hora, fkSensor) VALUES
(420, '2026-09-25 08:00:00', 1),
(580, '2026-09-25 10:00:00', 1),
(720, '2026-09-25 12:00:00', 1),
(650, '2026-09-25 14:00:00', 1),
(500, '2026-09-25 16:00:00', 1),
(380, '2026-09-25 08:30:00', 2),
(550, '2026-09-25 10:30:00', 2),
(690, '2026-09-25 12:30:00', 2),
(610, '2026-09-25 14:30:00', 2),
(450, '2026-09-25 16:30:00', 2),
(460, '2026-09-25 09:00:00', 3),
(620, '2026-09-25 11:00:00', 4),
(750, '2026-09-25 13:00:00', 4),
(570, '2026-09-25 15:00:00', 5);

SELECT * FROM empresa 
JOIN usuario ON 
empresa.idEmpresa = usuario.fkEmpresa;


SELECT sensor.nome AS nomeSensor,
sensor.status_sensor AS statusSensor,
leitura.valorPPFD AS PPFD,
leitura.data_hora AS DataLeitura
FROM sensor JOIN leitura ON
sensor.idSensor = leitura.fkSensor;

SELECT em.nome AS nomeEmpresa,
es.nome AS nomeEstufa,
s.nome AS nomeSensor,
s.status_sensor AS statusSensor
FROM sensor AS s 
JOIN estufa  AS es ON 
es.idEstufa = s.fkEstufa
JOIN empresa AS em ON
es.fkEmpresa = em.idEmpresa;

SELECT em.nome AS nomeEmpresa,
es.nome AS nomeEstufa,
s.nome AS nomeSensor,
l.valorPPFD AS PPFD,
l.data_hora AS dataLeitura
FROM leitura AS l
JOIN sensor AS s ON
s.idSensor = l.fkSensor
JOIN estufa AS es ON
es.idEstufa = s.fkEstufa
JOIN empresa AS em ON
em.idEmpresa = es.fkEmpresa
ORDER BY em.nome, es.nome, l.data_hora;


SELECT sensor.nome AS nomeSensor,
sensor.status_sensor AS statusSensor,
leitura.valorPPFD,
CASE
WHEN valorPPFD > 600 THEN 'PPFD acima do esperado'
WHEN valorPPFD < 200 THEN 'PPFD abaixo do esperado'
ELSE 'Estável'
END AS 'PPFD',
leitura.data_hora AS DataLeitura
FROM sensor JOIN leitura ON
sensor.idSensor = leitura.fkSensor;