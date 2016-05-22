<%@ page import="mySQLController.Query" %>
<%@ page import="validation.RegistrationValidate" %>
<%--
  Created by IntelliJ IDEA.
  User: mihail
  Date: 22.05.16
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>
<%
    RegistrationValidate registrationValidate = new RegistrationValidate();
    Query query = new Query();
    try {
        String message = request.getParameter("confPass").isEmpty() ? "" : request.getParameter("confPass");
        if (message.equals(""))
            out.print("no confirmation<br>");
        else if(!request.getParameter("confPass").isEmpty()){
            if (registrationValidate.registrationValidate(request.getParameter("name"), request.getParameter("pass"),
                    request.getParameter("confPass"),request.getParameter("town"), request.getParameter("email"))) {

                query.createRegistration(request.getParameter("name"), request.getParameter("pass"), request.getParameter("email"),
                        request.getParameter("town"));
                message = "User create!";//TODO 2-step reg
            } else {
                message = registrationValidate.message;
            }
        }
            out.print(message);
    } catch (Exception e) {
        out.print("false " + e.toString() + "<br>" + request.getParameter("confPass"));
    }
%>

<form action="index.jsp" method="post">
    Логин: <input type="text" size="8" name="name"><br>
    Пароль: <input type="password" size="8" name="pass"><br>
    Повтор пароля: <input type="password" size="8" name="confPass"><br>
    email: <input type="email" size="8" name="email"><br>
    Город: <input type="text" size="8" name="town"><br>
    <input type="submit" value="Зарегистрировать">
</form>
</body>
</html>
