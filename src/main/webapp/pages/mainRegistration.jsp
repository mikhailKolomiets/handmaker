<%@ page import="mySQLController.Query" %>
<%@ page import="validation.RegistrationValidate" %>
<%@ page import="validation.MailSender" %>
<%@ page import="java.util.UUID" %>
<%@ page import="resources.EnumFinder" %>

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
    MailSender mailSender = new MailSender();

    try {
        String message = "", code;
        if (EnumFinder.find(request.getParameterNames(), "confPass")) {
            if (registrationValidate.registrationValidate(request.getParameter("name"), request.getParameter("pass"),
                    request.getParameter("confPass"), request.getParameter("town"), request.getParameter("email"))) {

                code = UUID.randomUUID().toString();
                mailSender.sendTo(request.getParameter("email"), "Регистрационный код РУКОДЕЛА",
                        "Ваш код для завершения регистрации: " + code + " " +
                                "Данные для входа на сайт: " +
                                "Логин: " + request.getParameter("name") +
                                "Пароль: " + request.getParameter("pass") + ".");

                if (mailSender.messageOb.equals("")) {
                    query.createRegistration(request.getParameter("name"), request.getParameter("pass"), request.getParameter("email"),
                            request.getParameter("town"), code);
                    message = "<p>На ваш email был отправлен код активации. Введите его пожалуйста в окне ниже.</p>";
                } else {
                    message = mailSender.messageOb;
                }
            } else {
                //mailSender.sendTo("mihail.kolomiets@gmail.com", "44", "dsa");
                message = registrationValidate.message;
            }
        }
        if (EnumFinder.find(request.getParameterNames(), "codeAuth")) {
            // message = "Code: " + request.getParameter("codeAuth") + " ID : "+ query.findByCode(request.getParameter("codeAuth"));
            //todo end registration
            if (query.createUser(request.getParameter("codeAuth")))
            {message = "Регистрация прошла успешно!";}
            else {
                message = "Неверный код!";
            }
        }


        out.print(message);
    } catch (Exception e) {
        out.print("Ошибка : <br>" + e.toString());//todo test mode
    }
%>

<form action="index.jsp" method="post">
    Логин: <input type="text" size="8" name="name" required=""><br>
    Пароль: <input type="password" size="8" name="pass"><br>
    Повтор пароля: <input type="password" size="8" name="confPass" required=""><br>
    email: <input type="email" size="8" name="email"><br>
    Город: <input type="text" size="8" name="town"><br>
    <input type="submit" value="Зарегистрировать">
</form>
<p>Или введите код, который пришел на email:</p>

<form action="index.jsp" method="post">
    <input type="text" size="20" name="codeAuth" required placeholder="">
    <input type="submit" value="Проверить код">
</form>
</body>
</html>
