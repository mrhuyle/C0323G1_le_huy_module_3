<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 03/07/2023
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display list of products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin-left: 20px;
        }
        table, tr, td, th {
            border: 2px solid blue;
            padding: 5px;
            text-align: center;
            border-collapse: collapse;
        }

        h1 {
            text-align: left;
            color: red;
        }
    </style>
</head>
<body>
<h1>List of Products</h1>
<h1><a href="/ProductServlet?action=create" class="btn btn-primary">Create new Product</a></h1>
<form action="/ProductServlet?action=search" method="post">
    <input type="text" name="searchStr" id="searchStr" placeholder="Search By Name">
    <input type="submit" value="Search By Name" class="btn btn-danger">
</form>
<table>
    <thead>
    <th>Name</th>
    <th>Price</th>
    <th>Description</th>
    <th>Brand</th>
    <th>Edit</th>
    <th>Delete</th>
    <th>View</th>
    </thead>
    <c:forEach items='${requestScope["productList"]}' var="product">
        <tr>
            <td>${product.getName()}</td>
            <td>${product.getPrice()}</td>
            <td>${product.getDescription()}</td>
            <td>${product.getBrand()}</td>
            <td><a href="/ProductServlet?action=edit&id=${product.getId()}" class="btn btn-primary">Edit</a></td>
            <td><a href="/ProductServlet?action=delete&id=${product.getId()}" class="btn btn-danger">Delete</a></td>
            <td><a href="/ProductServlet?action=view&id=${product.getId()}" class="btn btn-info">View</a></td>
        </tr>
    </c:forEach>
</table>
<p style="color: red; font-weight: bold">
    <c:if test="${msg != null}">
        <c:out value="${msg}"/>
    </c:if>
</p>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
