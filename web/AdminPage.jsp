<%-- 
    Document   : adminPage
    Created on : Oct 7, 2023, 12:06:47 AM
    Author     : Minh Khang
--%>

<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                System.out.println(us.getUserEmail());
        %>
        <h2>Welcome <%= us.getUserEmail()%></h2>
        <%
            } else {
                response.sendRedirect("MainController");
            }
        %>
    </body>
</html>
