CREATE DATABASE bd_luminousix;
USE  bd_luminousix;

 CREATE TABLE cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
tipo_cliente VARCHAR(45) NOT NULL,
identificacao_fiscal VARCHAR(45) NOT NULL,
email_contato VARCHAR(100) NOT NULL CONSTRAINT chkEmail_contato CHECK(email_contato LIKE '%@%'), 
telefone VARCHAR(20) NOT NULL
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
email_cadastro VARCHAR(100) CONSTRAINT chkEmail_cadastro CHECK(email_cadastro LIKE '%@%'),
senha_cadastro VARCHAR(100),
cargo VARCHAR(100),
cliente_idCliente INT NOT NULL,
admin_fkUsuario INT,

CONSTRAINT fk_usuarioCliente
	FOREIGN KEY (cliente_idCliente)
	REFERENCES cliente(idCliente),

CONSTRAINT fk_usuarioAdmin
	FOREIGN KEY (admin_fkUsuario)
    REFERENCES usuario(idUsuario)
);

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

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
status_sensor VARCHAR(45) CONSTRAINT chkStatus CHECK(status_sensor in('Ativo', 'Inativo')),
codigo_sensor VARCHAR(45) NOT NULL UNIQUE,
estufa_idEstufa INT NOT NULL,

CONSTRAINT fk_sensor_estufa
	FOREIGN KEY (ESTUFA_idESTUFA)
	REFERENCES ESTUFA(idESTUFA)
);

CREATE TABLE leitura (
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
valorADC INT NOT NULL,
PPFD DECIMAL(10,2) NOT NULL,
data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,

sensor_idSensor INT NOT NULL,

CONSTRAINT fk_leituraSensor
	FOREIGN KEY (sensor_idSensor)
	REFERENCES sensor(idSensor)
);
