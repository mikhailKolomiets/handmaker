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
    String message = "";
    int logint = 0;
    if (EnumFinder.find(request.getParameterNames(), "login")) {
        Query query = new Query();
        try {
            logint = query.login(request.getParameter("login"), request.getParameter("logpass"));
            if (logint > 0) {
                //message = "Вход выполнен";
                session.setAttribute("idUser", logint);
                session.setAttribute("userName", request.getParameter("login"));

            } else if (logint < 0)
                message = "Пользователя " + request.getParameter("login") + " нет в базе. Проверьте свой еmail.";
            else {
                message = "Неправильный пароль для пользователя " + request.getParameter("login") + ".";
            }//todo send pass to email
        } catch (Exception bde) {
            message = bde.toString();
        }
    }
    if (!EnumFinder.find(session.getAttributeNames(), "idUser")) {
        out.print(message + "<form action=\"index.jsp\" method=\"post\">\n" +
                "  Логи: <input type=\"text\" size=\"8\" name=\"login\" required=\"\"><br>\n" +
                "  Пароль: <input type=\"password\" size=\"8\" name=\"logpass\" required=\"\"><br>\n" +
                "  <input type=\"submit\" value=\"Войти\">\n" +
                "</form>");
    } else {
%>
<div ng-init=" sitePart = 'userRoom'; id = '<%=logint%>'">
</div>

<%
    }
%>


</body>
</html>
