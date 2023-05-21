-- BEBIDA, MÁQUINA, LOCAL E DISPENSER  
SELECT bebida.nome_bebida AS 'Nome Bebida',
    tb_local.nome AS 'Local',
    maquina.id_maquina AS 'Máquina',
    dispenser.posicao AS 'Dispenser'
FROM tb_bebida AS bebida -- BEBIDA
    JOIN tb_dispenser AS dispenser -- DISPENSER
    ON bebida.id_bebida = dispenser.fk_bebida
    JOIN tb_maquina AS maquina -- MÁQUINA
    ON maquina.id_maquina = dispenser.fk_maquina
    JOIN tb_local -- LOCAL
    ON maquina.fk_local = tb_local.id_local
WHERE nome_bebida = 'Guaraná';



-- PRAZO 
SELECT bebida.nome_bebida AS 'Nome Bebida',
    bebida.prazo_inicio AS 'Ínicio Período Teste',
    bebida.prazo_final AS 'Final Período Teste'
FROM tb_bebida AS bebida
WHERE nome_bebida = 'Café';



-- MOSTRAR saídas
SELECT bebida.nome_bebida AS 'Nome Bebida',
    local_maq.nome AS 'Unidade',
    registro.datahora_registro AS 'Saída Sensor'
FROM tb_bebida AS bebida
    JOIN tb_dispenser AS dispenser ON bebida.id_bebida = fk_bebida
    JOIN tb_maquina AS maquina ON dispenser.fk_maquina = maquina.id_maquina
    JOIN tb_local AS local_maq ON maquina.fk_local = local_maq.id_local
    JOIN tb_sensor AS sensor ON sensor.fk_dispenser = dispenser.id_dispenser
    JOIN tb_registro AS registro ON sensor.id_sensor = registro.fk_sensor;
DESC tb_registro;



--  MOSTRAR TOTAL saídas DE UMA BEBIDA
SELECT count(aprox_registro) AS 'Total saídas'
FROM tb_registro
    JOIN tb_sensor ON id_sensor = fk_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
WHERE aprox_registro = 1
    AND fk_bebida = 1;



-- MOSTRAR UNIDADES COM BEBIDA X
SELECT count(id_maquina)
FROM tb_maquina
    JOIN tb_dispenser ON id_maquina = fk_maquina
WHERE fk_bebida = 1;



-- MOSTRAR TEMPO DE TESTE TOTAL EM semanas DE UMA BEBIDA
SELECT nome_bebida,
    timestampdiff(week, prazo_inicio, prazo_final)
FROM tb_bebida
WHERE id_bebida = 1;



-- MOSTRAR META 
SELECT meta_geral
FROM tb_bebida
WHERE id_bebida = 1;
desc tb_registro;



-- COMPARAÇÃO META E SAÍDA 
-- erro por tirar o total_saida da tb_registro
SELECT bebida.nome_bebida AS 'Nome Bebida',
    local_maq.nome AS 'Unidade',
    (
        SELECT count(aprox_registro) AS 'Total saídas'
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
    ) AS 'Total Saidas',
    bebida.meta_geral AS 'Meta'
FROM tb_bebida AS bebida
    JOIN tb_dispenser AS dispenser ON bebida.id_bebida = fk_bebida
    JOIN tb_maquina AS maquina ON dispenser.fk_maquina = maquina.id_maquina
    JOIN tb_local AS local_maq ON maquina.fk_local = local_maq.id_local
    JOIN tb_sensor AS sensor ON sensor.fk_dispenser = dispenser.id_dispenser
    JOIN tb_registro AS registro ON sensor.id_sensor = registro.fk_sensor
WHERE id_bebida = 1
    AND id_maquina = 1;



-- DESEMPENHO POR REGIÃO 
-- erro por tirar total_Saidas da tb_registro
SELECT bebida.nome_bebida AS 'Nome Bebida',
    (
        SELECT count(aprox_registro) AS 'Total saídas'
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
    ) AS 'Total Saidas',
    local_maq.regiao AS 'Região'
FROM tb_bebida AS bebida
    JOIN tb_dispenser AS dispenser ON bebida.id_bebida = fk_bebida
    JOIN tb_maquina AS maquina ON dispenser.fk_maquina = maquina.id_maquina
    JOIN tb_local AS local_maq ON maquina.fk_local = local_maq.id_local
    JOIN tb_sensor AS sensor ON sensor.fk_dispenser = dispenser.id_dispenser
    JOIN tb_registro AS registro ON sensor.id_sensor = registro.fk_sensor
WHERE id_bebida = 1
    AND id_maquina = 1;




