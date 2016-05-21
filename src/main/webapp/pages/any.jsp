<HTML>
<HEAD>
	<TITLE>Connect</TITLE>
	<%@ page import="javax.servlet.http.HttpUtils,java.util.Enumeration" %>
	<%@ page import="java.lang.management.*" %>
	<%@ page import="java.util.*" %>
	<%@ page import="java.sql.DriverManager" %>
	<%@ page import="javax.naming.InitialContext" %>
	<%@ page import="javax.sql.DataSource" %>
	<%@ page import="java.sql.Connection" %>


</HEAD>
<BODY>

<%
	Date date = new Date();
		out.print("Server time: " + date + "</br>");
	//System.out.println("maybe?"); don't work in server

	try {


		InitialContext initialContext = new InitialContext();
		DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/dbconnect");
		Connection connection = dataSource.getConnection();
		out.print("Connect success");
	}catch (Exception e) {
		out.print("Sorry d't connect: " + e.toString());
	}
		%>


		</BODY>
</HTML>