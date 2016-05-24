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
	String message = "Nothing";
	try {
		//out.print("from query: " + query.select("boo", "test") + "<br><br>");
		//query.addStringColumn("super", 15, "test");
		boolean isMulti = ServletFileUpload.isMultipartContent(request);
		message = isMulti ? "ok" : "no";
		DiskFileItemFactory factory = new DiskFileItemFactory();
		message += factory.getRepository();
	}catch (Exception e){
		message = "Is bad... " + e.toString();
	}
	out.print(message);

		%>


		</BODY>
</HTML>