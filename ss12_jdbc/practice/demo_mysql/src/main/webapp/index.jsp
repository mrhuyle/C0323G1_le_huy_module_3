<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<% String url = "http://localhost:8080/users";
    response.sendRedirect(url);
%>
</body>
</html>