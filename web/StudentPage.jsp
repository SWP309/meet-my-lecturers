<%-- 
    Document   : studentPage
    Created on : Oct 9, 2023, 11:23:03 PM
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
        <h2>Welcome to student Page <%= us.getUserEmail()%></h2>
        <%
            } else {
                response.sendRedirect("MainController");
            }
        %>
    </body>
</html>
