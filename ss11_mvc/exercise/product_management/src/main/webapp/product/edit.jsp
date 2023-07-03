<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 03/07/2023
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
<h1>Do you want to edit the product below? </h1>
<form method="post" action="/ProductServlet?action=edit">
    <fieldset>
        <legend>Edit Product Information</legend>
        <table>
            <tr>
                <td>Id:</td>
                <td><input type="number" name="id" id="id" value="${requestScope["product"].getId()}"></td>
            </tr>
            <tr>
                <td>Name:</td>
                <td><input type="text" name="name" id="name" value="${requestScope["product"].getName()}"></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="number" name="price" id="price" value="${requestScope["product"].getPrice()}"></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="description" id="description" value="${requestScope["product"].getDescription()}"></td>
            </tr>
            <tr>
                <td>Brand</td>
                <td><input type="text" name="brand" id="brand" value="${requestScope["product"].getBrand()}"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Submit Edit Customer"></td>
            </tr>
        </table>
    </fieldset>
</form>

</body>
</html>
