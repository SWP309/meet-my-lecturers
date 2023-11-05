<%-- 
    Document   : ChangePassword
    Created on : Nov 3, 2023, 9:51:52 PM
    Author     : Minh Khang
--%>

<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thay đổi mật khẩu</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <meta charset="UTF-8">
        <style>
            .form-control{
                border-radius: 40px;
                width: 30%;
            }
            .btn{
                border-radius: 40px;

            }
        </style>
    </head>
    <body>
        <%                   
            String CHANGEPASS = (String) request.getAttribute("CHANGEPASS");
            String FAILPASS = (String) request.getAttribute("FAILPASS");
            String DEFAULTPASS = (String) request.getAttribute("DEFAULTPASS");
            String CONFIRMPASS = (String) request.getAttribute("CONFIRMPASS");
        %>
        <div class="container">
            <h1 class="mt-5" style="color: #f27125">Change password</h1>
            <%
                if (CHANGEPASS != null) {
            %>
            <b style="color: red; font-size: 1rem;">
                <%= CHANGEPASS%>
            </b>
            <%
                }
            %>

            <%
                if (FAILPASS != null) {
            %>
            <b style="color: red; font-size: 1rem;">
                <%= FAILPASS%>
            </b>
            <%
                }
            %>

            <form action="MainController" method="POST">
                <div class="form-group">
                    <label for="old_password">Default password</label>
                    <%
                        if (DEFAULTPASS != null) {
                    %>
                    <b style="color: red; font-size: 1rem;">
                        <%= DEFAULTPASS%>
                    </b>
                    <%
                        }
                    %>
                    <input type="password" class="form-control" id="old_password" name="txtdefault">
                </div>
                <div class="form-group">
                    <label for="new_password">New password</label>
                    <input type="password" class="form-control" id="new_password" name="txtnewpass">
                </div>
                <div class="form-group">
                    <label for="confirm_password">Confirm new password</label>
                    <%
                        if (CONFIRMPASS != null) {
                    %>
                    <b style="color: red; font-size: 1rem;">
                        <%= CONFIRMPASS%>
                    </b>
                    <%
                        }
                    %>
                    <input type="password" class="form-control" id="confirm_password" name="txtconfirmpass">
                </div>
                <button type="submit" name="action" value="changePassServlet" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </body>
</html>
