SELECT tb_local.nome,
    concat(
        rua, ', ',
        ifnull(numero, 'S/N'), ' - ',
        bairro, ' - ',
        cep, ' - ',
        cidade, ' - ',
        estado
    ) as 'endereco',
    count(id_registro) as 'saidas'
FROM tb_maquina
    JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
    JOIN tb_dispenser ON tb_dispenser.fk_maquina = tb_maquina.id_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
    JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_registro ON tb_sensor.id_sensor = tb_registro.fk_sensor
WHERE id_bebida = 5
GROUP BY fk_local;


SELECT tb_local.nome as 'unidade',
    concat(
        rua, ', ',
        ifnull(numero, 'S/N'), ' - ',
        bairro, ' - ',
        cep, ' - ',
        cidade, ' - ',
        estado
    ) as 'endereco',
    count(id_registro) as 'saidas'
FROM tb_maquina
    JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
    JOIN tb_dispenser ON tb_dispenser.fk_maquina = tb_maquina.id_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
    JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_registro ON tb_sensor.id_sensor = tb_registro.fk_sensor
WHERE tb_bebida.nome_bebida = 'Coca-Cola'
GROUP BY fk_local;

SELECT date_format(prazo_final, '%d-%m-%Y') as 'prazo',
    meta_geral as 'meta'
FROM tb_bebida
WHERE nome_bebida = 'Coca-Cola';

DESCRIBE tb_dispenser;

INSERT INTO tb_local VALUES 
    (null, ${nome}, ${pais}, ${regiao}, ${estado}, ${cidade}, ${bairro}, ${rua}, ${num}, ${comp}, ${cep});

INSERT INTO tb_maquina VALUES
    (null, ${descricao}, (SELECT id_local FROM tb_local ORDER BY id_local DESC LIMIT 1));

INSERT INTO tb_dispenser VALUES
    (null, 1, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), ${dispenser1}),
    (null, 2, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), ${dispenser2}),
    (null, 3, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), ${dispenser3}),
    (null, 4, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), ${dispenser4});


INSERT INTO tb_local VALUES 
    (null, 'Casa do Lucas', 'Brasil', 'Norte', 'RO', 'São Lucas', 'Jd. do Lucas', 'Rua do Lucas', '666', '', '00000-666');


SELECT * FROM tb_local;

INSERT INTO tb_maquina VALUES
    (null, 'Na frente da casa do Lucas', (SELECT id_local FROM tb_local ORDER BY id_local DESC LIMIT 1));

SELECT * FROM tb_maquina;

INSERT INTO tb_dispenser VALUES
    (null, 1, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), 1),
    (null, 2, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), 3),
    (null, 3, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), 5),
    (null, 4, (SELECT id_maquina FROM tb_maquina ORDER BY id_maquina DESC LIMIT 1), 6);

SELECT * FROM tb_dispenser;

SELECT tb_local.nome as 'unidade', concat(rua, ', ', ifnull(numero, 'S/N'), ' - ', bairro, ' - ', cep, ' - ', cidade, ' - ', estado) as 'endereco',
        count(id_registro) as 'saidas'
        FROM tb_maquina
            LEFT JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
            LEFT JOIN tb_dispenser ON tb_dispenser.fk_maquina = tb_maquina.id_maquina
            LEFT JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
            LEFT JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            LEFT JOIN tb_registro ON tb_sensor.id_sensor = tb_registro.fk_sensor
            WHERE tb_bebida.id_bebida = 5
        GROUP BY fk_local