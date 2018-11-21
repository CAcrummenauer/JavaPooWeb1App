<%@page import="dao.ProjetoDao"%>
<%@page import="model.Projeto"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <h5>Aqui, voc� pode cadastrar novos projetos:</h5>
            <form action="cadastrarProjeto" method="POST">
                <div class="input-field">
                    <input type="text" class="validate" id="nome" name="nome">
                    <label for="nome">Nome do projeto</label>
                </div>
                <div class="input-field">
                    <input type="text" class="validate" id="descricao" name="descricao">
                    <label for="descricao">Descri��o do projeto</label>
                </div>
                <div class="input-field">
                    <textarea class="materialize-textarea" id="conteudo" name="conteudo"></textarea>
                    <label for="conteudo">Conte�do do projeto</label>
                </div>
                <button class="btn waves-effect waves-light" type="submit" name="action">Cadastrar projeto
                    <i class="material-icons right">send</i>
                </button>
            </form>
            <hr>
            <h5>Projetos j� cadastrados: </h5>
            <table class="table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Descri��o</th>
                        <th>Conte�do</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            for (Projeto projeto : new ProjetoDao().obterProjetos()) {
                                out.print("<tr><td>");
                                out.println(projeto.getNome());
                                out.print("</td><td>");
                                out.println(projeto.getDescricao());
                                out.print("</td><td>");
                                out.println(projeto.getConteudo());
                                out.print("</td></tr>");
                            }
                        } catch (Exception exc) {
                            out.print("Deu ruim ao buscar os projetos...");
                        }
                    %>
                </tbody>
            </table>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>