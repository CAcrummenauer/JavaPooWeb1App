<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <title>Cadastrar usuário</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper">
                <a style="padding-left: 20px" href="index.jsp" class="brand-logo"><i class="material-icons">cloud</i>Projetos CSI</a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="index.jsp">Acessar conta</a></li>
                </ul>
            </div>
        </nav>
        <div class="row container" style="padding-top: 50px">
            <div class="col s3"></div>
            <form action="projetos" method="POST" class="col s6">
                <h4>Cadastre uma conta</h4>
                <blockquote>
                    Fazendo isso, você poderá cadastrar e visualizar projetos
                </blockquote>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="nome" type="text" class="validate" name="nome" required>
                        <label for="nome">Nome</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="email" type="email" class="validate" name="email" required>
                        <label for="email">E-mail</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="password" type="password" class="validate" name="senha" required>
                        <label for="password">Senha</label>
                    </div>
                </div>
                <button class="btn waves-effect waves-light" type="submit" name="action">Cadastrar conta
                    <i class="material-icons right">send</i>
                </button>
                <div>
                    <c:if test="${not empty mensagem}">
                        <h6>
                            <strong class="red-text text-darken-2"> ${mensagem}</strong> E-mail já cadastrado...
                        </h6>
                    </c:if>
                </div>
            </form>
            <div class="col s3"></div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>