<%-- 
    Document   : loginFeID
    Created on : Oct 7, 2023, 9:52:35 PM
    Author     : Minh Khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="MainController" method="post">
            <input type="hidden" value="loginFeIDAction" name="action"/>
            <p><input type="text" name="txtemail" placeholder="enter email" required=""/>*</p>
            <p><input type="password" name="txtpassword" placeholder="enter password" required=""/>*</p>
            <p><input type="submit" value="login"/></p>
        </form>
        <%
            String msg =(String) request.getAttribute("Error");
            if (msg != null) {
        %>
            <h2 style="color:red"><%=    msg  %></h2>
        <%
            }
        %>
    </body>
</html>
