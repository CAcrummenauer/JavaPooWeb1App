package controller;

import dao.ProjetoDao;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import model.Projeto;

@WebServlet(urlPatterns = "finalizarEdicaoDeProjeto")
public class FinalizarEdicaoDeProjetoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String caminhoImagemParteA = "C:/JavaPooWeb1App/web/";
        String caminhoImagemParteB = "imagens/" + System.currentTimeMillis() + ".jpg";
        try {
            /*Faz o parse do request*/
            List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(httpServletRequest);
            String nome = multiparts.get(0).getString();
            String descricao = multiparts.get(1).getString();
            String conteudo = multiparts.get(2).getString();
            int id = Integer.parseInt(multiparts.get(3).getString());

            
            for (FileItem item : multiparts) {
                if (!item.isFormField()) {
                    item.write(new File(caminhoImagemParteA + caminhoImagemParteB));
                    
                }
            }
            
            Projeto projeto = new Projeto(id, nome, descricao, conteudo, "Aguardando avaliação", caminhoImagemParteB);
            
            if (new ProjetoDao().atualizarProjeto(projeto)) {
                HttpSession httpSession = httpServletRequest.getSession();
                httpSession.setAttribute("projeto", projeto);
                RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("verProjeto.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);
            } else {
                httpServletRequest.setAttribute("mensagemParaProjetoJaCadastrado", "Ocorreu um ERRO durante a ATUALIZAÇÃO do projeto \"" + nome + "\"!");
                RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
                requestDispatcher.forward(httpServletRequest, httpServletResponse);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("projetos.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}
