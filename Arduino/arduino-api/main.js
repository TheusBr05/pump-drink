const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');
const sql = require('mssql');

const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;
const HABILITAR_OPERACAO_INSERIR = true;

// escolha deixar a linha 'desenvolvimento' descomentada se quiser conectar seu arduino ao banco de dados local, MySQL Workbench
// const AMBIENTE = 'desenvolvimento';

// escolha deixar a linha 'producao' descomentada se quiser conectar seu arduino ao banco de dados remoto, SQL Server
const AMBIENTE = 'desenvolvimento';

const serial = async (
    valoresChave
) => {
    let poolBancoDados = ''

    if (AMBIENTE == 'desenvolvimento') {
        poolBancoDados = mysql.createPool(
            {
                // CREDENCIAIS DO BANCO LOCAL - MYSQL WORKBENCH
                // host: 'localhost',
                // user: 'userPumpDrink',
                // password: 'pumpdrink',
                // database: 'pumpdrink_teste'

                // host: '10.18.32.25',
                // user: 'nuvem',
                // password: 'nuvem123',
                // database: 'pumpdrink'

                host: 'localhost',
                user: 'root',
                password: 'melissaSBN05',
                database: 'pumpdrink'
            }
        ).promise();
    } else if (AMBIENTE == 'producao') {

        console.log('Projeto rodando inserindo dados em nuvem. Configure as credenciais abaixo.')

    } else {
        throw new Error('Ambiente não configurado. Verifique o arquivo "main.js" e tente novamente.');
    }


    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        const valores = data.split(';');
        const chave = parseInt(valores[0]);


            valoresChave.push(chave);


        if (HABILITAR_OPERACAO_INSERIR) {

            if (AMBIENTE == 'producao') {

                // Este insert irá inserir os dados na tabela "medida" -> altere se necessário
                // Este insert irá inserir dados de fk_aquario id=1 >> você deve ter o aquario de id 1 cadastrado.
                sqlquery = `INSERT INTO tb_registro (dataHora_registro, aprox_registro) VALUES (CURRENT_TIMESTAMP,${chave})`;

                // CREDENCIAIS DO BANCO REMOTO - SQL SERVER
                const connStr = "Server=servidor-acquatec.database.windows.net;Database=bd-acquatec;User Id=usuarioParaAPIArduino_datawriter;Password=#Gf_senhaParaAPI;";

                function inserirComando(conn, sqlquery) {
                    conn.query(sqlquery);
                    console.log("valores inseridos no banco: " + chave)
                }

                sql.connect(connStr)
                    .then(conn => inserirComando(conn, sqlquery))
                    .catch(err => console.log("erro! " + err));

            } else if (AMBIENTE == 'desenvolvimento') {

                // Este insert irá inserir os dados na tabela "medida" -> altere se necessário
                // Este insert irá inserir dados de fk_aquario id=1 >> você deve ter o aquario de id 1 cadastrado.
                await poolBancoDados.execute(
                    
                    'INSERT INTO tb_registro (dataHora_registro, aprox_registro, fk_sensor) VALUES (now(), ?, 1)',
                    [chave]
                );

                await poolBancoDados.execute(

                    'INSERT INTO tb_registro (dataHora_registro, aprox_registro, fk_sensor) VALUES (now(), ?, 2)',
                    [chave]
                );

                await poolBancoDados.execute(

                    'INSERT INTO tb_registro (dataHora_registro, aprox_registro, fk_sensor) VALUES (now(), ?, 3)',
                    [chave]
                );

                console.log("valores inseridos no banco: " + chave)

            } else {
                throw new Error('Ambiente não configurado. Verifique o arquivo "main.js" e tente novamente.');
            }

        }

    });
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

const servidor = (
    valoresChave
) => {
    const app = express();
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });
    app.get('/sensores/chave', (_, response) => {
        return response.json(valoresChave);
    });
}

(async () => {
    const valoresChave = [];
    await serial(
        valoresChave
    );
    servidor(
        valoresChave
    );
})();
