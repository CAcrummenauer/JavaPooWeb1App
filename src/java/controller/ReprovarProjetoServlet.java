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
        new ProjetoDao().reprovarProjeto(id);
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}
