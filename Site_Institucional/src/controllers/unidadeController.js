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

function todas_bebidas(req, res) {

    unidadeModel.todas_bebidas().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as bebidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });

}

function cadastrar_unidade(req, res) {

    var dispenser1 = req.body.dispenser1Server;
    var dispenser2 = req.body.dispenser2Server;
    var dispenser3 = req.body.dispenser3Server;
    var dispenser4 = req.body.dispenser4Server;

    var nome = req.body.nomeServer;
    var descricao = req.body.descricaoServer;
    var rua = req.body.ruaServer;
    var num = req.body.numServer;
    var comp = req.body.compServer;
    var cep = req.body.cepServer;
    var bairro = req.body.bairroServer;
    var cidade = req.body.cidadeServer;
    var estado = req.body.estadoServer;
    var regiao = req.body.regiaoServer;
    var pais = req.body.paisServer;

    unidadeModel.cadastrar_unidade(dispenser1, dispenser2, dispenser3, dispenser4, nome, descricao, rua, num, comp, cep, bairro, cidade, estado, regiao, pais)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro de unidade! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

module.exports = {
    alerta_unidade,
    meta_prazo,
    cadastrar_unidade,
    todas_bebidas
}