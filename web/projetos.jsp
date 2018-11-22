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
                <h5>Aqui, você pode cadastrar novos projetos:</h5>
                <form action="cadastrarProjeto" method="POST">
                    <div class="input-field col s4">
                        <input type="text" class="validate" id="nome" name="nome" required="">
                        <label for="nome">Nome do projeto</label>
                    </div>
                    <div class="input-field col s8">
                        <input type="text" class="validate" id="descricao" name="descricao" required="">
                        <label for="descricao">Descrição do projeto</label>
                    </div>
                    <div class="input-field col s12">
                        <textarea class="materialize-textarea" id="conteudo" name="conteudo" required=""></textarea>
                        <label for="conteudo">Conteúdo do projeto</label>
                    </div>
                    <div class="col s12">
                        <button class="btn waves-effect waves-light" type="submit" name="action">Cadastrar projeto
                            <i class="material-icons right">send</i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <div>
            <hr>
        </div>
        <div class="row col s10">
            <h5 style="margin-left: 10px">Projetos já cadastrados: </h5>
            <c:forEach var="projeto" items="${daoProjetos.obterProjetos()}">
                <div class="col m6 l4">
                    <div class="card">
                        <div class="card-image">
                            <img src="imagens/imagem.jpg">
                            <a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
                            <div class="row col s3">
                                <form action="excluirProjeto" method="POST">
                                    <input name="id" value="${projeto.id}" type="hidden">
                                    <button class="btn-floating btn-large halfway-fab waves-effect waves-light red" type="submit" name="action">
                                        <i class="material-icons left">delete_forever</i>
                                    </button>
                                </form>
                            </div>
                            <div class="row col s3">
                                <form action="editarProjeto" method="POST">
                                    <input name="id" value="${projeto.id}" type="hidden">
                                    <button class="btn-floating btn-large halfway-fab waves-effect waves-light blue" type="submit" name="action" style="margin-right: 80px">
                                        <i class="material-icons left">mode_edit</i>
                                    </button>
                                </form>
                            </div>
                            <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador' && projeto.situacao != 'Aprovado'}">
                                <div class="row col s3">
                                    <form action="aprovarProjeto" method="POST">
                                        <input name="id" value="${projeto.id}" type="hidden">
                                        <button class="btn-floating btn-large halfway-fab waves-effect waves-light green" type="submit" name="action" style="margin-right: 160px">
                                            <i class="material-icons left">thumb_up</i>
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador' && projeto.situacao == 'Aprovado'}">
                                <div class="row col s3">
                                    <form action="reprovarProjeto" method="POST">
                                        <input name="id" value="${projeto.id}" type="hidden">
                                        <button class="btn-floating btn-large halfway-fab waves-effect waves-light lime accent-2" type="submit" name="action" style="margin-right: 160px">
                                            <i class="material-icons left">thumb_down</i>
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-content">
                            <span class="card-title">${projeto.nome}</span>
                            <p>${projeto.descricao}</p>                            
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>