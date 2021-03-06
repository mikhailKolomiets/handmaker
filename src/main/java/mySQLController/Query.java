package mySQLController;

import resources.GaleryItem;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mihail on 21.05.16.
 */
public class Query {

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

    /**
     * @param user
     * @param pass
     * @return 0 if pass incorrect, -1 if user doesn't exist, >0 user id
     */
    public int login(String user, String pass) throws Exception {
        int id = -1;
        connection = connectDB();
        statement = connection.createStatement();
        System.out.println(user);
        String sql = "SELECT * FROM user" +
                " WHERE name = '" + user + "' ";

        resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            if (resultSet.getString("pass").equals(pass))
                id = resultSet.getInt("id");
            else
                id = 0;
        }
        close();
        return id;
    }

    public String createGaleryItem(int userId, String path, String descriptiion, String cathegoty, String name) throws Exception {
        String result;
        connection = connectDB();
        statement = connection.createStatement();

        String sql = "INSERT INTO galery (userId,path,description,category,name) VALUES ('" +
                userId + "','" + path + "','" + descriptiion + "','" + cathegoty + "','" + name + "')";
        try {
            statement.executeUpdate(sql);
            result = "Изделие добавлено!";
        } catch (Exception e) {
            result = e.toString();
        }
        close();
        return result;
    }

    public List<GaleryItem> getAllUserWork(int id) throws Exception {
        List<GaleryItem> userItems = new ArrayList<GaleryItem>();
        connection = connectDB();
        statement = connection.createStatement();

        String sql = "SELECT * FROM galery WHERE userId = " + id;
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            userItems.add(new GaleryItem(resultSet.getInt("id"), resultSet.getInt("userId"), resultSet.getString("path"),
                    resultSet.getString("path2"), resultSet.getString("path3"), resultSet.getString("description"),
                    resultSet.getString("category"), resultSet.getString("name")));
        }

        return userItems;
    }

    public byte[] getFoto(int id) throws Exception {
        byte[] foto;
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "SELECT foto FROM gallery" +
                " WHERE id = '" + id + "' ";
        resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            foto = resultSet.getBytes("foto");
            close();
            return foto;
        }
        return null;
    }

    public boolean createUser(String code) throws Exception {

        connection = connectDB();
        statement = connection.createStatement();
        String sql = "SELECT id, name, pass, email, town FROM registration" +
                " WHERE code = '" + code + "' ";
        resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            int id = resultSet.getInt("id");
            sql = "INSERT INTO user VALUES (NULL ,'" + resultSet.getString("name") + "' ,'" + resultSet.getString("pass") + "' ,'" +
                    resultSet.getString("email") + "', '" + resultSet.getString("town") + "')";
            statement.executeUpdate(sql);
            sql = "DELETE FROM registration " + "WHERE id = " + id;
            statement.executeUpdate(sql);
            close();
            return true;
        }
        close();
        return false;
    }

    public boolean deleteUser(int id) throws Exception {
        connection = connectDB();
        statement = connection.createStatement();
        String sql = "DELETE FROM user WHERE id = " + id;
        statement.executeUpdate(sql);
        close();
        return true;
    }

    public String getPath() throws UnsupportedEncodingException {

        String path = this.getClass().getClassLoader().getResource("").getPath();

        String fullPath = URLDecoder.decode(path, "UTF-8");

        String pathArr[] = fullPath.split("/WEB-INF/classes/");

        System.out.println(fullPath);

        System.out.println(pathArr[0]);

        fullPath = pathArr[0];


        String reponsePath = "";

// to read a file from webcontent

        reponsePath = new File(fullPath).getPath() + File.separatorChar + "newfile.txt";

        return reponsePath;

    }

    private void close() throws Exception {
        if (connection != null) {
            connection.close();
            statement.close();
        }
    }

    private Connection connectDB() throws Exception {
        InitialContext initialContext = new InitialContext();
        DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/handmaker");
        return dataSource.getConnection();
    }
}