SELECT nome_bebida AS "nomeBebidaBD",
    (
        SELECT count(aprox_registro) AS "totalSaidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
    ) AS "totalSaidasBD",
    (
        SELECT count(id_maquina)
        FROM tb_maquina
            JOIN tb_dispenser ON id_maquina = fk_maquina
        WHERE fk_bebida = 1
    ) AS "totalUnidadesBD",
    timestampdiff(week, prazo_inicio, prazo_final) AS "tempoTesteBD",
    meta_geral AS "metaGeralBD"
FROM tb_registro
    JOIN tb_sensor ON id_sensor = fk_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
    JOIN tb_maquina ON id_maquina = fk_maquina
    JOIN tb_bebida ON fk_bebida = id_bebida
WHERE id_bebida = 1
    AND id_maquina = 1;



-- select máquinas com bebida 1
SELECT count(id_maquina)
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
WHERE fk_bebida = 1;



-- select meta geral da bebida 1
SELECT meta_geral
FROM tb_bebida
WHERE id_bebida = 1;



-- select meta por maquina com bebida 1
SELECT format(
        meta_geral / (
            SELECT count(id_maquina)
            FROM tb_maquina
                JOIN tb_dispenser ON fk_maquina = id_maquina
            WHERE fk_bebida = 1
        ),
        0
    ) AS "metaUnidade"
FROM tb_bebida
WHERE id_bebida = 1;



-- select saida de uma bebida em uma bebida
SELECT count(aprox_registro) AS "Saidas"
FROM tb_registro
    JOIN tb_sensor ON id_sensor = fk_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
WHERE aprox_registro = 1
    AND fk_bebida = 1
    AND fk_maquina = 1;



-- select desempenho por máquina em porcentagem
SELECT (
        SELECT count(aprox_registro) AS "Saidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
            AND fk_maquina = 1
    ) / (
        SELECT meta_geral / (
                SELECT format(
                        meta_geral / (
                            SELECT count(id_maquina)
                            FROM tb_maquina
                                JOIN tb_dispenser ON fk_maquina = id_maquina
                            WHERE fk_bebida = 1
                        ),
                        0
                    ) AS "metaUnidade"
                FROM tb_bebida
                WHERE id_bebida = 1
            ) AS "metaUnidade"
    ) * 100 AS "Desempenho por Máquina"
FROM tb_bebida
WHERE id_bebida = 1;



-- select dias de teste desde o inicio até agora
SELECT nome_bebida,
    timestampdiff(day, prazo_inicio, now())
FROM tb_bebida
WHERE id_bebida = 1;



-- select dias de teste desde o inicio até fim do cONtrato
SELECT nome_bebida,
    timestampdiff(day, prazo_inicio, prazo_final)
FROM tb_bebida
WHERE id_bebida = 1;



-- select meta por dia
SELECT format(
        (
            SELECT meta_geral / (
                    SELECT count(id_maquina)
                    FROM tb_maquina
                        JOIN tb_dispenser ON fk_maquina = id_maquina
                    WHERE fk_bebida = 1
                ) AS "metaUnidade"
            FROM tb_bebida
            WHERE id_bebida = 1
        ) / (
            SELECT timestampdiff(day, prazo_inicio, prazo_final)
            FROM tb_bebida
            WHERE id_bebida = 1
        ),
        2
    ) AS 'Meta da Unidade por dia'
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
    JOIN tb_bebida ON id_bebida = fk_bebida
WHERE id_bebida = 1
    AND id_maquina = 1;



-- select meta dinamica dia de testes * meta diária
SELECT format(
        (
            SELECT meta_geral / (
                    SELECT count(id_maquina)
                    FROM tb_maquina
                        JOIN tb_dispenser ON fk_maquina = id_maquina
                    WHERE fk_bebida = 1
                ) AS "metaUnidade"
            FROM tb_bebida
            WHERE id_bebida = 1
        ) / (
            SELECT timestampdiff(day, prazo_inicio, prazo_final)
            FROM tb_bebida
            WHERE id_bebida = 1
        ),
        0
    ) * timestampdiff(day, prazo_inicio, now()) AS 'Meta da Unidade até hoje'
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
    JOIN tb_bebida ON id_bebida = fk_bebida
WHERE id_bebida = 1
    AND id_maquina = 1;



-- select máquinas acima da meta total
SELECT count(id_maquina)
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
WHERE fk_bebida = 1
    AND (
        SELECT meta_geral / (
                SELECT count(id_bebida)
                FROM tb_bebida
                WHERE id_bebida = 1
            ) AS "metaUnidade"
        FROM tb_bebida
        WHERE id_bebida = 1
    ) < (
        SELECT count(aprox_registro) AS "Saidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
            AND fk_maquina = 3
    );



