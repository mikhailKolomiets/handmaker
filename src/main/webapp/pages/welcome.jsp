
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
    int oiuy = 0;
    if (EnumFinder.find(request.getParameterNames(), "login")) {
        Query query = new Query();
        try {
            //int oiuy = 0;
            oiuy = query.select("first", "prik");
            message += oiuy + "";

            int logInt = query.login(request.getParameter("login"), request.getParameter("logpass"));
            if (logInt > 0) {
                //message = "Вход выполнен";
                session.setAttribute("idUser", logInt);
                session.setAttribute("userName", request.getParameter("login"));

            } else if (logInt < 0)
                message = "Пользователя " + request.getParameter("login") + " нет в базе. Проверьте свой еmail.";
            else {
                message = "Неправильный пароль для пользователя " + request.getParameter("login") + ".";
            }//todo send pass to email
        } catch (Exception bde) {
            message = oiuy + bde.toString();
        }
    }
    if (!EnumFinder.find(session.getAttributeNames(), "idUser")) {
        out.print(message + "<form action=\"index.jsp\" method=\"post\">\n" +
                "  Логи: <input type=\"text\" size=\"8\" name=\"login\" required=\"\"><br>\n" +
                "  Пароль: <input type=\"password\" size=\"8\" name=\"logpass\" required=\"\"><br>\n" +
                "  <input type=\"submit\" value=\"Войти\">\n" +
                "</form>" );



    } else {//todo workroom
        //out.print(session.getAttribute("idUser"));
        %><p> личный кабинет</p>
<div ng-init = " sitePart = 'userRoom'">
</div>
<form action="index.jsp" method="post">
    <input type="text" hidden="" value="exit" name="exit">
    <input type="submit" value="Выйти"></form>





<%//todo design
    }
%>


</body>
</html>
