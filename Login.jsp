<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Session Test</title>
</head>
<body>
    <%
        String username = (String) session.getAttribute("username");
        if (username == null) {
            out.println("Username is not set in the session.");
        } else {
            out.println("Username in session: " + username);
        }
    %>
</body>
</html>
