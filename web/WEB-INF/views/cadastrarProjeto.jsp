<%@page import="br.csi.dao.ProjetoDAO"%>
<%@page import="br.csi.model.Projeto"%>
<%@page import="br.csi.dao.UsuarioDAO"%>
<%@page import="br.csi.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="theme.css" type="text/css">
    </head>
    <body>
        <div class="py-2">
            <div class="container">
                <div class="row">
                    <div class="px-5 col-md-8 text-center mx-auto">
                        <h2 class="text-primary"><b><h2>Olá, ${sessionScope['usuarioLogado'].nome}</h2></b></h2>
                        <h2 class="my-3">Aqui, você pode cadastrar novos projetos:</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="py-0">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <form action="projetos" method="POST">
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
                                <%
                                    try {
                                        for (Projeto projeto : new ProjetoDAO().getProjetos()) {
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>