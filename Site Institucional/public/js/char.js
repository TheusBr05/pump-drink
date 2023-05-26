

let label_regiao = [];

new Chart(graficoPizza_regiao, 
    data: {
        labels: [],
        datasets: [{
            label: 'Regiões',
            data: [1,2,3],
            borderWidth: 1,

        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }

    })
    
const config_regiao = {
    type: 'pie',
    data: dados_regiao,
};