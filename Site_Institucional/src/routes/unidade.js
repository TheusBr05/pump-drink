var express = require("express");
var router = express.Router();

var unidadeController = require("../controllers/unidadeController");

router.post("/cadastrar_unidade", function(req, res){
    unidadeController.cadastrar_unidade(req, res);
})

router.get("/unidade/:bebida", function (req, res) {
    unidadeController.alerta_unidade(req, res);
})

router.get("/meta_prazo/:bebida", function (req, res) {
    unidadeController.meta_prazo(req, res);
})

router.get("/todas_bebidas", function (req, res){
    unidadeController.todas_bebidas(req, res);
})

module.exports = router;