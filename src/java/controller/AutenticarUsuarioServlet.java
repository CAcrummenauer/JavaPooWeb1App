package controller;

import dao.UsuarioDao;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

@WebServlet(urlPatterns = "/projetos")
public class AutenticarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String email = httpServletRequest.getParameter("email");
        String senha = httpServletRequest.getParameter("senha");
        Usuario usuarioAutenticado = new UsuarioDao().autenticarUsuario(email, senha);
        RequestDispatcher requestDispatcher;
        if (usuarioAutenticado != null) {
            HttpSession httpSession = httpServletRequest.getSession();
            httpSession.setAttribute("usuarioLogado", usuarioAutenticado);
            requestDispatcher = httpServletRequest.getRequestDispatcher("/WEB-INF/views/projetos.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        } else {
            httpServletRequest.setAttribute("mensagem", "Usuário ou senha incorretos!");
            requestDispatcher = httpServletRequest.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        }
    }
}