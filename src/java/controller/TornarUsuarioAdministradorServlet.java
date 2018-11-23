package controller;

import dao.UsuarioDao;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "tornarUsuarioAdministrador")
public class TornarUsuarioAdministradorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int id = Integer.parseInt(httpServletRequest.getParameter("id"));
        String nome = httpServletRequest.getParameter("nome");
        if (new UsuarioDao().tornarUsuarioAdministrador(id)) {
            httpServletRequest.setAttribute("mensagemSobreUsuario", "Usuário \"" + nome + "\" TRANSFORMADO EM USUÁRIO ADMINISTRADOR com sucesso!");
            RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("usuarios.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        } else {
            httpServletRequest.setAttribute("mensagemParaProjetoJaCadastrado", "Ocorreu um ERRO enquanto o usuário \"" + nome + "\" era TRANSFORMADO EM USUÁRIO ADMINISTRADOR!");
            RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("usuarios.jsp");
            requestDispatcher.forward(httpServletRequest, httpServletResponse);
        }        
    }

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}
