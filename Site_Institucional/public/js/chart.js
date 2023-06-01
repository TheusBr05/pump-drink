
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
function graficosParametros(idBebida) {

    //Desempenho Geral
    fetch(`/medidas/graficoDesempenho/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                resposta.reverse();


                
                var desempenho = JSON.stringify(resposta[0].desempenho_geral);

                
                console.log('resposta 2:', resposta2);

                var div_desempenho = document.getElementById('div_desempenho')
                console.log("desempenho:", desempenho)
                div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                for (var i = 0; i < resposta.length; i++) {
                    var desempenhoGrafico = resposta[i].desempenho_geral
                    dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                    graficoDonut_dsp_geral.update()
                }
            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })


    //Unidades Acima 
    fetch(`/medidas/unidadesAcima/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Unidades Acima: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                // var desempenho = resposta[0]

                // console.log("desempenho:", desempenho.desempenho_geral)
                // div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                // for (var i = 0; i < resposta.length; i++) {
                //     var desempenhoGrafico = resposta[i].desempenho_geral
                //     dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                //     graficoDonut_dsp_geral.update()
                // }

            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })


    //Unidades Abaixo
    fetch(`/medidas/unidadesAbaixo/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Unidades Abaixo: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                // var desempenho = resposta[0]

                // console.log("desempenho:", desempenho.desempenho_geral)
                // div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                // for (var i = 0; i < resposta.length; i++) {
                //     var desempenhoGrafico = resposta[i].desempenho_geral
                //     dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                //     graficoDonut_dsp_geral.update()
                // }

            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })


    //SAÍDAS POR UNIDADES
    fetch(`/medidas/saidasPorUnidades/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Saídas por Unidade: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                // var desempenho = resposta[0]

                // console.log("desempenho:", desempenho.desempenho_geral)
                // div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                // for (var i = 0; i < resposta.length; i++) {
                //     var desempenhoGrafico = resposta[i].desempenho_geral
                //     dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                //     graficoDonut_dsp_geral.update()
                // }

            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })



    //SAÍDAS POR REGIÃO
    fetch(`/medidas/saidasPorRegiao/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Saídas por região: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                // var desempenho = resposta[0]

                // console.log("desempenho:", desempenho.desempenho_geral)
                // div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                // for (var i = 0; i < resposta.length; i++) {
                //     var desempenhoGrafico = resposta[i].desempenho_geral
                //     dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                //     graficoDonut_dsp_geral.update()
                // }

            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })
    

    //PERÍODO DE TESTE
    fetch(`/medidas/periodoTeste/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Período de teste: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                // var desempenho = resposta[0]

                // console.log("desempenho:", desempenho.desempenho_geral)
                // div_desempenho.innerHTML = desempenho.desempenho_geral + " % ";

           
                // for (var i = 0; i < resposta.length; i++) {
                //     var desempenhoGrafico = resposta[i].desempenho_geral
                //     dados_dsp_geral.datasets[0].data.splice(0, 2, desempenhoGrafico, 100 - desempenhoGrafico)
                //     graficoDonut_dsp_geral.update()
                // }

            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })

    fetch(`/medidas/totalSaidas/${idBebida}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                var totalSaida = resposta[0]

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
            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })
}





