<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 01/07/2023
  Time: 09:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display list</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        table, tr, td {
            border: 1px solid red;
            border-collapse: collapse;
            margin: 15px;
            padding: 15px;
            text-align: center;
        }

        img {
            width: 7rem;
            height: auto;
        }
    </style>
</head>
<body>
<table>
    <tr>
        <th colspan="4">Danh sách khách hàng</th>
    </tr>
    <tr>
        <td>Tên</td>
        <td>Ngày sinh</td>
        <td>Địa chỉ</td>
        <td>Ảnh</td>
    </tr>
    <c:forEach var="customer" items="${customers}" varStatus="loop">
        <tr>
            <td><c:out value="${customer.name}"/></td>
            <td><c:out value="${customer.dob}"/></td>
            <td><c:out value="${customer.add}"/></td>
            <td><img src="${customer.img}" alt="Customer Image"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
