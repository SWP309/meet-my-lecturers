<%-- 
    Document   : ChangePassword
    Created on : Nov 3, 2023, 9:51:52 PM
    Author     : Minh Khang
--%>

<%@page import="sample.users.UserDTO"%>
<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thay đổi mật khẩu</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <meta charset="UTF-8">
        <!-- Material Icons CSS -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>

        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>

        <style>
            .form-control{
                border-radius: 40px;
                width: 30%;
            }
            .btn{
                border-radius: 40px;

            }
            .returnHome{
                /*position: absolute;*/
                width: 120px;
                height: 50px;
                background-repeat: no-repeat;
                background-size: 100%;
                background-image: url("public/BookingView/2021fptueng-1@2x.png");
            }
            .frame-group, .frame-div{
                display: flex;
                flex-direction: row;
                justify-content: center;
            }
            .logout{
                width: 170px !important;
            }
            .frame-item {
                margin-left: 44px;
                cursor: pointer; /* Hiển thị con trỏ chuột khi di chuột qua */
                position: relative;
                width: 45px;
                height: 42px;
            }
            .frame-parent {
                display: flex;
                flex-direction: row;
            }
            .fptu-eng-1-parent {
                position: relative;
                background-color: rgba(0, 0, 0, 0.125);
                border-top: 1px solid #000;
                border-bottom: 1px solid #000;
                box-sizing: border-box;
                width: 100%;
                min-height: 68px;
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: space-between;
                /*padding: 35px 40px;*/
                padding-left: 35px;
                font-size: 17px;
                color: #fff;

                flex-wrap: wrap;
            }
            #user-id, #user-name, #user-email {
                color: black; /* Đặt màu chữ thành màu đen */
            }
            .div {
                position: relative;
            }
            .frame-div {
                cursor: pointer; /* Hiển thị con trỏ chuột khi di chuột qua */
                border-radius: 12px;
                background-color: #f27125;
                width: 213px;
                height: 43px;
                /*align-items: flex-start;*/
                padding: 10px 9px;
                box-sizing: border-box;
                gap: 8px;
                justify-content: center;
            }
            .frame-group {
                gap: 3px;
                flex-wrap: wrap;
            }
            .frame-History{
                border-radius: 20px;
                background-color: #f27125;
                width: 40px !important;
                height: 40px;
                align-items: center;
                padding: 10px 9px;
                box-sizing: border-box;
                /* gap: 0px; */
                display: flex;
                flex-direction: row;
                justify-content: center;
                float: right;
                margin-top: 15px;
                margin-right: 20px;
            }
        </style>
        <script>
            var userDTO = {
                userID: "<%= us.getUserID()%>",
                userName: "<%= us.getUserName()%>",
                userEmail: "<%= us.getUserEmail()%>"
            };
            function showUserInfo() {
                var userInfo = document.getElementById("user-info");
                if (userInfo.style.display === "none" || userInfo.style.display === "") {
                    userInfo.style.display = "block"; // Hi?n th? thông tin khi ???c nh?p chu?t
                } else {
                    userInfo.style.display = "none";
                }

                var userID = userDTO.userID;
                var userName = userDTO.userName;
                var userEmail = userDTO.userEmail;

                Swal.fire({
                    title: 'User Information',
                    html: '<b style="color: red;">User ID: </b>' + userID + '<br><b style="color: red;">User Name: </b>'
                            + userName + '<br><b style="color: red;">User Email: </b>' + userEmail,
                });
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
        </script>
    </head>
    <div class="fptu-eng-1-parent">
        <div class="returnHome"> 
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="CheckStatusUser" />
            </form>
        </div>
        <div class="frame-parent"> 
            <div class="frame-div logout" onclick="submitFormLogout()" style="width: 10%; text-align: center">
                <form action="MainController" method="POST" style="display: none;">
                    <input type="hidden" name="action" value="Logout" />
                </form>
                <i class="material-icons">logout</i> Logout
            </div>
            <div>
                <img class="frame-item" alt="" style="cursor: pointer" src="public/BookingView/group-33.svg" 
                     onclick="showUserInfo()" />
                <div id="user-info" style="display: none; position: absolute">
                    <p id="user-id"> </p>
                    <p id="user-name"></p>
                    <p id="user-email"></p>
                </div>
            </div>

        </div>
    </div>
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
        <% } else {
                response.sendRedirect("MainController?action=");
            }

        %>
    </body>
</html>
