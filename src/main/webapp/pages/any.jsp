<HTML>
<HEAD>
	<TITLE>JBossEAP6.0 JSP snoop page</TITLE>
	<%@ page import="javax.servlet.http.HttpUtils,java.util.Enumeration" %>
	<%@ page import="java.lang.management.*" %>
	<%@ page import="java.util.*, com.mysql.jdbc.*" %>
</HEAD>
<BODY>

<%
	Date date = new Date();
		out.print("Server time: " + date);
	System.out.println("maybe?");
		%>


		</BODY>
</HTML>