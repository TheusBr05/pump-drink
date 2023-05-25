-- Total de Saídas
SELECT count(*)
FROM tb_registro
    JOIN tb_sensor ON id_sensor = fk_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
WHERE fk_bebida = 1;


-- Total Unidade
SELECT count(*)
FROM tb_maquina
    JOIN tb_dispenser ON id_maquina = fk_maquina
WHERE fk_bebida = 1;


-- Tempo de Teste(Semanas)
SELECT timestampdiff(week, prazo_inicio, prazo_final)
FROM tb_bebida
WHERE id_bebida = 1;


-- Meta geral
SELECT meta_geral
FROM tb_bebida
WHERE id_bebida = 1;


-- Meta por Unidade
SELECT (
        SELECT meta_geral
        FROM tb_bebida
        WHERE id_bebida = 1
    ) / (
        SELECT count(*)
        FROM tb_maquina
            JOIN tb_dispenser ON id_maquina = fk_maquina
        WHERE fk_bebida = 1
    );


-- Desempenho geral em porcentagem
SELECT format(
        (
            SELECT count(*)
            FROM tb_registro
                JOIN tb_sensor ON id_sensor = fk_sensor
                JOIN tb_dispenser ON id_dispenser = fk_dispenser
            WHERE fk_bebida = 1
        ) * 100 / (
            SELECT meta_geral / timestampdiff(day, prazo_inicio, prazo_final) * timestampdiff(day, prazo_inicio, now())
            FROM tb_bebida
            WHERE id_bebida = 1
        ),
        2
    ) as 'desempenho_geral';


-- unidades acima do esperado
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
WHERE Saidas => meta_unidade;


-- unidades abaixo do esperado
SELECT (
        COUNT(*) / (
            SELECT COUNT(*) AS total_maquinas
            FROM tb_maquina
                JOIN tb_dispenser ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
            WHERE tb_dispenser.fk_bebida = 5
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
                WHERE fk_bebida = 5
                GROUP BY fk_maquina
            ) AS subquery ON tb_maquina.id_maquina = subquery.fk_maquina
        WHERE tb_bebida.id_bebida = 5
        GROUP BY tb_maquina.id_maquina,
            tb_bebida.meta_geral / maquinas_bebida
    ) AS subquery
WHERE Saidas < meta_unidade;


-- gráfico período de teste em dias, não em semanas
SELECT DAY(tb_registro.datahora_registro),
    count(*)
FROM tb_registro
    JOIN tb_sensor ON tb_sensor.id_sensor = tb_registro.fk_sensor
    JOIN tb_dispenser ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
WHERE fk_bebida = 1
GROUP BY DAY(tb_registro.datahora_registro)
ORDER BY DAY(tb_registro.datahora_registro) DESC
LIMIT 7;


-- gráfico saídas por unidades (desempenho por unidades)
SELECT count(*), tb_maquina.descricao
FROM tb_registro
    JOIN tb_sensor ON tb_sensor.id_sensor = tb_registro.fk_sensor
    JOIN tb_dispenser ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_maquina ON tb_maquina.id_maquina = tb_dispenser.fk_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
GROUP BY descricao;