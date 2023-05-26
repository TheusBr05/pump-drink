DELIMITER $$
CREATE PROCEDURE unidades_abaixo (IdBedidaVAR int)
BEGIN

SELECT (
        COUNT(*) / (
            SELECT COUNT(*) AS total_maquinas
            FROM tb_maquina
                JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            WHERE tb_dispenser.fk_bebida = IdBedidaVAR
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
                WHERE fk_bebida = IdBedidaVAR
                GROUP BY fk_maquina
            ) AS subquery ON tb_maquina.id_maquina = subquery.fk_maquina
        WHERE tb_bebida.id_bebida = IdBedidaVAR
        GROUP BY tb_maquina.id_maquina,
            tb_bebida.meta_geral / maquinas_bebida
    ) AS subquery
WHERE Saidas < meta_unidade;

END $$

call unidades_abaixo(1);