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
    <%@ page import="org.apache.commons.fileupload.FileItem" %>
    <%@ page import="java.awt.image.BufferedImage" %>
    <%@ page import="javax.imageio.ImageIO" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import="java.io.*" %>

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
    String imgSrc = "";
    int fotoId = 1;
    try {

        boolean isMulti = ServletFileUpload.isMultipartContent(request);
        if (isMulti) {
            DiskFileItemFactory factory = new DiskFileItemFactory();

            ServletContext servletContext = config.getServletContext();
            File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
            factory.setRepository(repository);

            ServletFileUpload upload = new ServletFileUpload(factory);
            String path = servletContext.ORDERED_LIBS;
            path = repository.getPath();
            path = path.substring(0,path.length() - 1);
            message += " <br> path : " + path + "<br>";
            //factory.setRepository(new File("/upload"));

            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (item.isFormField()) {
                    item.setFieldName(item.getName());
                    message += " its text "  + "<br>";

                    //item.write(new File("text.txt"));
                } else {
                    message += " - " + item.getName() + " (" + query.getPath() + ")" + item.toString() + "<br> ++";

                    Iterator itr = item.getHeaders().getHeaderNames();
                    while (itr.hasNext()){
                        message += itr.next() + " + ";
                    }
                    message += " ++ " + item.getHeaders().getHeader("content-disposition");
                    //InputStream fileStream = item.getOutputStream();
                    byte[] foto = item.get();

                    int i = query.saveFoto(foto);
                    message += "<br> id = " + i +"--- " + foto + " --- " + foto.length + " --- ";
                    String bi = "<br>";
                    for (byte b : foto) {
                        message += b;
                        bi += "" + b;
                    }
                    message += bi;

                    //todo upload file
                    item.write(new File(path + item.getName()));
                    %>
<img src="<%=item.getName()%>">
<%
                    RandomAccessFile accessFile = new RandomAccessFile(path + item.getName(), "rw");
                    //accessFile.write(foto);


                    message += "<br> Dir name: <br>";
                    Enumeration enumeration = config.getInitParameterNames();
                    while (enumeration.hasMoreElements()){
                        message += enumeration.nextElement() +": ";
                        message += config.getInitParameter(enumeration.nextElement().toString()) + "<br>";
                    }
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

<img src="../images/jbosscorp_logo.png">
<img src="../upload/logo_eng.15f9ead518a4.png">
</BODY>
</HTML>