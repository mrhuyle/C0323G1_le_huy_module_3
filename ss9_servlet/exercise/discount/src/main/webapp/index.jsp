<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Discount</title>
</head>
<body>
<form action="/DiscountServlet" method="post">
    <table>
        <tr>
            <th colspan="2">Discount</th>
        </tr>
        <tr>
            <td>Product Description</td>
            <td><input type="text" name="description"></td>
        </tr>
        <tr>
            <td>List Price</td>
            <td><input type="number" name="price"></td>
        </tr>
        <tr>
            <td>Discount Percent</td>
            <td><input type="number" name="percent"></td>
        </tr>
    </table>
    <input type="submit" id="submit" value="Calculate">
</form>
</body>
</html>