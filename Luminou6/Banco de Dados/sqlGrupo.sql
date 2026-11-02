CREATE DATABASE bd_luminousix;
USE  bd_luminousix;

CREATE TABLE cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
identificacao_fiscal VARCHAR(45) NOT NULL,
email_contato VARCHAR(100) NOT NULL CONSTRAINT chkEmail_contato CHECK(email_contato LIKE '%@%'), 
telefone VARCHAR(20) NOT NULL,
codigo_ativacao VARCHAR(45)
);

INSERT INTO cliente (nome, identificacao_fiscal, email_contato, telefone, codigo_ativacao) VALUES
('Baunilha Brasil Ltda', '12345678000190', 'contato@baunilhabrasil.com', '11987654321','Urubu100'),
('Fazenda da Baunilha', '98765432000155', 'contato@fazendaBaunilha.com', '11976543210','sptech100'),
('Cultivo Vanilla', '45678912000133', 'contato@cultivovanilla.com', '11965432109','Sptech');

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
email_cadastro VARCHAR(100) CONSTRAINT chkEmail_cadastro CHECK(email_cadastro LIKE '%@%'),
senha_cadastro VARCHAR(100),
cliente_idCliente INT NOT NULL,
admin_fkUsuario INT,

CONSTRAINT fk_usuarioCliente
    FOREIGN KEY (cliente_idCliente)
    REFERENCES cliente(idCliente),

CONSTRAINT fk_usuarioAdmin
    FOREIGN KEY (admin_fkUsuario)
    REFERENCES usuario(idUsuario)
);

INSERT INTO usuario (nome, email_cadastro, senha_cadastro, cliente_idCliente, admin_fkUsuario) VALUES
('Gabriel Silva', 'gabriel@baunilhabrasil.com', '123456', 1, NULL),
('João Santos', 'joao@baunilhabrasil.com', '123456', 1, NULL),
('Maria Oliveira', 'maria@fazendaBaunilha.com', '123456', 2, NULL),
('Pedro Souza', 'pedro@cultivovanilla.com', '123456', 3, NULL);

CREATE TABLE estufa (
idEstufa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
fase_planta VARCHAR(100),
percentual_sombreamento VARCHAR(3),

cliente_idCliente INT NOT NULL,
CONSTRAINT fk_estufaCliente
    FOREIGN KEY (cliente_idCliente)
    REFERENCES cliente(idCliente)
);

INSERT INTO estufa (nome, fase_planta, percentual_sombreamento, cliente_idCliente) VALUES
('Estufa 01', 'crescimento', '50', 1),
('Estufa 02', 'floracao', '60', 1),
('Estufa Principal', 'crescimento', '40', 2),
('Estufa A', 'floracao', '50', 3);

CREATE TABLE configuracao (
  idconfiguracao INT NOT NULL AUTO_INCREMENT,
  ppfdMinimo INT NOT NULL,
  ppfdMaximo INT NOT NULL,
  ppfdAlvo INT NOT NULL,
  metaDLI DECIMAL(5,2) NOT NULL,
  faseDesenvolvimento VARCHAR(45) NOT NULL,
  CONSTRAINT chk_fase CHECK (faseDesenvolvimento IN ('enraizamento','brotamento','crescimento','floracao')),
  ESTUFA_idESTUFA INT NOT NULL,
  PRIMARY KEY (idconfiguracao),
  FOREIGN KEY (ESTUFA_idESTUFA) REFERENCES ESTUFA (idESTUFA)
);



INSERT INTO configuracao(ppfdMinimo, ppfdAlvo, ppfdMaximo, metaDLI, faseDesenvolvimento, ESTUFA_idESTUFA) VALUES
  (200, 250, 300, 14.40, 'enraizamento', 1),
  (250, 300, 400, 17.30, 'brotamento', 1),
  (300, 400, 500, 23.00, 'crescimento', 1),
  (400, 500, 600, 28.80, 'floracao', 1);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
status_sensor VARCHAR(45) CONSTRAINT chkStatus CHECK(status_sensor in('Ativo', 'Inativo')),
codigo_sensor VARCHAR(45) NOT NULL UNIQUE,
estufa_idEstufa INT NOT NULL,

CONSTRAINT fk_sensor_estufa
FOREIGN KEY (estufa_idEstufa)
REFERENCES estufa(idEstufa)
);

INSERT INTO sensor (nome, status_sensor, codigo_sensor, estufa_idEstufa) VALUES
('Sensor Luminosidade 01', 'Ativo', 'LUM001', 1),
('Sensor Luminosidade 02', 'Ativo', 'LUM002', 1),
('Sensor Luminosidade 03', 'Inativo', 'LUM003', 2),
('Sensor Luminosidade 04', 'Ativo', 'LUM004', 3),
('Sensor Luminosidade 05', 'Ativo', 'LUM005', 4);

CREATE TABLE leitura (
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
valorPPFD INT NOT NULL,
data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,

sensor_idSensor INT NOT NULL,

CONSTRAINT fk_leituraSensor
    FOREIGN KEY (sensor_idSensor)
    REFERENCES sensor(idSensor)
);

INSERT INTO leitura (valorPPFD, data_hora, sensor_idSensor) VALUES
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

SELECT
    cliente.nome AS cliente,
    usuario.nome AS usuario,
    usuario.email_cadastro
FROM cliente
JOIN usuario
ON cliente.idCliente = usuario.cliente_idCliente;

SELECT
    estufa.nome AS estufa,
    estufa.fase_planta,
    sensor.nome AS sensor,
    sensor.status_sensor,
    sensor.codigo_sensor
FROM estufa
JOIN sensor
ON estufa.idEstufa = sensor.estufa_idEstufa;

SELECT
    sensor.nome AS sensor,
    sensor.codigo_sensor,
    leitura.valorPPFD,
    leitura.data_hora
FROM sensor
JOIN leitura
ON sensor.idSensor = leitura.sensor_idSensor;

SELECT
    c.nome AS nome_cliente,
    u.nome AS nome_usuario,
    e.nome AS nome_estufa,
    s.nome AS nome_sensor,
    s.status_sensor,
    l.valorPPFD,
    l.data_hora
FROM usuario AS u
JOIN cliente AS c
ON u.cliente_idCliente = c.idCliente
JOIN estufa AS e
ON e.cliente_idCliente = c.idCliente
JOIN sensor AS s
ON s.estufa_idEstufa = e.idEstufa
JOIN leitura AS l
ON l.sensor_idSensor = s.idSensor;

SELECT * FROM configuracao;

SELECT
    e.nome AS estufa,
    c.faseDesenvolvimento,
    c.ppfdMinimo,
    c.ppfdAlvo,
    c.ppfdMaximo,
    c.metaDLI
FROM configuracao AS c
JOIN estufa AS e
ON c.ESTUFA_idESTUFA = e.idEstufa;

SELECT
    e.nome AS estufa,
    e.fase_planta,
    c.ppfdMinimo,
    c.ppfdAlvo,
    c.ppfdMaximo,
    c.metaDLI
FROM estufa AS e
JOIN configuracao AS c
ON c.ESTUFA_idESTUFA = e.idEstufa
AND c.faseDesenvolvimento = e.fase_planta;


