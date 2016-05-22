package mySQLController;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;

/**
 * Created by mihail on 21.05.16.
 */
public class Query {
    private InitialContext initialContext;
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;

    /**
     * Take static var type int from base in table
     *
     * @param var
     * @param table
     * @return
     * @throws Exception
     */
    public int select(String var, String table) throws Exception {
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "SELECT " + var + " FROM " + table;
        resultSet = statement.executeQuery(sql);
        resultSet.next();
        int value = resultSet.getInt(1);
        close();
        return value;

    }

    public void addStringColumn(String var, int size, String table) throws Exception {
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "ALTER TABLE " + table + " ADD " + var + " VARCHAR(" + size + ") NOT NULL";
        statement.executeUpdate(sql);
        close();
    }

    public String createRegistration(String name, String password, String email, String town) throws Exception {
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "INSERT INTO registration VALUES (NULL , '" +name + "' ,'"+password+"' ,'supercode' ,'"+email+
                "' , '"+ town + "')";
        statement.executeUpdate(sql);
        close();
        return null;
    }

    private void close() throws Exception {
        if (connection != null) {
            connection.close();
            statement.close();
        }
    }

    private Connection connectDB() throws Exception {
        initialContext = new InitialContext();
        dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/MySQLDS");
        return dataSource.getConnection();
    }
}
