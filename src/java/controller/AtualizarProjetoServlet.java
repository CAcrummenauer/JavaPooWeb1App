package controller;

import dao.ProjetoDao;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "editarProjeto")
public class AtualizarProjetoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String id = httpServletRequest.getParameter("id");
        RequestDispatcher requestDispatcher;
        HttpSession httpSession = httpServletRequest.getSession();
        httpSession.setAttribute("projeto", new ProjetoDao().obterProjeto(Integer.parseInt(id)));
        requestDispatcher = httpServletRequest.getRequestDispatcher("editarProjeto.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}
