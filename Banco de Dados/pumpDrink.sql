
CREATE DATABASE pumpDrink;
USE pumpDrink;

create table tb_local(
	id_local INT PRIMARY KEY auto_increment,
    nome VARCHAR(50),
    pais VARCHAR(50),
    regiao VARCHAR(50),
    estado VARCHAR(50),
    cidade VARCHAR(50),
    bairro VARCHAR(50),
    rua VARCHAR(50),
    numero INT,
    complemento VARCHAR(100),
    cep char(9)
);

CREATE TABLE tb_empresa(
id_empresa INT PRIMARY KEY auto_increment,
nome_empresa VARCHAR(150),
razao_social VARCHAR(150),
CNPJ CHAR(18),
cep CHAR(9),
email VARCHAR(150),
duracao_contrato TINYINT, 
constraint chkDuracao CHECK (duracao_contrato >= 6) 
);

CREATE TABLE tb_usuario(
id_usuario INT PRIMARY KEY auto_increment,
nome_usuario VARCHAR(150),
email VARCHAR(150),
senha VARCHAR(50),
id_empresa INT,
nivel_usuario char(3),
constraint chk_nivelUser check (nivel_usuario in ("adm", "cmm")),
constraint fk_empresa_usuario FOREIGN KEY (id_empresa) references tb_empresa(id_empresa)
);


CREATE TABLE tb_maquina(
id_maquina INT PRIMARY KEY auto_increment,
descricao TEXT,
fk_local int,
constraint fk_local_maquina foreign key (fk_local) references tb_local(id_local)
);


CREATE TABLE tb_bebida(
id_bebida INT PRIMARY KEY auto_increment,
nome_bebida VARCHAR(50),
tipo VARCHAR(15),
constraint chkTipo CHECK (tipo IN('Pós-Treino', 'Pré-Treino')),
experimental CHAR(1),
constraint chkExperimental CHECK (experimental IN('S','N')),
id_empresa INT,
constraint fk_empresa_bebida FOREIGN KEY (id_empresa) references tb_empresa(id_empresa)
);


CREATE TABLE tb_dispenser(
id_dispenser INT PRIMARY KEY auto_increment,
posicao TINYINT, 
constraint chkPosicao CHECK (posicao IN(1, 2, 3, 4)),
id_maquina INT, 
constraint fk_maquina FOREIGN KEY (id_maquina) references tb_maquina(id_maquina)
);

/*
create table tb_historicoBebidas(
	id_historico int primary key auto_increment,
    id_bebida int,
    id_dispenser int,
    inicio date, 
    fim date
);
*/

CREATE TABLE tb_sensor(
id_sensor INT PRIMARY KEY auto_increment,
validade DATE,
instalacao DATE,
operando CHAR(1), 
constraint chkOperando CHECK (operando IN('S','N')),
id_dispenser INT,
constraint fk_dispenser FOREIGN KEY (id_dispenser) references tb_dispenser(id_dispenser)
);

CREATE TABLE tb_registro(
id_registro INT PRIMARY KEY  auto_increment,
datahora_registro DATETIME DEFAULT current_timestamp() ,
id_sensor INT,
constraint fk_senser FOREIGN KEY (id_sensor) references tb_sensor(id_sensor)
);

-- ------------------------------------------------------------- INSERTS----------------------------------------------------------------

SHOW TABLES;

DESC tb_empresa;
INSERT INTO tb_empresa VALUES 
	(NULL, "Growth", "Growth Supplements - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@growth.com", 72),
    (NULL, "StarBucks", "StarBucks - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@starbucks.com", 48),
    (NULL, "YoPRO", "YoPRO - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@yopro.com", 55),
    (NULL, "Dux", "Dux Supplements - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@gdux.com", 36),
    (NULL, "Piracanjuba", "Piracanjuba - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@piracanjuba.com", 12);

DESC tb_usuario;
INSERT INTO tb_usuario VALUES
	(NULL, "Melissa", "melissa@gmail.com", "12345", 2, "adm"),
    (NULL, "Ciliberti", "ciliberti@gmail.com", "seliberte",2 , "cmm"),
    (NULL, "Matheus", "mat_henri@gmail.com", "eus",5 , "adm"),
    (NULL, "Ivete Sangalo", "ivete@gmail.com", "sangalo",5 , "cmm"),
    (NULL, "Felipe", "naufel@gmail.com", "felps",1 , "adm"),
    (NULL, "Arthur Ali", "ali@gmail.com", "ali",4 , "adm"),
    (NULL, "Isabel", "isinha@gmail.com", "bel",3 , "adm");

DESC tb_local;
INSERT INTO tb_local VALUES 
	("Starbucks Haddock Lobo", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Cerqueira César", "Rua Haddock Lobo", 608, NULL),
    ("SmartFit Capão Redondo", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Capão redondo", "Av. Comendador Sant'Anna", 634, NULL),
    ("Shopping mais", "Sudeste", "São Paulo", "São Paulo", "Santo Amaro", "Rua Haddock Lobo", 608, NULL);
SELECT * FROM tb_empresa;
    
    
    
    


