<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 03/07/2023
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Product</title>
</head>
<body>
<h1>Details of the product:</h1>
<table>
  <tr>
    <td>Name:</td>
    <td>${requestScope["product"].getName()}</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>${requestScope["product"].getPrice()}</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>${requestScope["product"].getDescription()}</td>
  </tr>
  <tr>
    <td>Brand</td>
    <td>${requestScope["product"].getBrand()}</td>
  </tr>
</table>
<p>
  <a href="/ProductServlet">Back to main menu</a>
</p>
</body>
</html>
