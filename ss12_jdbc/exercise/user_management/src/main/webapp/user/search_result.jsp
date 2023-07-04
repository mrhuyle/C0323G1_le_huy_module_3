<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 04/07/2023
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search By Country Result</title>
    <style>
        span {
            color: red;
        }
        table, tr, td, th {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 20px;
        }
    </style>
</head>
<body>
<h1>List of Users relate to the search content <span>${searchStr}</span></h1>
<table>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Email</th>
        <th>Country</th>
    </tr>
    <c:forEach items="${list}" var="user">
        <tr>
            <td>${user.getId()}</td>
            <td>${user.getName()}</td>
            <td>${user.getEmail()}</td>
            <td>${user.getCountry()}</td>
        </tr>
    </c:forEach>
</table>
<h2><a href="/users">Back to Main menu</a></h2>
</body>
</html>
