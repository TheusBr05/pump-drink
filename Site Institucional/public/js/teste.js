function cadastrar() {
    aguardar();

    //Recupere o valor da nova input pelo nome do id
    // Agora vá para o método fetch logo abaixo
    var nomeVar = nome_input.value;
    var emailVar = email_input.value;
    var senhaVar = senha_input.value;
    var cpfVar = cpf_input.value;
    var confirmacaoSenhaVar = confirmacao_senha_input.value;

    if(emailVar.indexOf("@") == -1 || emailVar.indexOf(".") == -1 ){
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "(O email inválido)";

        finalizarAguardar();
        return false;
               
    } else if(senhaVar.length < 6){
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "(A senha precisa ter no mínimo 6 caracteres)";

        finalizarAguardar();
        return false;
    }else if(senhaVar != confirmacaoSenhaVar){
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "(Confirme a senha!)";

        finalizarAguardar();
        return false;
    }else if(cpfVar.length != 14){
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "(O cpf inválido)";

        finalizarAguardar();
        return false;
    
    }

   else if (nomeVar == "" || emailVar == "" || senhaVar == "" || cpfVar == "" || confirmacaoSenhaVar == "") {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Mensagem de erro para todos os campos em branco";

        finalizarAguardar();
        return false;
    }else {
        setInterval(sumirMensagem, 5000)
    }
    
   
    // Enviando o valor da nova input
    fetch("/usuarios/cadastrar", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            // crie um atributo que recebe o valor recuperado aqui
            // Agora vá para o arquivo routes/usuario.js
            nomeServer: nomeVar,
            emailServer: emailVar,
            cpfServer: cpfVar,
            senhaServer: senhaVar
        })
    }).then(function (resposta) {

        console.log("resposta: ", resposta);

        if (resposta.ok) {
            cardErro.style.display = "block";

            mensagem_erro.innerHTML = "Cadastro realizado com sucesso! Redirecionando para tela de Login...";

            setTimeout(() => {
                window.location = "login.html";
            }, "2000")

            limparFormulario();
            finalizarAguardar();
        } else {
            throw ("Houve um erro ao tentar realizar o cadastro!");
        }
    }).catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        finalizarAguardar();
    });

    return false;
}

function sumirMensagem() {
    cardErro.style.display = "none"
}