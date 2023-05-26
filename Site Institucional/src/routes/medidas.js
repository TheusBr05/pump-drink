var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idBebida", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idBebida", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.post("/graficoDesempenho", function (req, res) {
    medidaController.graficoDesempenho(req, res);
})

router.post("/totalSaidas", function(req, res){
    medidaController.totalSaidas(req, res);
})

router.post("/graficoSemana", function(req, res){
    medidaController.graficoSemana(req, res);
})

module.exports = router;