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
                <a style="padding-left: 20px" href="projetos" class="brand-logo"><i class="material-icons">cloud</i>Projetos CSI</a>
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
                <h5 style="margin-left: 10px">Aqui, você pode cadastrar novos projetos:</h5>
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
                        <input name="idUsuario" value="${sessionScope['usuarioAutenticado'].id}" type="hidden">
                        <textarea class="materialize-textarea" id="conteudo" name="conteudo" required=""></textarea>
                        <label for="conteudo">Conteúdo do projeto</label>
                    </div>
                    <div class="col s12">
                        <button class="btn waves-effect waves-light" type="submit" name="action">Cadastrar projeto
                            <i class="material-icons right">send</i>
                        </button>
                        <c:if test="${not empty mensagem}">
                            <strong class="orange-text text-accent-4"> ${mensagem}</strong><br>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
        <div>
            <hr>
        </div>
        <div class="row col s12">
            <c:if test="${not empty mensagemParaProjetoJaCadastrado}">
                <p style = "margin-left: 10px"><strong class="orange-text text-accent-4"> ${mensagemParaProjetoJaCadastrado}</strong></p>
            </c:if>
            <h5 style = "margin-left: 10px">Projetos já cadastrados:</h5>
            <c:forEach var = "projeto" items = "${daoProjetos.obterProjetos()}">
                <c:if test = "${sessionScope['usuarioAutenticado'].id == projeto.idUsuario || sessionScope['usuarioAutenticado'].tipo == 'Administrador' || projeto.situacao == 'Aprovado'}">
                    <div class="row col m6 l3">
                        <div class="card">
                            <div class="card-image">
                                <img src="imagens/imagem.jpg">
                                <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador' || sessionScope['usuarioAutenticado'].id == projeto.idUsuario}">
                                    <form action="excluirProjeto" method="POST">
                                        <input name="id" value="${projeto.id}" type="hidden">
                                        <input name="nome" value="${projeto.nome}" type="hidden">
                                        <button class="btn-floating btn-large halfway-fab waves-effect waves-light red" type="submit" name="action">
                                            <i class="material-icons left">delete_forever</i>
                                        </button>
                                    </form>
                                    <form action="editarProjeto" method="POST">
                                        <input name="id" value="${projeto.id}" type="hidden">
                                        <button class="btn-floating btn-large halfway-fab waves-effect waves-light blue" type="submit" name="action" style="margin-right: 80px">
                                            <i class="material-icons left">mode_edit</i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador'}">
                                    <c:if test = "${projeto.situacao != 'Aprovado'}">
                                        <form action="aprovarProjeto" method="POST">
                                            <input name="id" value="${projeto.id}" type="hidden">
                                            <input name="nome" value="${projeto.nome}" type="hidden">
                                            <button class="btn-floating btn-large halfway-fab waves-effect waves-light green" type="submit" name="action" style="margin-right: 160px">
                                                <i class="material-icons left">thumb_up</i>
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test = "${projeto.situacao == 'Aprovado'}">
                                        <form action="reprovarProjeto" method="POST">
                                            <input name="id" value="${projeto.id}" type="hidden">
                                            <input name="nome" value="${projeto.nome}" type="hidden">
                                            <button class="btn-floating btn-large halfway-fab waves-effect waves-light orange accent-4" type="submit" name="action" style="margin-right: 160px">
                                                <i class="material-icons left">thumb_down</i>
                                            </button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </div>
                            <div class="card-content">
                                <span class="card-title">${projeto.nome}</span>
                                <p>${projeto.descricao}</p>
                                <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador' || sessionScope['usuarioAutenticado'].id == projeto.idUsuario}">
                                    <c:if test = "${projeto.situacao == 'Reprovado'}">
                                        <p class="red-text text-darken-4"><i class="material-icons">report</i> Projeto reprovado!</p>
                                    </c:if>
                                    <c:if test = "${projeto.situacao == 'Aguardando avaliação'}">
                                        <p class="orange-text text-darken-2"><i class="material-icons">report_problem</i> Projeto aguardando avaliação...</p>
                                    </c:if>
                                    <c:if test = "${projeto.situacao == 'Aprovado'}">
                                        <p class="green-text text-darken-4"><i class="material-icons">public</i> Projeto aprovado! Ele pode ser visto publicamente...</p>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>