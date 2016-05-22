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
There is registration!!!

<form action="pages/any.jsp" method="post">
  Логин: <input type="text" size="8" name="name"><br>
  Пароль: <input type="password" size="8" name="pass"><br>
  Повтор пароля: <input type="password" size="8" name="confPass"><br>
  email: <input type="email" size="8" name="email"><br>
  Город: <input type="text" size="8" name="town"><br>
  <input type="submit" value="Зарегистрировать">
</form>
</body>
</html>
