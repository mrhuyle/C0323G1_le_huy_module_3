<%--
  Created by IntelliJ IDEA.
  User: lehuy
  Date: 01/07/2023
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Result</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<h1>Calculator Result</h1>
<c:if test="${not empty error}">
    <h1>${error}</h1>
</c:if>
<c:if test="${empty error}">
    <h1>The result is: <c:out value="${str}"/></h1>
</c:if>
</body>
</html>
