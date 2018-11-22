package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Projeto;

/**
 * Classe responsável pela interação do sistema com o SGBD (destinada para operações com projetos).
 *
 * @author Cezar Augusto Crummenauer
 */
public class ProjetoDao {

    /**
     * Cria um projeto. Retorna true se o projeto foi criado com sucesso. Retorna false se houve um problema durante a criação do projeto.
     *
     * @param projeto
     * @param idUsuario
     * @return boolean
     */
    public boolean criarProjeto(Projeto projeto, int idUsuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "INSERT INTO projeto (id_usuario, nome, descricao, conteudo, situacao) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idUsuario);
            preparedStatement.setString(2, projeto.getNome());
            preparedStatement.setString(3, projeto.getDescricao());
            preparedStatement.setString(4, projeto.getConteudo());
            preparedStatement.setString(5, projeto.getSituacao());
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return false;
    }

    /**
     * Retorna um projeto com base em seu id. Retorna null se o projeto não for encontrado.
     *
     * @param idProjeto
     * @return Projeto
     */
    public Projeto obterProjeto(int idProjeto) {
        try (Connection connection = new ConectaDbPostgres().getConexao()) {
            String sql = "SELECT * FROM projeto WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idProjeto);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Projeto projeto = new Projeto();
                projeto.setId(resultSet.getInt("id"));
                projeto.setIdUsuario(resultSet.getInt("id_usuario"));
                projeto.setNome(resultSet.getString("nome"));
                projeto.setDescricao(resultSet.getString("descricao"));
                projeto.setConteudo(resultSet.getString("conteudo"));
                projeto.setSituacao(resultSet.getString("situacao"));
                return projeto;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return null;
    }

    /**
     * Atualiza os dados de um projeto. Retorna true se houver sucesso ou false em caso de falha.
     *
     * @param projeto
     * @return boolean
     */
    public boolean atualizarProjeto(Projeto projeto) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE projeto SET nome = ?, descricao = ?, conteudo = ?, situacao = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, projeto.getNome());
            preparedStatement.setString(2, projeto.getDescricao());
            preparedStatement.setString(3, projeto.getConteudo());
            preparedStatement.setString(4, projeto.getSituacao());
            preparedStatement.setInt(5, projeto.getId());
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return false;
    }

    /**
     * Deleta um usuário com base em seu id. Retorna true em caso de sucesso ou false em caso de falha.
     *
     * @param idProjeto
     * @return boolean
     */
    public boolean deletarProjeto(int idProjeto) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "DELETE FROM projeto WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idProjeto);
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return false;
    }

    public boolean aprovarProjeto(int idProjeto) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE projeto SET situacao = 'Aprovado' WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idProjeto);
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return false;
    }

    public boolean reprovarProjeto(int idProjeto) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE projeto SET situacao = 'Reprovado' WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idProjeto);
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return false;
    }

    /**
     * Retorna todos os projetos cadastrados em uma lista. Retorna null se não houver resultados.
     *
     * @return ArrayList
     */
    public ArrayList<Projeto> obterProjetos() {
        ArrayList<Projeto> projetos = new ArrayList<Projeto>();
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "SELECT * FROM projeto ORDER BY nome";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Projeto projeto = new Projeto();
                projeto.setId(resultSet.getInt("id"));
                projeto.setIdUsuario(resultSet.getInt("id_usuario"));
                projeto.setNome(resultSet.getString("nome"));
                projeto.setDescricao(resultSet.getString("descricao"));
                projeto.setConteudo(resultSet.getString("conteudo"));
                projeto.setSituacao(resultSet.getString("situacao"));
                projetos.add(projeto);
            }
            return projetos;
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return null;
    }
}
