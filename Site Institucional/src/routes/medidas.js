var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.post("/graficoDesempenho", function (req, res) {
    medidaController.graficoDesempenho(req, res);
})

router.post("/totalSaidas", function(req, res){
    medidaController.totalSaidas(req, res);
})

router.get("/graficoSemana", function(req, res){
    medidaController.graficoSemana(req, res);
})

module.exports = router;