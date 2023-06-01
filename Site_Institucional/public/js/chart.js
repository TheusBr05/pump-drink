
// GRÁFICO PIZZA - REGIÕES 
const labels_regioes = [];

const dados_regioes = {
    labels: labels_regioes,
    datasets: [{
        label: 'Regiões',
        data: [1, 2, 3],
        borderWidth: 1,
    }]
}

const config_regioes = {
    data: dados_regioes,
    type: 'pie',
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: false
    }
}

// GRÁFICO BARRA -  UNIDADES
const labels_unidades = [];

const dados_unidades = {
    labels: labels_unidades,
    datasets: [{
        label: 'Bebida X',
        data: [],
        backgroundColor: '#5271FF'
    }]
}

const config_unidades = {
    type: 'bar',
    data: dados_unidades,
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        },
        responsive: true,
        maintainAspectRatio: false,
        animation: false
    }
}

//GRÁFICO LINHAS - DESEMPENHO SEMANA 

const labels_semana = [];

const dados_dsp_semana = {
        labels: labels_semana,
        datasets: [
        {
            label: 'Bebida X',
            data: [],
            borderWidth: 1
        },
        
        {
            label: 'Meta Semanal',
            data: [],
            borderWidth: 1
        }
        ]
    };

const config_dsp_semana = {
    data: dados_dsp_semana,
    type: 'line',
    options: {
        plugins: {
            legend: {
                labels: {
                    // This more specific font property overrides the global property
                    font: {
                        size: 14,
                        family: 'Verdana',
                        weight: undefined
                    }
                }
            }
        },
    
    
        scales: {
            y: {
                beginAtZero: true
            }
        },
        responsive: true,
        maintainAspectRatio: false,
        autoPadding: true,
        animation: false
    }
}


//GRÁFICO DOUGHNUT - DESEMPENHO GERAL

const dados_dsp_geral = {
    datasets: [{
        data: [],
        cutout: 70,
        backgroundColor: ['green', 'gray']
    }]
}

const config_dsp_geral = {
    type: 'doughnut',
    data: dados_dsp_geral,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: false
    }
}

//GRÁFICO DOUGHNUT - DESEMPENHO UNIDADES ABAIXO
const dados_dsp_uni_abaixo = {
    datasets: [{
        data: [60, 40],
        cutout: 70,
        backgroundColor: [
            'red', 'gray'
        ]
    }]
}

const config_dsp_uni_abaixo = {
    type: 'doughnut',
    data: dados_dsp_uni_abaixo,
    options: {
        responsive: true,
        maintainAspectRatio: false,

    }
}

//GRÁFICO DOUGHNUT - DESEMPENHO UNIDADES ACIMA 
const dados_dsp_uni_acima = {
    datasets: [{
        data: [30, 70],
        cutout: 70,
        backgroundColor: [
            'red', 'gray'
        ]
    }]
}

const config_dsp_uni_acima = {
    type: 'doughnut',
    data: dados_dsp_uni_acima,
    options: {
        responsive: true,
        maintainAspectRatio: false,

    }
}


//CHAMANDO FETCHTS
function atualizarMetricas() {
    fetch("/medidas/totalSaidas", {
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
        var totalSaida = total[0]
        console.log("O seu resultado foi ", totalSaida)
        console.log("valor final: ", totalSaida.totalSaidasBD);
        console.log("valor UNIDADES: ", totalSaida.totalUnidadesBD);
        console.log("TEMPO RESTANTE: ", totalSaida.tempoTesteBD);
        console.log("meta geral: ", totalSaida.metaGeralBD);

        h3_totalSaidas.innerHTML = totalSaida.totalSaidasBD;
        h3_totalUnidades.innerHTML = totalSaida.totalUnidadesBD;
        h3_totalTempo = totalSaida.tempoTesteBD;
        h3_totalMetaGeral.innerHTML = totalSaida.metaGeralBD;
        h3_metaUnidade.innerHTML = totalSaida.metaGeralBD / totalSaida.totalUnidadesBD;
        i_nome_bebida.innerHTML = totalSaida.nomeBebidaBD;

    })

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

    // fetch("/medidas/graficoSemana", {
    //     method: 'POST',
    //     headers: {
    //         'Content-Type': 'application/json'
    //     },
    //     body: JSON.stringify({
    //         idBebida: 1
    //     })
    // }).then((response) => {
    //     console.log(response);
    //     return response.json()
    // }).then((total) => {
    //     listaGraficoSemana = total[0]
    //     console.log("Total Semana: " + totalSemana.semana)

    //     for (let index = 0; index < total.length; index++) {
    //         graficoBarra_semana.datasets[index].data.push(totalSemana.semana);
    //     }

    // })


    setTimeout(atualizarMetricas, 2000);
}





