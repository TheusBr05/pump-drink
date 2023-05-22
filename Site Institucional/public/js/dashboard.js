function plotarGrafico(resposta, idAquario) {

  console.log('iniciando plotagem do gráfico...');

  // Criando estrutura para plotar gráfico - labels
  let labels = [];

  // Criando estrutura para plotar gráfico - dados
  let dados = {
      labels: labels,
      datasets: [{
          label: 'Umidade',
          data: [],
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
      },
      {
          label: 'Temperatura',
          data: [],
          fill: false,
          borderColor: 'rgb(199, 52, 52)',
          tension: 0.1
      }]
  };

}
  

