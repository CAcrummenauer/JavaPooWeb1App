package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectaDbPostgres {
    Connection connection = null;
    private static final String URL = "jdbc:postgresql://localhost:5432/trabalhoPooWebI";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "1234";
    public static void main(String[] args) {
        new ConectaDbPostgres().getConexao();
    }
    
    public Connection getConexao() {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return connection;
    }
}
