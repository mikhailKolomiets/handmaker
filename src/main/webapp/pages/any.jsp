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
	<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<sql:query var="rs" dataSource="jdbc/TestDB">
		select first, boo from test
	</sql:query>


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
<c:forEach var="row" items="${rs.rows}">
	Foo ${row.first}<br/>
	Bar ${row.boo}<br/>
</c:forEach>

		</BODY>
</HTML>