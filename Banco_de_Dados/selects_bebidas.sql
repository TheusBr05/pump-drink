SELECT 
    nome_bebida,
    meta_geral,
    count(id_registro) as 'saidas'
FROM tb_bebida 
JOIN tb_dispenser ON id_bebida = fk_bebida
JOIN tb_sensor ON id_dispenser = fk_dispenser
JOIN tb_registro ON id_sensor = fk_sensor
WHERE id_bebida = 1
GROUP BY nome_bebida;



SELECT bebida.id_bebida, bebida.nome_bebida,
            format(
                (
                    SELECT count(*)
                    FROM tb_registro
                        JOIN tb_sensor ON id_sensor = fk_sensor
                        JOIN tb_dispenser ON id_dispenser = fk_dispenser
                    WHERE fk_bebida = bebida.id_bebida
                ) * 100 / (
                    SELECT meta_geral / timestampdiff(day, prazo_inicio, prazo_final) * 
                    timestampdiff(day, prazo_inicio, now())
                    FROM tb_bebida
                    WHERE id_bebida = bebida.id_bebida
                ),
                2
            ) as 'desempenho_geral'
        FROM tb_bebida bebida
        ORDER BY desempenho_geral; 

UPDATE tb_bebida SET meta_geral = 15 WHERE id_bebida = 5;