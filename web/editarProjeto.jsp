<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjetoDao"%>
<%@page import="model.Projeto"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="daoProjetos" class="dao.ProjetoDao"/>
<%
    if (request.getSession().getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <title>Projetos CSI</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper">
                <a style="padding-left: 20px" href="index.jsp" class="brand-logo"><i class="material-icons">cloud</i>Projetos CSI</a>
                <ul id="nav-mobile" class="right hide-on-med-and-down" style="margin-right: 25px">
                    <form action="sair">
                        ${sessionScope['usuarioAutenticado'].nome}
                        <button style="margin-left: 10px" class="btn waves-effect waves-light" type="submit" name="action">Sair</button>
                    </form>
                </ul>
            </div>
        </nav>
        <div class="row container">
            <div>
                <h5>Aqui, você pode editar seu projeto:</h5>
                <form action="finalizarEdicaoDeProjeto" method="POST">
                    <div class="input-field col s4">
                        <input type="text" class="validate" id="nome" name="nome" required="" value="${sessionScope['projeto'].nome}">
                        <label for="nome">Nome do projeto</label>
                    </div>
                    <div class="input-field col s8">
                        <input type="text" class="validate" id="descricao" name="descricao" required="" value="${sessionScope['projeto'].descricao}">
                        <label for="descricao">Descrição do projeto</label>
                    </div>
                    <div class="input-field col s12">
                        <input value="${sessionScope['projeto'].id}" name="id" type="hidden">
                        <textarea class="materialize-textarea" id="conteudo" name="conteudo" required="">${sessionScope['projeto'].conteudo}</textarea>
                        <label for="conteudo">Conteúdo do projeto</label>
                    </div>
                    <div class="col s12">
                        <p class="orange-text text-darken-4"><i class="material-icons">report_problem</i>Atenção: Projetos atualizados precisão aguardar moderação novamente... <a href="projetos">Voltar para os projetos sem alterar nada</a></p>
                        <button class="btn waves-effect waves-light" type="submit" name="action">Atualizar projeto
                            <i class="material-icons right">send</i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>