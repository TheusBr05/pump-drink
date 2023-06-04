-- Procedure Desempenho Geral
DELIMITER $$
CREATE PROCEDURE desempenho_geral (IdBebidaVAR INT)
BEGIN 

SELECT format(
        (
            SELECT count(*)
            FROM tb_registro
                JOIN tb_sensor ON id_sensor = fk_sensor
                JOIN tb_dispenser ON id_dispenser = fk_dispenser
            WHERE fk_bebida = IdBebidaVAR
        ) * 100 / (
            SELECT meta_geral / timestampdiff(day, prazo_inicio, prazo_final) * 
            timestampdiff(day, prazo_inicio, now())
            FROM tb_bebida
            WHERE id_bebida = IdBebidaVAR
        ),
        2
    ) as 'desempenho_geral';

END $$

-- Procedure Unidades Abaixo
DELIMITER $$
CREATE PROCEDURE unidades_abaixo(IdBebidaVAR int)
BEGIN

SELECT
    (COUNT(*) / (
            SELECT COUNT(*) AS total_dispensers
            FROM tb_dispenser
            WHERE fk_bebida = IdBebidaVAR
        ) * 100
    ) AS percentual_abaixo_meta
FROM (
        SELECT
            tb_dispenser.id_dispenser,
            COUNT(*) AS Saidas,
            tb_bebida.meta_geral / dispensers_bebida AS meta_unidade
        FROM tb_dispenser
            LEFT JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            LEFT JOIN tb_registro ON tb_registro.fk_sensor = tb_sensor.id_sensor
            LEFT JOIN tb_bebida ON tb_dispenser.fk_bebida = tb_bebida.id_bebida
            LEFT JOIN (
                SELECT id_dispenser,
                    COUNT(*) AS dispensers_bebida
                FROM tb_dispenser
                WHERE fk_bebida = IdBebidaVAR
                GROUP BY id_dispenser
            ) AS subquery ON tb_dispenser.id_dispenser = subquery.id_dispenser
        WHERE tb_bebida.id_bebida = IdBebidaVAR
        GROUP BY tb_dispenser.id_dispenser,
            tb_bebida.meta_geral / dispensers_bebida
    ) AS subquery
WHERE Saidas < meta_unidade;


END$$


-- Procedure Unidades Acima
DELIMITER $$
CREATE PROCEDURE unidades_acima(IdBebidaVAR int)
BEGIN

SELECT
    (COUNT(*) / (
            SELECT COUNT(*) AS total_dispensers
            FROM tb_dispenser
            WHERE fk_bebida = IdBebidaVAR
        ) * 100
    ) AS percentual_acima_meta
FROM (
        SELECT
            tb_dispenser.id_dispenser,
            COUNT(*) AS Saidas,
            tb_bebida.meta_geral / dispensers_bebida AS meta_unidade
        FROM tb_dispenser
            LEFT JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            LEFT JOIN tb_registro ON tb_registro.fk_sensor = tb_sensor.id_sensor
            LEFT JOIN tb_bebida ON tb_dispenser.fk_bebida = tb_bebida.id_bebida
            LEFT JOIN (
                SELECT id_dispenser,
                    COUNT(*) AS dispensers_bebida
                FROM tb_dispenser
                WHERE fk_bebida = IdBebidaVAR
                GROUP BY id_dispenser
            ) AS subquery ON tb_dispenser.id_dispenser = subquery.id_dispenser
        WHERE tb_bebida.id_bebida = IdBebidaVAR
        GROUP BY tb_dispenser.id_dispenser,
            tb_bebida.meta_geral / dispensers_bebida
    ) AS subquery
WHERE Saidas >= meta_unidade;


END$$

-- Procedure Perído de Teste
DELIMITER $$
CREATE PROCEDURE periodo_de_teste(IdBebidaVAR INT)
BEGIN 
SELECT DATE_FORMAT(tb_registro.datahora_registro, '%d-%m') as dia,
    count(*) as 'saidas'
FROM tb_registro
    JOIN tb_sensor ON tb_sensor.id_sensor = tb_registro.fk_sensor
    JOIN tb_dispenser ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
WHERE fk_bebida = 1
GROUP BY DATE_FORMAT(tb_registro.datahora_registro, '%d-%m')
ORDER BY DATE_FORMAT(tb_registro.datahora_registro, '%d-%m') DESC
LIMIT 7;

END $$

-- Procedure Saídas por Unidades
DELIMITER $$
CREATE PROCEDURE saidas_por_unidade(IdBebidaVAR INT)
BEGIN

SELECT count(*) as 'saidas', tb_local.nome as nome_local
FROM tb_registro
    JOIN tb_sensor ON tb_sensor.id_sensor = tb_registro.fk_sensor
    JOIN tb_dispenser ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_maquina ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
    JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
WHERE id_bebida = 1
GROUP BY nome_local;

END $$

-- Procedure Saídas por Região
DELIMITER $$
CREATE PROCEDURE saidas_por_regiao(IdBebidaVAR INT)
BEGIN

SELECT count(*) as 'saidas', tb_local.regiao
FROM tb_registro
    JOIN tb_sensor ON tb_sensor.id_sensor = tb_registro.fk_sensor
    JOIN tb_dispenser ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_maquina ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
    JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
WHERE id_bebida = IdBebidaVAR
GROUP BY regiao;

END $$


CALL saidas_por_unidade(1);

SELECT
    (COUNT(*) / (
            SELECT COUNT(*) AS total_dispensers
            FROM tb_dispenser
            WHERE fk_bebida = 5
        ) * 100
    ) AS percentual_acima_meta
FROM (
        SELECT
            tb_dispenser.id_dispenser,
            COUNT(*) AS Saidas,
            tb_bebida.meta_geral / dispensers_bebida AS meta_unidade
        FROM tb_dispenser
            LEFT JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            LEFT JOIN tb_registro ON tb_registro.fk_sensor = tb_sensor.id_sensor
            LEFT JOIN tb_bebida ON tb_dispenser.fk_bebida = tb_bebida.id_bebida
            LEFT JOIN (
                SELECT id_dispenser,
                    COUNT(*) AS dispensers_bebida
                FROM tb_dispenser
                WHERE fk_bebida = 5
                GROUP BY id_dispenser
            ) AS subquery ON tb_dispenser.id_dispenser = subquery.id_dispenser
        WHERE tb_bebida.id_bebida = 5
        GROUP BY tb_dispenser.id_dispenser,
            tb_bebida.meta_geral / dispensers_bebida
    ) AS subquery
WHERE Saidas >= meta_unidade;

