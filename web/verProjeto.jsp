<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="index.jsp">Acessar conta</a></li>
                </ul>
            </div>
        </nav>
        <div class="row container col s12">
            <h3>${sessionScope['projeto'].nome}</h3>
            <h5>${sessionScope['projeto'].descricao}</h5>
            <p>${sessionScope['projeto'].conteudo}</p>
            <a href="projetos">Voltar para os projetos</a>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>