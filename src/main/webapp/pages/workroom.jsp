<%@ page import="resources.EnumFinder" %>
<%@ page import="controller.GaleryController" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="resources.GaleryItem" %>
<%@ page import="java.util.List" %>
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
<%
    GaleryController gk = new GaleryController();
    String userName = "Гость", result = "", photoPath = "";
    int userId = 0;
    if (EnumFinder.find(session.getAttributeNames(), "userName")) {
        userName = session.getAttribute("userName").toString();
        userId = Integer.valueOf(session.getAttribute("idUser").toString());
    }
%>
<%%>
<body>

<div ng-click="roomPart = 'profile'" ng-init="roomPart = 'profile'" class="textSite"
     style="position:absolute;left:80%;top:20%;width:19%;">
    <strong>Профиль <%=userName%>
    </strong></div>

<div ng-click="roomPart = 'add'" class="textSite"
     style="position:absolute;left:80%;top:30%;width:19%;">
    <strong>Добавить поделку</strong></div>

<div ng-click="roomPart = 'myWork'" class="textSite"
     style="position:absolute;left:80%;top:40%;width:19%;">
    <strong>Мои работы</strong></div>

<div ng-show="roomPart == 'profile'" class="workroomPage">
    {{roomPart}}
</div>

<div ng-show="roomPart == 'add'" class="workroomPage">
    <%
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                result = gk.savePhoto(request, Integer.valueOf(session.getAttribute("idUser").toString()));
            } catch (Exception e) {
                out.print(e.toString());
            }
    %>
    <div ng-init="roomPart = 'add'">
        <p><%=result%>
        </p>
    </div>
    <%
        }
    %>
    <form action="index.jsp" method="post" enctype="multipart/form-data">
        Имя изделия:<input type="text" maxlength="50" name="itemName" required=""><br>
        Категория: <input type="text" maxlength="50" name="itemCategory"><br>
        Основное фото(не более 500Mb): <input type="file" name="upfile"><br>
        Описание: <textarea rows="10" cols="35" name="itemDescription" maxlength="21000"></textarea><br>
        <input type="submit" value="Добавить изделие">
    </form>

</div>

<div ng-show="roomPart == 'myWork'" class="workroomPage">

    <a href="index.jsp">Обновer</a>
    <%
        List<GaleryItem> item = gk.getGalaryItem(userId);
        int size = item.size();
        if (size == 0) {
    %>
    <a>Работы еще не добавлены</a>
    <%
    } else {
    %>
    <table>
        <%
            for (; size > 0; size--) {
                photoPath = item.get(size - 1).getPath();
        %>
        <tr>
            <th style="text-align: left;"><strong><%=item.get(size - 1).getName()%>
            </strong></th>
            <th style="">
                <img src="galery_photos/<%=photoPath%>" height="15%" width="15%"></th>

            <th>
                <form action="index.jsp" method="post">

                    <input type="text" value="<%=item.get(size-1).getId()%>" name="deleteItem" hidden="">
                    <input type="submit" value="Удалить">
                </form>
            </th>
            <br></tr>
        <%
            }
        %>
    </table>
    <%
        }

    %>

    <%=size%>

</div>

<div>
    <hr class="vr">
</div>

</body>
</html>
