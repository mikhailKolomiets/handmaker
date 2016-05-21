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


</HEAD>
<BODY>

<%
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
		out.print(resultSet);
	}catch (Exception e) {
		out.print("Sorry d't connect: " + e.toString());
	}
		%>


		</BODY>
</HTML>