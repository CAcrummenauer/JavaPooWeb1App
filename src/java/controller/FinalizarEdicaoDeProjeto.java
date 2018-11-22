package controller;

import dao.ProjetoDao;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Projeto;

@WebServlet(urlPatterns = "finalizarEdicaoDeProjeto")
public class FinalizarEdicaoDeProjeto extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String nome = httpServletRequest.getParameter("nome");
        String descricao = httpServletRequest.getParameter("descricao");
        String conteudo = httpServletRequest.getParameter("conteudo");
        int id = Integer.parseInt(httpServletRequest.getParameter("id"));
        RequestDispatcher requestDispatcher;
        
        if (new ProjetoDao().atualizarProjeto(new Projeto(id, nome, descricao, conteudo, "Aguardando aprovação..."))) {
            requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        } else {
            httpServletRequest.setAttribute("mensagem", "Deu ruim ao atuzalizar o projeto!");
            requestDispatcher = httpServletRequest.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        }
    }

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}