var express = require("express");
var router = express.Router();

var unidadeController = require("../controllers/unidadeController");

router.get("/unidade/:bebida", function (req, res) {
    unidadeController.alerta_unidade(req, res);
})

router.get("/meta_prazo/:bebida", function (req, res) {
    unidadeController.meta_prazo(req, res);
})

module.exports = router;