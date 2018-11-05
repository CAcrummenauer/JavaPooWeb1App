package dao;

import model.Projeto;
import model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDao {

    public static void main(String[] args) {
        new UsuarioDao().read(1000);
    }

    /**
     * Cria um usuario. Retorna true se o usuário foi criado com sucesso. Retorna false se houve um problema durante a criação do usuário.
     *
     * @param usuario
     * @return boolean
     */
    public boolean create(Usuario usuario) {
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
            sQLException.printStackTrace();
        }
        return false;
    }

    /**
     * Retorna um usuário com base em seu id. Retorna null se o usuário não for encontrado.
     *
     * @param id
     * @return Usuario
     */
    public Usuario read(int id) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "SELECT * FROM usuario WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
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
            System.err.println("Erro: ");
            System.err.println(sQLException.getStackTrace());
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
    public Usuario autenticar(String email, String senha) {
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
            sQLException.printStackTrace();
        }
        return null;
    }

    public boolean update(Usuario usuario) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "UPDATE usuario SET nome = ?, email = ?, senha = ?, descricao = ?, tipo = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, usuario.getNome());
            preparedStatement.setString(2, usuario.getEmail());
            preparedStatement.setString(3, usuario.getSenha());
            preparedStatement.setString(5, usuario.getTipo());
            preparedStatement.setInt(6, usuario.getId());
            if (preparedStatement.executeUpdate() > 1) {
                return true;
            }
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "DELETE FROM usuario WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            if (preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return false;
    }

    /**
     * Retorna todos os usuários cadastrados em uma lista.
     *
     * @return ArrayList
     */
    public ArrayList<Usuario> getUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        try {
            Connection connection = new ConectaDbPostgres().getConexao();
            String sql = "SELECT * FROM usuario";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("conteudo"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setTipo(resultSet.getString("tipo"));
                usuarios.add(usuario);
            }
            return usuarios;
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return null;
    }
}
