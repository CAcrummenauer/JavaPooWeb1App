<%@page import="model.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="daoUsuarios" class="dao.UsuarioDao"/>
<%
    if (request.getSession().getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect("projetos");
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
                    <li><a href="projetos">Projetos</a></li>
                    <li class="active"><a href="usuarios">Usuários</a></li>
                    <li style = "margin-left: 25px; margin-right: 10px">
                        <form action="sair">
                            ${sessionScope['usuarioAutenticado'].nome}
                            <button style = "margin-left: 10px" class="btn waves-effect waves-light" type="submit" name="action">Sair</button>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container row col s12">
            <c:if test="${not empty mensagemSobreUsuario}">
                <p style = "margin-left: 10px"><strong class="orange-text text-accent-4"> ${mensagemSobreUsuario}</strong></p>
            </c:if>
            <h5 style = "margin-left: 2px">Usuários cadastrados:</h5>
            <table class="highlight">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Tipo</th>
                            <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador'}">
                            <th>Opção</th>
                            </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "usuario" items = "${daoUsuarios.obterUsuarios()}">
                        <tr>
                            <td>${usuario.nome}</td>
                            <td>${usuario.email}</td>
                            <td>${usuario.tipo}</td>
                            <c:if test = "${sessionScope['usuarioAutenticado'].tipo == 'Administrador'}">
                                <td class="centered">
                                    <c:if test = "${usuario.tipo == 'Administrador'}">
                                        <form action="tornarUsuario" method="POST">
                                            <input name="id" value="${usuario.id}" type="hidden">
                                            <input name="nome" value="${usuario.nome}" type="hidden">
                                            <button class="btn-large waves-effect waves-light green" type="submit" name="action">
                                                Tornar usuário comum <i class="material-icons left">thumb_down</i>
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test = "${usuario.tipo != 'Administrador'}">
                                        <form action="tornarAdministrador" method="POST">
                                            <input name="id" value="${usuario.id}" type="hidden">
                                            <input name="nome" value="${usuario.nome}" type="hidden">
                                            <button class="btn-large waves-effect waves-light blue accent-4" type="submit" name="action">
                                                Tornar usuário administrador<i class="material-icons left">thumb_up</i>
                                            </button>
                                        </form>
                                    </c:if>
                                    <br>
                                    <form action="excluirUsuario" method="POST">
                                        <input name="id" value="${usuario.id}" type="hidden">
                                        <input name="nome" value="${usuario.nome}" type="hidden">
                                        <button class="btn-large waves-effect waves-light red accent-4" type="submit" name="action">
                                            Excluir usuário<i class="material-icons left">delete_forever</i>
                                        </button>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>