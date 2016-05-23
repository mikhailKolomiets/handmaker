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

    public String createRegistration(String name, String password, String email, String town, String code) throws Exception {
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "INSERT INTO registration VALUES (NULL , '" + name + "' ,'" + password + "' ,'" + code + "' ,'" + email +
                "' , '" + town + "')";
        statement.executeUpdate(sql);
        close();
        return null;
    }

    public int findByCode(String code) throws Exception {
        int id = 0;
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "SELECT id FROM registration" +
                " WHERE code = '" + code + "' ";
        resultSet = statement.executeQuery(sql);
        if (resultSet.next())
            id = resultSet.getInt(1);
        return id;
    }

    public boolean createUser(String code) throws Exception {

        connection = connectDB();
        statement = connection.createStatement();
        String sql = "SELECT id FROM registration" +
                " WHERE code = '" + code + "' ";
        resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {

            sql = "INSERT INTO user VALUES (NULL ,'" + resultSet.getString("name") + "' ,'" + resultSet.getString("pass") + "' ,'" +
                    resultSet.getString("email") + "', '" + resultSet.getString("town") + "')";

            statement.executeUpdate(sql);
            close();
            return true;
        }
        close();
        return false;
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
