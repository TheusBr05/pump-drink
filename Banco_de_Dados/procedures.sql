DELIMITER $$ 
CREATE PROCEDURE unidades_abaixo (IdBebidaVAR int)
BEGIN
SELECT format(
        (
            SELECT count(*)
            FROM tb_registro
                JOIN tb_sensor ON id_sensor = fk_sensor
                JOIN tb_dispenser ON id_dispenser = fk_dispenser
            WHERE fk_bebida = 1
        ) * 100 / (
            SELECT meta_geral / timestampdiff(day, prazo_inicio, prazo_final) * 
            timestampdiff(day, prazo_inicio, now())
            FROM tb_bebida
            WHERE id_bebida = 1
        ),
        2
    ) as 'desempenho_geral';

SELECT (
        COUNT(*) / (
            SELECT COUNT(*) AS total_maquinas
            FROM tb_maquina
                JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            WHERE tb_dispenser.fk_bebida = 1
        ) * 100
    ) AS percentual_abaixo_meta
FROM (
        SELECT tb_maquina.id_maquina,
            COUNT(*) AS Saidas,
            tb_bebida.meta_geral / maquinas_bebida AS meta_unidade
        FROM tb_maquina
            JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            JOIN tb_registro ON tb_registro.fk_sensor = tb_sensor.id_sensor
            JOIN tb_bebida ON tb_dispenser.fk_bebida = tb_bebida.id_bebida
            JOIN (
                SELECT fk_maquina,
                    COUNT(*) AS maquinas_bebida
                FROM tb_dispenser
                WHERE fk_bebida = 1
                GROUP BY fk_maquina
            ) AS subquery ON tb_maquina.id_maquina = subquery.fk_maquina
        WHERE tb_bebida.id_bebida = 1
        GROUP BY tb_maquina.id_maquina,
            tb_bebida.meta_geral / maquinas_bebida
    ) AS subquery
WHERE Saidas < meta_unidade;

SELECT (
        COUNT(*) / (
            SELECT COUNT(*) AS total_maquinas
            FROM tb_maquina
                JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            WHERE tb_dispenser.fk_bebida = 5
        ) * 100
    ) AS percentual_acima_meta
FROM (
        SELECT tb_maquina.id_maquina,
            COUNT(*) AS Saidas,
            tb_bebida.meta_geral / maquinas_bebida AS meta_unidade
        FROM tb_maquina
            JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
            JOIN tb_registro ON tb_registro.fk_sensor = tb_sensor.id_sensor
            JOIN tb_bebida ON tb_dispenser.fk_bebida = tb_bebida.id_bebida
            JOIN (
                SELECT fk_maquina,
                    COUNT(*) AS maquinas_bebida
                FROM tb_dispenser
                WHERE fk_bebida = 5
                GROUP BY fk_maquina
            ) AS subquery ON tb_maquina.id_maquina = subquery.fk_maquina
        WHERE tb_bebida.id_bebida = 5
        GROUP BY tb_maquina.id_maquina,
            tb_bebida.meta_geral / maquinas_bebida
    ) AS subquery
WHERE Saidas >= meta_unidade;
END 
$$ 

call unidades_abaixo(1);

