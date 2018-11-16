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

@WebServlet(urlPatterns = "projetos.jsp")
public class AutenticarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String nome = httpServletRequest.getParameter("nome");
        String email = httpServletRequest.getParameter("email");
        String senha = httpServletRequest.getParameter("senha");
        RequestDispatcher requestDispatcher;

        if (nome.equals("ApenasLoginSemNome")) {
            Usuario usuarioAutenticado = new UsuarioDao().autenticarUsuario(email, senha);
            if (usuarioAutenticado != null) {
                HttpSession httpSession = httpServletRequest.getSession();
                httpSession.setAttribute("usuarioAutenticado", usuarioAutenticado);
                requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);
            } else {
                httpServletRequest.setAttribute("mensagem", "Usuário ou senha incorretos!");
                requestDispatcher = httpServletRequest.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);
            }
        } else {
            if (new UsuarioDao().criarUsuario(new Usuario(nome, email, senha, "Usuario"))) {
                HttpSession httpSession = httpServletRequest.getSession();
                httpSession.setAttribute("usuarioAutenticado", new UsuarioDao().autenticarUsuario(email, senha));
                requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);
            } else {
                /*httpServletRequest.setAttribute("mensagem", "Falha ao cadastrar o usuário!");
                requestDispatcher = httpServletRequest.getRequestDispatcher("cadastrarUsuario.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);*/
            }
        }
    }
}
