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
        <div class="row">
            <div>
                <div class="col s12">
                    <h5>Projetos já cadastrados: </h5>
                    <table class="highlight">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Conteúdo</th>
                                <th>Opções</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="projeto" items="${daoProjetos.obterProjetos()}">
                                <tr>
                                    <td>
                                        ${projeto.nome}
                                    </td>
                                    <td>
                                        ${projeto.descricao}
                                    </td>
                                    <td>
                                        ${projeto.conteudo}
                                    </td>
                                    <td>
                                        <form action="editarProjeto" method="POST">
                                            <input name="id" value="${projeto.id}" type="hidden">
                                            <button class="btn waves-effect waves-light" type="submit" name="action">Editar
                                                <i class="material-icons right">mode_edit</i>
                                            </button>
                                        </form>
                                        <br>
                                        <form action="excluirProjeto" method="POST">
                                            <input name="id" value="${projeto.id}" type="hidden">
                                            <button class="btn waves-effect waves-light" type="submit" name="action">Excluir
                                                <i class="material-icons right">delete_forever</i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="col s1"></div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>