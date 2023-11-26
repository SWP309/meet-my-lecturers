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

        <link rel="stylesheet" href="./LecturerPage.css" />
        <link rel="stylesheet" href="./LecturerHome.css" />
        <script src="./lecturer.js"></script>


        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Lohit Tamil:wght@400&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
            />
        <!-- CSS c?a Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- CSS c?a Bootstrap 4 -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

        <!-- Icon -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- CSS c?a SweetAlert -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- JavaScript c?a Bootstrap 4 -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

        <!-- JavaScript c?a Bootstrap 5 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <!-- JavaScript c?a SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <!--        animation --------------->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>


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
            function myFunctionDropdown() {
                var dropdown = document.getElementById("myDropdown");
                dropdown.classList.toggle("show");

                if (dropdown.classList.contains('show')) {
                    dropdown.style.display = "flex";
                    setTimeout(function () {
                        dropdown.style.opacity = 1;
                        dropdown.style.transform = "scaleY(1)";
                    }, 10);
                } else {
                    dropdown.style.opacity = 0;
                    dropdown.style.transform = "scaleY(0)";
                    setTimeout(function () {
                        dropdown.style.display = "none";
                    }, 400);
                }
            }
        </script>
    </head>
    <div class="fptu-eng-1-parent">
        <div class="returnHome"> 
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="returnHomePageStudent" />
            </form>
        </div>
        <div class="frame-parent">

            <div>
                <img class="frame-item" alt="" style="cursor: pointer" src="public/BookingView/group-33.svg" 
                     onclick="showUserInfo()" />
                <div id="user-info" style="display: none; position: absolute">
                    <p id="user-id"> </p>
                    <p id="user-name"></p>
                    <p id="user-email"></p>
                </div>
            </div>
            <div class="dropdown">
                <button onclick="myFunctionDropdown()" class="dropbtn"> 
                    <i class="fa fa-caret-down"></i>
                </button>
                <div id="myDropdown" class="dropdown-content" style="right: 0px;
                     flex-direction: column;
                     ">
                    <div class="frame-div logout" onclick="submitFormLogout()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="Logout" />
                        </form>
                        <i class="material-icons">logout</i> Logout
                    </div>
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
