<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 03/07/2023
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Result</title>
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
        }
    </style>
</head>
<body>
<h1>List of products related to the search string <span style="color: red;">${requestScope["searchStr"]}</span></h1>
<table>
    <thead>
    <th>Name</th>
    <th>Price</th>
    <th>Description</th>
    <th>Brand</th>
    </thead>
    <c:forEach items='${requestScope["products"]}' var="product">
        <tr>
            <td>${product.getName()}</td>
            <td>${product.getPrice()}</td>
            <td>${product.getDescription()}</td>
            <td>${product.getBrand()}</td>
        </tr>
    </c:forEach>
</table>
<p><a href="/ProductServlet">Back to Main Menu</a></p>
</body>
</html>
