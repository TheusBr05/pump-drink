DROP database pumpdrink;
CREATE DATABASE pumpDrink;
USE pumpDrink;

create table tb_empresa(
	id_empresa int primary key auto_increment,
    nome_empresa varchar(150),
    razao_social varchar(150),
    CNPJ char(14),
    cep char(8),
    email varchar(150),
    duracao_contrato tinyint, 
    constraint chkDuracao check (duracaoContrato >= 6) 
);

/*
create table tb_contrato(
	id_contrato int primary key auto_increment,
    inicio_contrato date,
    fim_contrato date
);
*/

create table tb_usuario(
	id_usuario int primary key auto_increment,
    nome_usuario varchar(150),
    email varchar(150),
    senha varchar(50),
    id_empresa int,
    constraint fk_empresa_usuario foreign key (id_empresa) references tb_empresa(id_empresa)
);

create table tb_maquina(
	id_maquina int primary key auto_increment,
    endereco varchar(150),
    local_referencia varchar(50)
);

create table tb_bebida(
	id_bebida int primary key auto_increment,
    nome_bebida varchar(50),
    tipo varchar(15),
    constraint chkTipo CHECK (tipo IN('Pós-Treino', 'Pré-Treino')),
    experimental char(1),
    constraint chkExperimental CHECK (experimental IN('S','N')),
    id_empresa int,
    constraint fk_empresa_bebida foreign key (id_empresa) references tb_empresa(id_empresa)
);


create table tb_dispenser(
	id_dispenser int primary key auto_increment,
    posicao tinyint, 
    constraint chkPosicao check (posicao in(1, 2, 3, 4)),
    id_maquina int, 
    constraint fk_maquina foreign key (id_maquina) references tb_maquina(id_maquina)
);

/*
create table tb_historicoBebidas(
	id_historico int primary key auto_increment,
    id_bebida int,
    id_slot int,
    inicio date, 
    fim date
);
*/


create table tb_sensor(
    id_sensor int primary key auto_increment,
    validade date,
    instalacao date,
    operando char(1), 
    constraint chkOperando CHECK (operando IN('S','N')),
    id_dispenser int,
    constraint fk_dispenser foreign key (id_dispenser) references tb_dispenser(id_dispenser)
);

create table tb_registro(
	id_registro int primary key auto_increment,
    datahora_registro datetime default(current_timestamp()),
    id_sensor int,
    constraint fk_senser foreign key (id_sensor) references tb_sensor(id_sensor)
);

-- ------------------------------------------------------------- ANTIGA VERSÃO ----------------------------------------------------------------

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY auto_increment,
nomeUsuario VARCHAR(100) NOT NULL,
razaoSocial VARCHAR(100) NOT NULL,
cnpj CHAR(14) NOT NULL UNIQUE,
endereco VARCHAR(80) NOT NULL,
bairro VARCHAR(50) NOT NULL,
cep CHAR(8) NOT NULL,
cidade VARCHAR(40) NOT NULL,
estado VARCHAR(10) NOT NULL,
telefone CHAR(11) NOT NULL,
email VARCHAR(100) NOT NULL,
senha VARCHAR(40) NOT NULL,
dtContrato DATETIME DEFAULT current_timestamp,
duracaoContrato tinyint constraint chkDuracao check (duracaoContrato >= 6) 
);

CREATE TABLE Bebidas (
idBebida INT PRIMARY KEY auto_increment,
nomeBebida VARCHAR(50) NOT NULL,
tipoBebida CHAR(15),
marca VARCHAR(50),
experimental CHAR(1) constraint chkExperimental CHECK (experimental IN('S','N')),
disponibilidade VARCHAR(1) constraint chkDisp CHECK (disponibilidade IN('S','N'))
);

CREATE TABLE SensorTCRT5000 (
idSensor INT PRIMARY KEY auto_increment, -- 
operando VARCHAR(1), constraint chkOperando CHECK (operando IN('S','N'))
); 
-- fkIdBebida

CREATE TABLE DadosSensores (
idDadosSensores INT PRIMARY KEY auto_increment,
dtAtual DATETIME DEFAULT current_timestamp ,
presenca tinyint constraint chkpresenca CHECK (presenca IN(1))
);
-- fkIdSensor

CREATE TABLE Maquina (
idMaquina INT PRIMARY KEY auto_increment,
slotMaquina tinyint,
nomeLocal VARCHAR(50) NOT NULL,
endereco VARCHAR(80) NOT NULL);
-- fkIdSensor   --  fkIdBebida

INSERT INTO Usuario (nomeUsuario, razaoSocial, cnpj, endereco, bairro, cep, cidade, estado, telefone, email, senha, duracaoContrato) VALUES
('Integralmedica', 'BRG Suplementos Nutricionais LTDA', '57235426000141', 'Rodovia Jose Simoes Louro Junior 40582' ,
'VAL FLOR', '06906100', 'EMBU-GUACU', 'SP', '01146627300', 'grupo-fiscal@integralmedica.com.br', '000000000', '6'),
('GROWTH SUPPLEMENTS', 'GROWTH SUPPLEMENTS - PRODUTOS ALIMENTICIOS LTDA', '10832644000108', 'Av Wilson Lemos, 2850', 
'Santa Luzia', '88200000', 'Tijucas', 'SC', '4892116480', 'fiscalgrowthsupplements@gmail.com', '0000000000','6'),
('MAX Titanium', 'SUPLEY LABORATORIO DE ALIMENTOS E SUPLEMENTOS NUTRICIONAIS LTDA', '07578713000429', 'Avenida Jose Pilo, 161', 
'DISTRITO INDUSTRIAL ADOLFO BALDAN', '15991312', 'Matão', 'SP', '1635062045','sueli@supley.com.br', '00000000','6');

INSERT INTO Bebidas VALUES
(NULL, 'Huger Maçã','Pré-Treino', ' Integralmedica', 'N', 'S'),
(NULL, 'Bebida Fictícia 01','Pré-Treino', ' Integralmedica', 'S', 'S'),
(NULL, 'Bebida Fictícia 02','Pós-Treino', ' Integralmedica', 'S', 'S'),
(NULL, 'R4:1 Recovery Powder Limão', 'Pós-treino',' Integralmedica', 'N', 'S'),
(NULL, 'Whey Protein Isolado Morango', 'Pós-Treino','Growth', 'N','S'),
(NULL, 'Haze Hardcore Tutti-Frutti', 'Pré-Treino','Growth', 'N', 'S'),
(NULL, 'Bebida Fictícia 03', 'Pré-Treino','Growth', 'S', 'S'),
(NULL, 'Bebida Fictícia 04', 'Pós-Treino','Growth', 'S', 'S'),
(NULL, 'IsoWhey Baunilha', 'Pós-Treino','MaxTitanium', 'N', 'S'),
(NULL, 'Égide Frutas Vermelhas', 'Pré-Treino','MaxTitanium', 'N', 'S'),
(NULL, 'Bebida Fictícia 05', 'Pré-Treino','MaxTitanium', 'S', 'S'),
(NULL, 'Bebida Fictícia 06', 'Pós-Treino','MaxTitanium', 'S', 'S');

INSERT INTO sensortcrt5000 VALUES
(NULL, 'S'),
(NULL, 'N'),
(NULL, 'S'),
(NULL, 'N'),
(NULL, 'S'),
(NULL, 'N'),
(NULL, 'S'),
(NULL, 'S'),
(NULL, 'S'),
(NULL, 'S'),
(NULL, 'N'),
(NULL, 'S');