-- select máquinas acima da meta diaria
SELECT count(id_maquina)
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
WHERE (
        SELECT count(aprox_registro) AS "Saidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
            AND fk_maquina = 1
    ) >= (
        SELECT format(
                (
                    SELECT meta_geral / (
                            SELECT count(id_maquina)
                            FROM tb_maquina
                                JOIN tb_dispenser ON fk_maquina = id_maquina
                            WHERE fk_bebida = 1
                        ) AS "metaUnidade"
                    FROM tb_bebida
                    WHERE id_bebida = 1
                ) / (
                    SELECT timestampdiff(day, prazo_inicio, prazo_final)
                    FROM tb_bebida
                    WHERE id_bebida = 1
                ),
                2
            ) * timestampdiff(day, prazo_inicio, now()) AS 'Meta da Unidade até hoje'
        FROM tb_maquina
            JOIN tb_dispenser ON fk_maquina = id_maquina
            JOIN tb_bebida ON id_bebida = fk_bebida
        WHERE id_bebida = 1
            AND id_maquina = 1
    )
    AND fk_bebida = 1;



-- select máquina abaixo da meta total
SELECT count(id_maquina)
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
WHERE fk_bebida = 1
    AND (
        SELECT meta_geral / (
                SELECT count(id_bebida)
                FROM tb_bebida
                WHERE id_bebida = 1
            ) AS "metaUnidade"
        FROM tb_bebida
        WHERE id_bebida = 1
    ) >= (
        SELECT count(aprox_registro) AS "Saidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
            AND fk_maquina = 3
    );



-- select máquinas abaixo da meta diaria
SELECT count(id_maquina) AS "máquinas Abaixo do esperado"
FROM tb_maquina
    JOIN tb_dispenser ON fk_maquina = id_maquina
WHERE (
        SELECT count(aprox_registro) AS "Saidas"
        FROM tb_registro
            JOIN tb_sensor ON id_sensor = fk_sensor
            JOIN tb_dispenser ON id_dispenser = fk_dispenser
        WHERE aprox_registro = 1
            AND fk_bebida = 1
            AND fk_maquina = 1
    ) < (
        SELECT format(
                (
                    SELECT meta_geral / (
                            SELECT count(id_maquina)
                            FROM tb_maquina
                                JOIN tb_dispenser ON fk_maquina = id_maquina
                            WHERE fk_bebida = 1
                        ) AS "metaUnidade"
                    FROM tb_bebida
                    WHERE id_bebida = 1
                ) / (
                    SELECT timestampdiff(day, prazo_inicio, prazo_final)
                    FROM tb_bebida
                    WHERE id_bebida = 1
                ),
                2
            ) * timestampdiff(day, prazo_inicio, now()) AS 'Meta da Unidade até hoje'
        FROM tb_maquina
            JOIN tb_dispenser ON fk_maquina = id_maquina
            JOIN tb_bebida ON id_bebida = fk_bebida
        WHERE id_bebida = 1
            AND id_maquina = 1
    )
    AND fk_bebida = 1;



-- select saidas de uma bebida em uma máquina
SELECT meta_geral AS "metaUnidade"
FROM tb_bebida
WHERE id_bebida = 1;
SELECT count(aprox_registro) AS "Saidas"
FROM tb_registro
    JOIN tb_sensor ON id_sensor = fk_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
WHERE aprox_registro = 1
    AND fk_bebida = 1
    AND fk_maquina = 1;



-- select semanas de teste de uma bebida até o prazo final
SELECT timestampdiff(week, prazo_inicio, prazo_final)
FROM tb_bebida
WHERE id_bebida = 1;



-- select saídas na semana 1
SELECT count(id_registro) FROM tb_registro
WHERE week(datahora_registro) = 2;



-- select saídas por semana;
SELECT count(*) AS total
FROM tb_registro
GROUP BY WEEK(datahora_registro);



-- select saídas por semana de uma bebida
SELECT count(*) AS 'total'
FROM tb_registro
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
    JOIN tb_sensor ON id_sensor = fk_sensor
WHERE fk_bebida = 3
GROUP BY WEEK(datahora_registro);



-- select saídas de uma bebida por máquina
SELECT
    count(id_registro) AS 'Saida por Maquina'
FROM tb_registro
    JOIN tb_sensor ON fk_sensor = id_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
    JOIN tb_maquina ON id_maquina = fk_maquina
WHERE fk_bebida = 2
GROUP BY descricao
LIMIT 5;



-- select saidas por região
SELECT regiao,
    count(id_registro) AS 'Saida por Maquina'
FROM tb_registro
    JOIN tb_sensor ON fk_sensor = id_sensor
    JOIN tb_dispenser ON id_dispenser = fk_dispenser
    JOIN tb_maquina ON id_maquina = fk_maquina
    JOIN tb_local ON id_local = fk_local
WHERE fk_bebida = 2
GROUP BY regiao;
