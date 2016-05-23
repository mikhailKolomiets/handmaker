<%@ page import="resources.EnumFinder" %>
<%@ page import="mySQLController.Query" %>
<%--
  Created by IntelliJ IDEA.
  User: mihail
  Date: 21.05.16
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
  String message = "Nothing does";
  if (EnumFinder.find(request.getParameterNames(), "login")) {
    Query query = new Query();
    try {
      int logInt = query.login(request.getParameter("login"), request.getParameter("logpass"));
      if (logInt > 0)
        message = "Вход выполнен";
      else if(logInt > 0)
        message = "user dosen't exist";
      else message = "password incorrect";
    }catch (Exception bde){message = bde.toString();}
  }
  out.print(message);
%>
<form action="index.jsp" method="post">
  Логин: <input type="text" size="8" name="login" required=""><br>
  Пароль: <input type="password" size="8" name="logpass" required=""><br>
  <input type="submit" value="Войти">
</form>
</body>
</html>
