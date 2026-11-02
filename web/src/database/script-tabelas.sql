-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

-- CREATE DATABASE aquatech;

-- USE aquatech;

-- CREATE TABLE empresa (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	razao_social VARCHAR(50),
-- 	cnpj CHAR(14),
-- 	codigo_ativacao VARCHAR(50)
-- );

-- CREATE TABLE usuario (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	nome VARCHAR(50),
-- 	email VARCHAR(50),
-- 	senha VARCHAR(50),
-- 	fk_empresa INT,
-- 	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
-- );

-- CREATE TABLE aviso (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	titulo VARCHAR(100),
-- 	descricao VARCHAR(150),
-- 	fk_usuario INT,
-- 	FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
-- );

-- create table aquario (
-- /* em nossa regra de negócio, um aquario tem apenas um sensor */
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	descricao VARCHAR(300),
-- 	fk_empresa INT,
-- 	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
-- );

-- /* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

-- create table medida (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	temperatura DECIMAL,
-- 	momento DATETIME,
-- 	fk_aquario INT,
-- 	FOREIGN KEY (fk_aquario) REFERENCES aquario(id)
-- );

-- insert into empresa (razao_social, codigo_ativacao) values ('Empresa 1', 'ED145B');
-- insert into empresa (razao_social, codigo_ativacao) values ('Empresa 2', 'A1B2C3');
-- insert into aquario (descricao, fk_empresa) values ('Aquário de Estrela-do-mar', 1);
-- insert into aquario (descricao, fk_empresa) values ('Aquário de Peixe-dourado', 2);

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

INSERT INTO usuario (nome, email_cadastro, senha_cadastro, cargo, cliente_idCliente, admin_fkUsuario) VALUES
('Gabriel Silva', 'gabriel@baunilhabrasil.com', '123456', 'Administrador', 1, NULL),
('João Santos', 'joao@baunilhabrasil.com', '123456', 'Técnico', 1, NULL),
('Maria Oliveira', 'maria@fazendaBaunilha.com', '123456', 'Administrador', 2, NULL),
('Pedro Souza', 'pedro@cultivovanilla.com', '123456', 'Técnico', 3, NULL);