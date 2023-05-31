SELECT tb_local.nome,
    concat(
        rua, ', ',
        ifnull(numero, 'S/N'), ' - ',
        bairro, ' - ',
        cep, ' - ',
        cidade, ' - ',
        estado) as 'endereco',
    count(id_registro) as 'saidas'
FROM tb_maquina
    JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
    JOIN tb_dispenser ON tb_dispenser.fk_maquina = tb_maquina.id_maquina
    JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
    JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
    JOIN tb_registro ON tb_sensor.id_sensor = tb_registro.fk_sensor
WHERE id_bebida = 5
GROUP BY fk_local;


SELECT tb_local.nome as 'unidade', concat(rua, ', ', ifnull(numero, 'S/N'), ' - ', bairro, ' - ', cep, ' - ', cidade, ' - ', estado) as 'endereco',
        count(id_registro) as 'saidas'

    FROM tb_maquina
        JOIN tb_local ON tb_local.id_local = tb_maquina.fk_local
        JOIN tb_dispenser ON tb_dispenser.fk_maquina = tb_maquina.id_maquina
        JOIN tb_bebida ON tb_bebida.id_bebida = tb_dispenser.fk_bebida
        JOIN tb_sensor ON tb_dispenser.id_dispenser = tb_sensor.fk_dispenser
        JOIN tb_registro ON tb_sensor.id_sensor = tb_registro.fk_sensor
        WHERE tb_bebida.nome_bebida = 'Coca-Cola'
        GROUP BY fk_local;

SELECT date_format(prazo_final, '%d-%m-%Y') as 'prazo', meta_geral as 'meta' FROM tb_bebida WHERE nome_bebida = 'Coca-Cola';

