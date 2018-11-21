package controller;

import dao.ProjetoDao;
import model.Projeto;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "cadastrarProjeto")
public class CadastrarProjetoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String nome = httpServletRequest.getParameter("nome");
        String descricao = httpServletRequest.getParameter("descricao");
        String conteudo = httpServletRequest.getParameter("conteudo");
        System.out.println(nome);
        new ProjetoDao().criarProjeto(new Projeto(nome, descricao, conteudo, "Aguardando avaliação"), 30);
//        RequestDispatcher requestDispatcher;
//        requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
//        requestDispatcher.forward(httpServletRequest, httpServletResponse);
        httpServletResponse.sendRedirect("projetos");
    }
}
