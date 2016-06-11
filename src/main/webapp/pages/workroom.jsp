<%@ page import="resources.EnumFinder" %>
<%@ page import="controller.GaleryController" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%--
  Created by IntelliJ IDEA.
  User: mihail
  Date: 27.05.16
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Hand maker</title>
  <link rel="stylesheet" href="../styles/main.css" type="text/css">

</head>
<%String userName = "Гость", result ="";
  if(EnumFinder.find(session.getAttributeNames(), "userName"))
      userName = session.getAttribute("userName").toString();
%>
<%%>
<body>

<div ng-click="roomPart = 'profile'" ng-init="roomPart = 'profile'" class="textSite"
     style="position:absolute;left:80%;top:20%;width:19%;">
  <strong>Профиль <%=userName%></strong></div>

<div ng-click="roomPart = 'add'" class="textSite"
     style="position:absolute;left:80%;top:30%;width:19%;">
  <strong>Добавить поделку</strong></div>

<div ng-click="roomPart = 'MyWork'" class="textSite"
     style="position:absolute;left:80%;top:40%;width:19%;">
  <strong>Мои работы</strong></div>

<div ng-show="roomPart == 'profile'"class="workroomPage">
{{roomPart}}
  </div>

<div ng-show="roomPart == 'add'"class="workroomPage">
  <%if(ServletFileUpload.isMultipartContent(request)) {
    try {
      GaleryController gk = new GaleryController();
      result = gk.savePhoto(request);
    } catch (Exception e) {
      out.print(e.toString());}
      %>
  <div ng-init="roomPart = 'add'">
    <p><%=result%></p>
  </div>
  <%
  }
  %>
  <form action = "index.jsp" method="post" enctype="multipart/form-data">
    Имя изделия:<input type="text" maxlength="50" name="itemName" required=""><br>
    Категория: <input type="text" maxlength="50" name="itemCategory"><br>
    Основное фото(не более 500Mb): <input type="file" name="upfile"><br>
    Описание: <textarea rows="10" cols="35" name="itemDescription" maxlength="21000"></textarea><br>
    <input type="submit" value="Добавить изделие">
  </form>

</div>

<div ng-show="roomPart == 'myWork'"class="workroomPage">
  {{roomPart}}
</div>

<div>
  <hr class="vr">
</div>

</body>
</html>
