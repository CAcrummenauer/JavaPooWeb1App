package dao;

import model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Classe responsável pela interação do sistema com o SGBD (destinada para operações com usuários).
 *
 * @author Cezar Augusto Crummenauer
 */
public class UsuarioDao {

    /**
     * Cria um usuario. Retorna true se o usuário foi criado com sucesso. Retorna false se houve um problema durante a criação do usuário.
     *
     * @param usuario
     * @return boolean
     */
    public boolean criarUsuario(Usuario usuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "INSERT INTO usuario (nome, email, senha, tipo) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getSenha());
            preparedStatement.setString(4, usuario.getTipo());
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
     * Retorna um usuário com base em seu id. Retorna null se o usuário não for encontrado.
     *
     * @param idUsuario
     * @return Usuario
     */
    public Usuario obterUsuario(int idUsuario) {
        try (Connection connection = new ConectaDbPostgres().getConexao()) {
            String sql = "SELECT * FROM usuario WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idUsuario);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setTipo(resultSet.getString("tipo"));
                return usuario;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return null;
    }

    /**
     * Retorna um usuário se os dados de login estiverem corretos ou retorna null.
     *
     * @param email
     * @param senha
     * @return Usuario
     */
    public Usuario autenticarUsuario(String email, String senha) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = " SELECT * FROM usuario WHERE email = ? AND senha = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setTipo(resultSet.getString("tipo"));
                return usuario;
            }
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return null;
    }

    /**
     * Atualiza os dados de um usuário. Retorna true se houver sucesso ou false em caso de falha.
     *
     * @param usuario
     * @return boolean
     */
    public boolean atualizarUsuario(Usuario usuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE usuario SET nome = ?, email = ?, senha = ?, tipo = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getSenha());
            preparedStatement.setString(4, usuario.getTipo());
            preparedStatement.setInt(5, usuario.getId());
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
     * @param idUsuario
     * @return boolean
     */
    public boolean deletarUsuario(int idUsuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "DELETE FROM usuario WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idUsuario);
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
     * Altera o tipo de usuário para "Usuário padrão". Retorna true se a operação foi efetuada com sucesso ou retorna false se houve um erro durante o processamento.
     * @param idUsuario
     * @return 
     */

    public boolean tornarUsuarioPadrao(int idUsuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE usuario SET tipo = 'Usuário padrão' WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idUsuario);
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
     * Retorna todos os usuários cadastrados em uma lista. Retorna null se não houver resultados.
     *
     * @return ArrayList
     */
    public ArrayList<Usuario> obterUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "SELECT * FROM usuario ORDER BY nome";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setTipo(resultSet.getString("tipo"));
                usuarios.add(usuario);
            }
            return usuarios;
        } catch (SQLException sQLException) {
            System.err.print("Erro: ");
            sQLException.printStackTrace();
        }
        return null;
    }
}
