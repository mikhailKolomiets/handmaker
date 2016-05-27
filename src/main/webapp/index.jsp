<%@ page import="java.util.Enumeration" %>
<%@ page import="resources.EnumFinder" %>
<%--
  Created by IntelliJ IDEA.
  User: Компик
  Date: 06.02.16
  Time: 12:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app>
<head>
    <title>Hand maker</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css">
    <script src="http://code.angularjs.org/1.1.4/angular.min.js"></script>
</head>
<body>
<%
    //String id = "  user id = ";
    String userId = "login";
    if (EnumFinder.find(session.getAttributeNames(), "idUser"))
        userId = Integer.valueOf(session.getAttribute("idUser").toString()) > 0 ? "ok" : "login";
    //out.print(session.getId() + " " + id);
    String sitePart = "main";

    if (EnumFinder.find(request.getParameterNames(), "codeAuth") || EnumFinder.find(request.getParameterNames(), "confPass"))
        sitePart = "reg";

    if (EnumFinder.find(request.getParameterNames(), "login") || EnumFinder.find(request.getParameterNames(), "logpass"))
        if (userId.equals("login"))
            sitePart = "enter";
%>
<div ng-click="sitePart = 'language'" ng-init="sitePart = '<%=sitePart%>'; id = '<%=userId%>>'" class="textSite"
     style="position:absolute;left:9%;top:4%;width:9%;">
    <strong>Язык</strong></div>
<div ng-click="sitePart = 'contacts'" class="textSite" style="position:absolute;left:19%;top:4%;width:9%;">
    <strong>Контакты</strong></div>
<div ng-click="sitePart = 'main'" class="textSite" style="position:absolute;left:29%;top:4%;width:9%;">
    <strong>Главная</strong></div>
<div ng-hide="id != 'login'" ng-click="sitePart = 'enter'" class="textSite"
     style="position:absolute;left:39%;top:4%;width:9%;">
    <strong>Вход</strong></div>

<div ng-hide="id = 'login'" ng-click="sitePart = 'userRoom'" class="textSite"
     style="position:absolute;left:39%;top:4%;width:9%;">
    <strong>Личный кабинет</strong></div>

<div ng-show="sitePart == 'contacts'" class="contentPage">
    <jsp:include page="pages/contact.jsp"></jsp:include>
</div>
<div ng-show="sitePart == 'main'" class="contentPage">
    <jsp:include page="pages/main.jsp"></jsp:include>
</div>
<div ng-show="sitePart == 'enter'">
    <div ng-click="sitePart = 'reg'" class="textSite" style="position:absolute;left:49%;top:4%;width:9%;">
        <strong>Регистрация</strong></div>
    <div class="contentPage">
        <jsp:include page="pages/welcome.jsp"></jsp:include>
    </div>
</div>
<div ng-show="sitePart == 'reg'" class="contentPage">
    <jsp:include page="pages/mainRegistration.jsp"></jsp:include>
</div>

<div class="textSite" style="position:absolute;left:3%;top: 98%;width:94%;font-size: 11px; padding:0;">
    Все права защищены. Рукодел 2016.
</div>
<hr class="footerLine">
<hr class="footerLine" style="top:100%;">
<img src="http://cdn1.savepice.ru/uploads/2016/5/27/2343655f7c74027fdfe891006f359741-full.png">
</body>
</html>
