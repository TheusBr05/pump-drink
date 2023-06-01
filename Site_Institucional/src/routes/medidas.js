var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idBebida", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idBebida", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/graficoDesempenho/:idBebida", function (req, res) {
    medidaController.graficoDesempenho(req, res);
})

router.get("/unidadesAcima/:idBebida", function (req, res) {
    medidaController.unidadesAcima(req, res);
})

router.get("/unidadesAbaixo/:idBebida", function (req, res) {
    medidaController.unidadesAbaixo(req, res);
})

router.get("/saidasPorUnidades/:idBebida", function (req, res) {
    medidaController.saidasPorUnidades(req, res);
})

router.get("/saidasPorRegiao/:idBebida", function (req, res) {
    medidaController.saidasPorRegiao(req, res);
})

router.get("/periodoTeste/:idBebida", function (req, res) {
    medidaController.periodoTeste(req, res);
})

router.get("/totalSaidas/:idBebida", function(req, res){
    medidaController.totalSaidas(req, res);
})

module.exports = router;