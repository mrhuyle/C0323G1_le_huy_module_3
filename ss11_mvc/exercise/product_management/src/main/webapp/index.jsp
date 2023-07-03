<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<%
    String redirectURL = "http://localhost:8080/ProductServlet";
    response.sendRedirect(redirectURL);
%>
</body>
</html>