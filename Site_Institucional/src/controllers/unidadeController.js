var unidadeModel = require("../models/unidadeModel");


function alerta_unidade(req, res) {

    var bebida = req.params.bebida;

    console.log(`Recuperando medidas em tempo real`);

    unidadeModel.alerta_unidade(bebida).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function meta_prazo(req, res) {

    var bebida = req.params.bebida;

    console.log(`Recuperando medidas em tempo real`);

    unidadeModel.meta_prazo(bebida).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    alerta_unidade,
    meta_prazo
}