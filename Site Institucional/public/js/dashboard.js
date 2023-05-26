let proximaAtualizacao;

    window.onload = obterDadosGraficos();
    verificar_autenticacao();


    // O gráfico é construído com três funções:
    // 1. obterDadosGrafico -> Traz dados do Banco de Dados para montar o gráfico da primeira vez
    // 2. plotarGrafico -> Monta o gráfico com os dados trazidos e exibe em tela
    // 3. atualizarGrafico -> Atualiza o gráfico, trazendo novamente dados do Banco

    // Esta função *obterDadosGrafico* busca os últimos dados inseridos em tabela de medidas.
    // para, quando carregar o gráfico da primeira vez, já trazer com vários dados.
    // A função *obterDadosGrafico* também invoca a função *plotarGrafico*

    //     Se quiser alterar a busca, ajuste as regras de negócio em src/controllers
    //     Para ajustar o "select", ajuste o comando sql em src/models

    
    function obterDadosGrafico(idAquario) {

        alterarTitulo(idAquario)

        if (proximaAtualizacao != undefined) {
            clearTimeout(proximaAtualizacao);
        }

        fetch(`/medidas/ultimas/${idAquario}`, { cache: 'no-store' }).then(function (response) {
            if (response.ok) {
                response.json().then(function (resposta) {
                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                    resposta.reverse();

                    plotarGrafico(resposta, idAquario);
                });
            } else {
                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
            .catch(function (error) {
                console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
            });
    }

    // Esta função *plotarGrafico* usa os dados capturados na função anterior para criar o gráfico
    // Configura o gráfico (cores, tipo, etc), materializa-o na página e, 
    // A função *plotarGrafico* também invoca a função *atualizarGrafico*
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

        console.log('----------------------------------------------')
        console.log('Estes dados foram recebidos pela funcao "obterDadosGrafico" e passados para "plotarGrafico":')
        console.log(resposta)

        // Inserindo valores recebidos em estrutura para plotar o gráfico
        for (i = 0; i < resposta.length; i++) {
            var registro = resposta[i];
            labels.push(registro.momento_grafico);
            dados.datasets[0].data.push(registro.umidade);
            dados.datasets[1].data.push(registro.temperatura);
        }

        console.log('----------------------------------------------')
        console.log('O gráfico será plotado com os respectivos valores:')
        console.log('Labels:')
        console.log(labels)
        console.log('Dados:')
        console.log(dados.datasets)
        console.log('----------------------------------------------')

        // Criando estrutura para plotar gráfico - config
        const config = {
            type: 'line',
            data: dados,
        };

        // Adicionando gráfico criado em div na tela
        let myChart = new Chart(
            document.getElementById(`myChartCanvas${idAquario}`),
            config
        );

        setTimeout(() => atualizarGrafico(idAquario, dados, myChart), 2000);
    }


    // Esta função *atualizarGrafico* atualiza o gráfico que foi renderizado na página,
    // buscando a última medida inserida em tabela contendo as capturas, 

    //     Se quiser alterar a busca, ajuste as regras de negócio em src/controllers
    //     Para ajustar o "select", ajuste o comando sql em src/models
    function atualizarGrafico(idAquario, dados, myChart) {

        fetch(`/medidas/tempo-real/${idAquario}`, { cache: 'no-store' }).then(function (response) {
            if (response.ok) {
                response.json().then(function (novoRegistro) {

                    console.log(`Dados recebidos: ${JSON.stringify(novoRegistro)}`);
                    console.log(`Dados atuais do gráfico:`);
                    console.log(dados);

                    let avisoCaptura = document.getElementById(`avisoCaptura${idAquario}`)
                    avisoCaptura.innerHTML = ""


                    if (novoRegistro[0].momento_grafico == dados.labels[dados.labels.length - 1]) {
                        console.log("---------------------------------------------------------------")
                        console.log("Como não há dados novos para captura, o gráfico não atualizará.")
                        avisoCaptura.innerHTML = "<i class='fa-solid fa-triangle-exclamation'></i> Foi trazido o dado mais atual capturado pelo sensor. <br> Como não há dados novos a exibir, o gráfico não atualizará."
                        console.log("Horário do novo dado capturado:")
                        console.log(novoRegistro[0].momento_grafico)
                        console.log("Horário do último dado capturado:")
                        console.log(dados.labels[dados.labels.length - 1])
                        console.log("---------------------------------------------------------------")
                    } else {
                        // tirando e colocando valores no gráfico
                        dados.labels.shift(); // apagar o primeiro
                        dados.labels.push(novoRegistro[0].momento_grafico); // incluir um novo momento

                        dados.datasets[0].data.shift();  // apagar o primeiro de umidade
                        dados.datasets[0].data.push(novoRegistro[0].umidade); // incluir uma nova medida de umidade

                        dados.datasets[1].data.shift();  // apagar o primeiro de temperatura
                        dados.datasets[1].data.push(novoRegistro[0].temperatura); // incluir uma nova medida de temperatura

                        myChart.update();
                    }

                    // Altere aqui o valor em ms se quiser que o gráfico atualize mais rápido ou mais devagar
                    proximaAtualizacao = setTimeout(() => atualizarGrafico(idAquario, dados, myChart), 2000);
                });
            } else {
                console.error('Nenhum dado encontrado ou erro na API');
                // Altere aqui o valor em ms se quiser que o gráfico atualize mais rápido ou mais devagar
                proximaAtualizacao = setTimeout(() => atualizarGrafico(idAquario, dados, myChart), 2000);
            }
        })
            .catch(function (error) {
                console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
            });

    }