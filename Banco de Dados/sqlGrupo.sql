CREATE DATABASE sprint2;
USE sprint2;

create table empresa(
    id_empresa int primary key auto_increment,
    nome_empresa VARCHAR(40) NOT NULL,
    cnpj CHAR (30) UNIQUE NOT NULL,
    telefone_corporativo VARCHAR(20)
);

INSERT INTO empresa (nome_empresa, cnpj, telefone_corporativo) VALUES
('Orquídeas do Vale S.A.', '31.849.025/0001-44', '(11) 94025-1849'),
('Baunilha Imperial Extratos', '50.642.119/0001-35', '(19) 96522-8103'),
('Madagascar Soluções Agro', '15.398.241/0001-12', '(62) 98311-5744'),
('Bourbon Flores e Sabores', '81.047.622/0001-90', '(21) 97155-3021'),
('Cerrado Vanilla Orgânicos', '29.753.864/0001-78', '(31) 99204-6652');

create table usuario(
    id_usuario int primary key auto_increment,
    fkEmpresa int,
    nome_completo varchar(40),
    email varchar(40) not null constraint chkEmail check(email like '%@%'),
    senha VARCHAR(100) not null, 
    cargo VARCHAR (100),
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(id_empresa)
);

INSERT INTO usuario (fkEmpresa, nome_completo, email, senha, cargo) VALUES
(1, 'Ricardo Fontes', 'ricardo.f89@orquideasvale.com', 'p@ss9102_X', 'Gestor de Estufas'),
(2, 'Camila Schmidt', 'camila.s@baunilhaimperial.com', 'sec_mada99', 'Supervisora de Cura'),
(3, 'Felipe Nogueira', 'felipe.nog@madagascaragro.com', 'Fe#2026_agro', 'Engenheiro de Campo'),
(4, 'Juliana Meireles', 'jumeireles@bourbonflores.com', 'mudar@12345', 'Técnica Agrícola'),
(5, 'Marcos Vinícius', 'marcos.v@cerradovanilla.com', 'orquidea!88', 'Polinizador Sênior');

create table localizacao(
    id_localizacao int primary key auto_increment,
    local_alocado int,
    latitude DECIMAL(10,2),
    longitude DECIMAL (10,2),
    ponto_referencia VARCHAR (100)
);

INSERT INTO localizacao (local_alocado, latitude, longitude, ponto_referencia) VALUES
(101, -16.45, -48.33, 'Próximo à cerca divisória do Setor Sul, sob sombrite 60%'),
(112, -22.18, -46.74, 'Canteiro experimental de tutor vivo, perto da vala de drenagem'),
(501, -20.03, -44.12, 'Estufa de mudas novas, ao lado da caixa dágua principal'),
(340, -12.97, -38.51, 'Área de secagem outdoor, quadrante central B'),
(889, -23.95, -47.20, 'Lote de orquídeas em floração, atrás do galpão de ferramentas');

create table sensor(
    id_sensor int primary key auto_increment,
    codigo_sensor int unique,
    fkLocalizacao int,
    intensidadeLuminosidade_ideal decimal(10,2) default 800.00 ,
    statuss varchar(10),
    luminosidade decimal(10,2),
    data_leitura datetime default current_timestamp,
    CONSTRAINT fk_sensor_localizacao FOREIGN KEY (fkLocalizacao) REFERENCES localizacao(id_localizacao)
);

INSERT INTO sensor (codigo_sensor, fkLocalizacao, intensidadeLuminosidade_ideal, statuss, luminosidade) VALUES
(9482, 1, 800.00, 'ativo', 764.20),
(1105, 2, 750.00, 'ativo', 892.00),
(3391, 3, 800.00, 'inativo', 0.00),
(4820, 4, 400.00, 'ativo', 385.50),
(2744, 5, 850.00, 'ativo', 841.10);

SELECT * FROM usuario 
JOIN empresa
ON fkEmpresa = id_empresa;

SELECT * FROM sensor
JOIN localizacao
ON fkLocalizacao = id_localizacao;

SELECT 
    e.nome_empresa AS nome,
    u.nome_completo AS nome_usuario,
    l.ponto_referencia AS localizacao,
    s.luminosidade
FROM usuario AS u
JOIN empresa AS e ON u.fkEmpresa = e.id_empresa
JOIN sensor AS s
JOIN localizacao AS l ON s.fkLocalizacao = l.id_localizacao;

