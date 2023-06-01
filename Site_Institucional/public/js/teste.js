
function atualizarMetricas() {  
    fetch("/medidas/graficoDesempenho", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idBebida: 1
        })
    }).then((response) => {
        console.log(response);
        return response.json()
    }).then((total) => {
        var desempenho = total[0]

        console.log("desempenho:", desempenho.desempenho)
        div_desempenho.innerHTML = desempenho.desempenho + "%";
        
        // console.log(dados_dsp_geral)
        // dados_dsp_geral.datasets[0].data.push()
        dados_dsp_geral.datasets[0].data.push(desempenhoGrafico, 100 - desempenhoGrafico)

        for(var i = 0; i < total.length; i++){
            var desempenhoGrafico = total[i].desempenho
            dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
            graficoDonut_dsp_geral.update()
        }
    })

    setTimeout(atualizarMetricas, 2000);
}

function atualizarGraficos() {
    fetch("/medidas/graficoDesempenho", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idBebida: 1
        })
    }).then((response) => {
        console.log(response);
        return response.json()
    }).then((total) => {
        var desempenho = total[0]

        console.log("desempenho:", desempenho.desempenho_geral)
        div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

        // console.log(dados_dsp_geral)
        // dados_dsp_geral.datasets[0].data.push()
        // dados_dsp_geral.datasets[0].data.push(desempenhoGrafico, 100 - desempenhoGrafico)

        for (var i = 0; i < total.length; i++) {
            var desempenhoGrafico = total[i].desempenho_geral
            dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
            graficoDonut_dsp_geral.update()
        }
    })

    graficosParametros(1)



    // setTimeout(atualizarGraficos(), 10000);

}