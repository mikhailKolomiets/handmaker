<HTML>
<HEAD>
    <TITLE>Connect</TITLE>
    <%@ page import="javax.servlet.http.HttpUtils,java.util.Enumeration" %>
    <%@ page import="java.lang.management.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.DriverManager" %>
    <%@ page import="javax.naming.InitialContext" %>
    <%@ page import="javax.sql.*" %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.Statement" %>
    <%@ page import="java.sql.ResultSet" %>
    <%@ page import="mySQLController.Query" %>
    <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
    <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
    <%@ page import="java.io.File" %>
    <%@ page import="org.apache.commons.fileupload.FileItem" %>
    <%@ page import="java.io.InputStream" %>
    <%@ page import="java.io.ByteArrayInputStream" %>
    <%@ page import="java.awt.image.BufferedImage" %>
    <%@ page import="javax.imageio.ImageIO" %>

</HEAD>
<BODY>

<%
    /**
     Date date = new Date();
     out.print("Server time: " + date + "</br>");
     //System.out.println("maybe?"); don't work in server

     Statement baseDo;
     ResultSet resultSet;
     try {


     InitialContext initialContext = new InitialContext();
     DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/MySQLDS");
     Connection connection = dataSource.getConnection();
     out.print("Connect success <br>");
     baseDo = connection.createStatement();
     resultSet = baseDo.executeQuery("SELECT boo FROM test");
     //baseDo.executeUpdate("CREATE TABLE depic (cool VARCHAR (12))"); //Create table
     resultSet.next();
     out.print(resultSet.getInt(1));
     connection.close();
     }catch (Exception e) {
     out.print("Sorry d't connect: " + e.toString());
     }
     */
    //String name = request.getParameter("name");//TODO make кирилица
    Query query = new Query();
    String message = "";
    int fotoId = 1;
    try {

        boolean isMulti = ServletFileUpload.isMultipartContent(request);
        if (isMulti) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (item.isFormField()) {
                    message += " - " + item.toString();
                } else {
                    message += " - " + item.getName() + " (" + item.getSize() + ")" + item.getContentType();
                    //InputStream fileStream = item.getInputStream();
                    byte[] foto = item.get();
                    //int i = query.saveFoto(foto);
                    //message += "<br> --- " + i;
                    //todo upload file
                    item.write(new File("base/" + item.getName()));
                }


            }
            //InputStream inputStream = new ByteArrayInputStream(query.getFoto(1));
            //BufferedImage image = ImageIO.read(inputStream);
           // ImageIO.write(image, "jpg", new File("/convert/foto.jpg"));

        }
    } catch (Exception e) {
        message = "Is bad... <br>" + e.toString() + "<br>" +
        e.getLocalizedMessage();
    }
    out.print(message);

%>


</BODY>
</HTML>