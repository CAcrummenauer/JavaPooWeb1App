package controller;

import dao.ProjetoDao;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "reprovarProjeto")
public class ReprovarProjetoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int id = Integer.parseInt(httpServletRequest.getParameter("id"));
        String nome = httpServletRequest.getParameter("nome");
        if (new ProjetoDao().reprovarProjeto(id)) {
            httpServletRequest.setAttribute("mensagemParaProjetoJaCadastrado", "Projeto \"" + nome + "\" REPROVADO com sucesso!");
            RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        } else {
            httpServletRequest.setAttribute("mensagemParaProjetoJaCadastrado", "Ocorreu um ERRO durante a REPROVAÇÃO do projeto \"" + nome + "\"!");
            RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        }
    }

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}
