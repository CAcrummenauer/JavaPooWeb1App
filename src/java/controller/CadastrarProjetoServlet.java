package controller;

import dao.ProjetoDao;
import model.Projeto;
import java.io.IOException;
import java.util.Date;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns = "/cadastrar")
public class CadastrarProjetoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        String nome = req.getParameter("nome");
        String descricao = req.getParameter("descricao");
        String conteudo = req.getParameter("conteudo");
        System.out.println(nome);
        Projeto projeto = new Projeto(nome, new Date(System.currentTimeMillis()), descricao, conteudo, "Aguardando avaliação");
        if (new ProjetoDao().criarProjeto(projeto, 1)) {
            System.err.println("Funcionou!");
        } else {
            System.err.println("Deu ruim!!!!!");
        }
        RequestDispatcher disp;
        disp = req.getRequestDispatcher("/WEB-INF/views/projetos.jsp");
        disp.forward(req, resp);
    }
}