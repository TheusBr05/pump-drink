var express = require("express");
var router = express.Router();


router.get("/unidade/:bebida", function (req, res) {
    unidadeController.alerta_unidade(req, res);
})

module.exports = router;