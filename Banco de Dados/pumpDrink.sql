CREATE DATABASE pumpDrink;
USE pumpDrink;



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

INSERT INTO tb_empresa VALUES 
	(NULL, "Growth", "Growth Supplements - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@growth.com", 72),
    (NULL, "StarBucks", "StarBucks - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@starbucks.com", 48),
    (NULL, "YoPRO", "YoPRO - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@yopro.com", 55),
    (NULL, "Dux", "Dux Supplements - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@gdux.com", 36),
    (NULL, "Piracanjuba", "Piracanjuba - Produtos Alimenticios LTDA", "11.222.333/0001-44", "00000-000", "marketing@piracanjuba.com", 12);
    

CREATE TABLE tb_usuario(
	id_usuario INT NOT NULL auto_increment,
	nome_usuario VARCHAR(150),
	email VARCHAR(150),
	senha VARCHAR(50),
	fk_empresa INT NOT NULL,
	nivel_usuario CHAR(3),
	constraint chk_nivelUser check (nivel_usuario in ("adm", "cmm")),
	constraint fk_empresa_usuario FOREIGN KEY (fk_empresa) references tb_empresa(id_empresa),
    constraint pk_usuario PRIMARY KEY (id_usuario, fk_empresa)
);

INSERT INTO tb_usuario VALUES
	(NULL, "Melissa", "melissa@gmail.com", "12345", 2, "adm"),
    (NULL, "Ciliberti", "ciliberti@gmail.com", "seliberte",2 , "cmm"),
    (NULL, "Matheus", "mat_henri@gmail.com", "eus",5 , "adm"),
    (NULL, "Ivete Sangalo", "ivete@gmail.com", "sangalo",5 , "cmm"),
    (NULL, "Felipe", "naufel@gmail.com", "felps",1 , "adm"),
    (NULL, "Arthur Ali", "ali@gmail.com", "ali",4 , "adm"),
    (NULL, "Isabel", "isinha@gmail.com", "bel",3 , "adm");


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
    cep CHAR(9)
);

