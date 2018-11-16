<%@page import="dao.ProjetoDao"%>
<%@page import="model.Projeto"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
        <div class="py-2">
            <div class="container">
                <div class="row">
                    <div class="px-5 col-md-8 text-center mx-auto">
                        <h2 class="text-primary"><b><h2>Olá, ${sessionScope['usuarioAutenticado'].nome}</h2></b></h2>
                        <h2 class="my-3">Aqui, você pode cadastrar novos projetos:</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="py-0">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <form action="cadastrar" method="POST">
                            <div class="form-group">
                                <label>Nome do projeto</label>
                                <input type="text" class="form-control" placeholder="Nome do projeto" name="nome">
                            </div>
                            <div class="form-group">
                                <label>Descrição do projeto</label>
                                <input type="text" class="form-control" placeholder="Descrição do projeto" name="descricao">
                            </div>
                            <div class="form-group">
                                <label>Conteúdo do projeto</label>
                                <textarea class="form-control" placeholder="Descrição do projeto" name="conteudo"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Cadastrar projeto</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="py-0">
            <div class="container">
                <div class="row">
                    <div class="col-md-12" style="margin-top: 40px;">
                        <h3 class="">Projetos já cadastrados: </h3>
                    </div>
                </div>
            </div>
        </div>
        <div class="py-2">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Descrição</th>
                                    <th>Conteúdo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    try {
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
                </div>
            </div>
        </div>
    </body>
</html>