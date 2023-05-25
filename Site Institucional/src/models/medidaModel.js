var database = require("../database/config");

function totalSaidas(idBebida){

    instrucaoSql
     = `
    SELECT nome_bebida AS "nomeBebidaBD", 
        (SELECT count(aprox_registro) AS "totalSaidas" FROM tb_registro JOIN tb_sensor ON id_sensor = fk_sensor 
	JOIN tb_dispenser ON id_dispenser = fk_dispenser WHERE aprox_registro = 1 AND fk_bebida = ${idBebida}) AS "totalSaidasBD",
		(select count(id_bebida) FROM tb_bebida WHERE id_bebida =  ${idBebida}) AS "totalUnidadesBD",
		timestampdiff(week, prazo_inicio, prazo_final) AS "tempoTesteBD",
        meta_geral AS "metaGeralBD"
        FROM tb_registro 
            JOIN tb_sensor ON id_sensor = fk_sensor 
		    JOIN tb_dispenser ON id_dispenser = fk_dispenser 
            JOIN tb_maquina ON id_maquina = fk_maquina 
            JOIN tb_bebida ON fk_bebida = id_bebida 
                WHERE id_bebida =  ${idBebida}
                limit 1;
    `

    return database.executar(instrucaoSql);
}

function graficoDesempenho(idBebida){

    instrucaoSql = `select format(((select count(aprox_registro) AS "totalSaidas" FROM tb_registro JOIN tb_sensor ON id_sensor = fk_sensor 
    JOIN tb_dispenser ON id_dispenser = fk_dispenser) / meta_geral) * 100, 2) AS "desempenho" from tb_bebida WHERE id_bebida = ${idBebida};
    `

    return database.executar(instrucaoSql);
}

function graficoSemana(idBebida){

    instrucaoSql = `SELECT count(*) AS "semana"
    FROM tb_registro
        JOIN tb_sensor ON id_sensor = fk_sensor
        JOIN tb_dispenser ON id_dispenser = fk_dispenser
    WHERE fk_bebida = ${idBebida}
    GROUP BY WEEK(datahora_registro);
    `

    return database.executar(instrucaoSql);
}



module.exports = {
    graficoDesempenho,
    totalSaidas,
    graficoSemana
}
