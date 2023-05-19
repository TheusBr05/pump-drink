var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function totalSaidas(idBebida){
    // instrucaoSql = `
    // SELECT count(aprox_registro) AS "totalSaidas" FROM tb_registro JOIN tb_sensor ON id_sensor = fk_sensor 
	// JOIN tb_dispenser ON id_dispenser = fk_dispenser WHERE aprox_registro = 1 AND fk_bebida = ${idBebida};
    // `

    instrucaoSql = `
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


module.exports = {
    buscarUltimasMedidas,
    totalSaidas,
    buscarMedidasEmTempoReal
}
