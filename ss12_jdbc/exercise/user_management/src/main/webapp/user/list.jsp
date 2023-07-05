<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 04/07/2023
  Time: 20:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Management Application</title>
    <style>
        input {
            font-size: 20px;
            font-weight: bold;
            color: blue;
        }
    </style>
</head>
<body>
<center>
    <h1>User Management</h1>
    <fieldset>
        <legend>Function</legend>
        <h2>
            <a href="/users?action=create">Create New User</a>
        </h2>
        <h2>
            <form action="/users?action=search" method="post">
                <input type="text" name="searchStr" id="searchStr" placeholder="Search By Country">
                <input type="submit" value="Search By Country">
            </form>
        </h2>
        <c:choose>
            <c:when test="${restore == null}">
                <h2>
                    <a href="/users?action=sort">Sort By Name (Ascending)</a>
                </h2>
            </c:when>
            <c:otherwise>
                <h2>
                    <a href="/users">${restore}</a>
                </h2>
            </c:otherwise>
        </c:choose>

    </fieldset>
</center>
<div align="center">
    <table border="1" cellpadding="5">
        <caption><h2>List of Users</h2></caption>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Country</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="user" items="${listUser}">
            <tr>
                <td><c:out value="${user.getId()}"/></td>
                <td><c:out value="${user.getName()}"/></td>
                <td><c:out value="${user.getEmail()}"/></td>
                <td><c:out value="${user.getCountry()}"/></td>
                <td>
                    <a href="/users?action=edit&id=${user.getId()}">Edit</a>
                    <a href="/users?action=delete&id=${user.getId()}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
