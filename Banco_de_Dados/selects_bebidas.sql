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
 


Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'pumpdrink.tb_bebida.meta_geral' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by