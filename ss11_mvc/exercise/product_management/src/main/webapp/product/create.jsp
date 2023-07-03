<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 03/07/2023
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
</head>
<body>
<form method="post" action="/ProductServlet?action=create">
    <fieldset>
        <legend>Information of New Product</legend>
        <table>
            <tr>
                <td>Id</td>
                <td><input type="number" name="id" id="id"></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><input type="text" name="name" id="name"></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="number" name="price" id="price"></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="description" id="description"></td>
            </tr>
            <tr>
                <td>Brand</td>
                <td><input type="text" name="brand" id="brand"></td>
            </tr>
            <tr>
                <td colspan=2><input style="font-size: 15px; color: red" type="submit" value="Create new Product"></td>
            </tr>
        </table>
    </fieldset>
</form>
<p>
    <a href="/ProductServlet">Back to product list</a>
</p>
</body>
</html>
