package mySQLController;

import org.apache.commons.fileupload.FileItem;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.sql.rowset.serial.SerialBlob;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.*;

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

    public int saveFoto(byte[] foto) throws Exception {
        int id;
        String sFoto = "";
        char buff = 0;
        for (id = 0; id < foto.length; id++){
            if(id%2 == 0){
                buff = (char)(foto[id]>>8);
            }
            else {
                buff += foto[id];
                sFoto += buff;
            }
            if (id == foto.length - 1)
                sFoto += buff;
        }

        connection = connectDB();


        statement = connection.createStatement();
        //Blob blob = new SerialBlob(foto);
        String sql = "INSERT INTO gallery VALUES (NULL,  '" +  sFoto + "' )";

        statement.executeUpdate(sql);
        resultSet = statement.getGeneratedKeys();
        id = resultSet.getInt("id");
        close();
        return id;


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
            statement.setFetchDirection(1);
            sql = "DELETE FROM registration " + "WHERE id = " + id;
            statement.executeUpdate(sql);
            close();
            return true;
        }
        close();
        return false;
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
        DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/MySQLDS");
        return dataSource.getConnection();
    }
}