INSERT INTO tb_local VALUES 
	(NULL,"Starbucks Haddock Lobo", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Cerqueira César", "Rua Haddock Lobo", 608, NULL, "00000-000"),
    (NULL,"SmartFit Capão Redondo", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Capão redondo", "Av. Comendador Sant'Anna", 634, NULL, "00000-000"),
    (NULL,"Shopping mais", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Santo Amaro", "Rua Haddock Lobo", 608, NULL, "00000-000"),
	(NULL,"Parque Ibirapuera", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Vila Mariana", "Av. Pedro Álvares Cabral", NULL, NULL, "00000-000"),
    (NULL,"Smart Fit - Prado Boulevard", "Brasil", "Sudeste", "São Paulo", "São Paulo", "Vila Mariana", "Av. Pedro Álvares Cabral", 2480, NULL, "00000-000");


CREATE TABLE tb_maquina(
	id_maquina INT auto_increment,	
	descricao TEXT,
	fk_local int,
	constraint fk_local_maquina FOREIGN KEY (fk_local) references tb_local(id_local),
    constraint pk_maquina PRIMARY KEY (id_maquina, fk_local)
);

INSERT INTO tb_maquina VALUES
	(NULL, "Essa máquina está localizada perto da entrada da academia", 2),
    (NULL, "Primeira máquina em que a bebida x foi lançada", 1),
    (NULL, "Está pocalizado ao lado da loja sports", 3),
    (NULL, "Localizado na saída", 4),
    (NULL, "Ao lado do bebedouro", 5);


CREATE TABLE tb_bebida(
	id_bebida INT auto_increment,
	nome_bebida VARCHAR(50),
	tipo VARCHAR(15),
	constraint chkTipo CHECK (tipo IN('Pós-Treino', 'Pré-Treino')),
	fk_empresa INT,
	constraint fk_empresa_bebida FOREIGN KEY (fk_empresa) references tb_empresa(id_empresa),
    constraint pk_bebida PRIMARY KEY (id_bebida, fk_empresa) 
);

INSERT INTO tb_bebida VALUES
    (NULL, "Suco de uva", "Pré-Treino", 1),
    (NULL, "Suco de Manga", "Pós-Treino", 1),
    (NULL, "Café", "Pré-Treino", 2),
    (NULL, "Chá", "Pós-Treino", 2),
    (NULL, "Coca-cola", "Pré-Treino", 3),
    (NULL, "Guaraná", "Pós-Treino", 3),
    (NULL, "Gatorade", "Pré-Treino", 4),
    (NULL, "Ironage", "Pós-Treino", 4),
	(NULL, "Todynho", "Pré-Treino", 5),
    (NULL, "Nescau", "Pós-Treino", 5);


CREATE TABLE tb_dispenser(
	id_dispenser INT auto_increment,
	posicao TINYINT, 
	constraint chkPosicao CHECK (posicao IN(1, 2, 3, 4)),
	fk_maquina INT, 
	constraint fk_maquina FOREIGN KEY (fk_maquina) references tb_maquina(id_maquina),
    fk_bebida INT,
    constraint fk_bebida FOREIGN KEY (fk_bebida) references tb_bebida(id_bebida),
    constraint pk_dispenser PRIMARY KEY (id_dispenser, fk_maquina)
);

INSERT INTO tb_dispenser VALUES
	-- Máquina 1
	(NULL, 1, 1, 1),
    (NULL, 2, 1, 2),
    (NULL, 3, 1, 3),
    (NULL, 4, 1, 4),
    -- Máquina 2
	(NULL, 1, 2, 5),
    (NULL, 2, 2, 6),
    (NULL, 3, 2, 7),
    (NULL, 4, 2, 8),
    -- Máquina 3
	(NULL, 1, 3, 9),
    (NULL, 2, 3, 10),
    (NULL, 3, 3, 1),
    (NULL, 4, 3, 2),
    -- Máquina 4
	(NULL, 1, 4, 3),
    (NULL, 2, 4, 4),
    (NULL, 3, 4, 5),
    (NULL, 4, 4, 6),
     -- Máquina 5
	(NULL, 1, 5, 7),
    (NULL, 2, 5, 8),
    (NULL, 3, 5, 9),
    (NULL, 4, 5, 10);
    

CREATE TABLE tb_sensor(
	id_sensor INT PRIMARY KEY auto_increment,
	validade DATE,
	instalacao DATE,
	operando CHAR(1), 
	constraint chkOperando CHECK (operando IN('S','N')),
	fk_dispenser INT,
	constraint fkDispenser FOREIGN KEY (fk_dispenser) references tb_dispenser(id_dispenser)
);

INSERT INTO tb_sensor VALUES
	(NULL, "2025-05-11", "2022-04-04", "S", 1),
    (NULL, "2025-05-11", "2022-04-04", "S", 2),
    (NULL, "2025-05-11", "2022-04-04", "S", 3),
	(NULL, "2025-05-11", "2022-04-04", "S", 4),
	(NULL, "2025-05-11", "2022-04-04", "S", 5),
	(NULL, "2025-05-11", "2022-04-04", "S", 6),
	(NULL, "2025-05-11", "2022-04-04", "S", 7),
	(NULL, "2025-05-11", "2022-04-04", "S", 8),
	(NULL, "2025-05-11", "2022-04-04", "S", 9),
	(NULL, "2025-05-11", "2022-04-04", "S", 10),
	(NULL, "2025-05-11", "2022-04-04", "S", 11),
	(NULL, "2025-05-11", "2022-04-04", "S", 12),
	(NULL, "2025-05-11", "2022-04-04", "S", 13),
	(NULL, "2025-05-11", "2022-04-04", "S", 14),
	(NULL, "2025-05-11", "2022-04-04", "S", 15),
	(NULL, "2025-05-11", "2022-04-04", "S", 16),
	(NULL, "2025-05-11", "2022-04-04", "S", 17),
	(NULL, "2025-05-11", "2022-04-04", "S", 18),
	(NULL, "2025-05-11", "2022-04-04", "S", 19),
	(NULL, "2025-05-11", "2022-04-04", "S", 20);
    
CREATE TABLE tb_registro(
	id_registro INT auto_increment,
	datahora_registro DATETIME DEFAULT current_timestamp() ,
	fk_sensor INT,
    aprox_registro CHAR (1),
	constraint fk_sensor FOREIGN KEY (fk_sensor) references tb_sensor(id_sensor),
    constraint pk_registro PRIMARY KEY (id_registro, fk_sensor)
);

INSERT INTO tb_registro VALUES
    (NULL, default, "1"),
    (NULL, default, "2"),
    (NULL, default, "3"),
	(NULL, default,"4"),
	(NULL, default,"5"),
	(NULL, default,"6"),
	(NULL, default,"7"),
	(NULL, default,"8"),
	(NULL, default,"9"),
	(NULL, default,"10"),
	(NULL, default,"11"),
	(NULL, default,"12"),
	(NULL, default,"13"),
	(NULL, default,"14"),
	(NULL, default,"15"),
	(NULL, default,"16"),
	(NULL, default,"17"),
	(NULL, default,"18"),
	(NULL, default,"19"),
	(NULL, default,"20");

