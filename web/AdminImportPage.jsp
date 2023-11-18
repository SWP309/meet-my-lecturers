<%-- 
    Document   : index
    Created on : Oct 28, 2023, 1:20:11 AM
    Author     : Minh Khang
--%>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">-->
        <link rel="stylesheet" href="./AdminHome.css">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>File Upload</title>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormViewUsers() {
                var form = document.querySelector('.ViewUsers form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
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
        </script>

        <style>
            .custom-submit-button {
                background-color: #f27125; /* Màu xanh */
                color: #fff; /* Màu chữ trắng */
                /* Các thuộc tính CSS khác tùy ý */
            }
            .custom-submit-button:hover{
                background-color: #b05b18;
            }
        </style>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageAdmin" />
                </form>
            </div>

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewUsers" />
                        </form>
                        <div class="bookedslot-wrapper">
                             <i class="material-icons">event</i>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div request import"  style="background-color: #b7b7b7;">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="importPage" />
                        </form>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
                        <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zm-1 4v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0z"/>
                        </svg>
                        Import Schedule
                    </div>
                    <div class="frame-div logout" onclick="submitFormLogout()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="Logout" />
                        </form>
                        <div class="logout-wrapper">
                             <i class="material-icons">logout</i>
                        </div>
                        <div class="request">
                            <p class="logout1">Logout</p>
                        </div>
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
        </div>
        <div class="container mt-5">
            <h1 class="text-center">Import form excel</h1>
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="padding-right: 100px; display: inline-block">
                    Import List Student
                </div>
                <%                    String EXCSERVLET = (String) request.getAttribute("EXCSERVLET");
                    
                    if (EXCSERVLET != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= EXCSERVLET%>
                </span>
                <%
                    }
                %>
                <a href="https://drive.google.com/drive/folders/195tJBz5ZndD9dh9Lvdw3K1SH_dh8ACnZ?usp=sharing" target="_blank" style="color: blueviolet">Download template</a>
                <div class="form-group input-group">
                    <div class="custom-file">
                        <input type="file" name="txtexcel" class="custom-file-input" id="imageUpload"  onchange="updateFileName('imageUpload')" required>
                        <label class="custom-file-label" for="imageUpload">Choose file</label>
                    </div>
                    <div class="input-group-append">
                        <input type="hidden" name="action" value="importST">
                        <button type="submit" value="importST" name="action" class="btn btn-primary custom-submit-button">Submit</button>
                    </div>
                </div>
            </form>
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="padding-right: 100px; display: inline-block">
                    Import list subject
                </div>
                <%    
                    String TIMESERVLET = (String) request.getAttribute("TIMESERVLET");
                    String DUPLICATEDATA = (String) request.getAttribute("DUPLICATEDATA");
                    String DUPLICATEDATATIMETABLE = (String) request.getAttribute("DUPLICATEDATATIMETABLE");
                    
                    if (TIMESERVLET != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= TIMESERVLET%>
                </span>
                <%
                    }
                %>
                <a href="https://drive.google.com/drive/folders/1s_yu8ElI5rP6RaON6SLxFOIN5kmEUh4D?usp=drive_link" target="_blank" style="color: blueviolet">Download template</a>
                <div class="form-group input-group">
                    <div class="custom-file">
                        <input type="hidden" value="importTB" name="action">
                        <input type="file" name="txtexcel" class="custom-file-input" id="DSSV"  onchange="updateFileName('DSSV')" required>
                        <label class="custom-file-label">Choose file</label>
                    </div>                    
                    <div class="input-group-append">
                        <button type="submit" value="importSJ" name="action" class="btn btn-primary custom-submit-button">Submit</button>
                    </div>
                </div>
            </form>
                <a href="AdminAddData.jsp">hello</a>
        </div>
        <script>
            function updateFileName(inputId) {
                const input = document.getElementById(inputId);
                const fileName = input.value.split('\\').pop();
                input.nextElementSibling.innerHTML = fileName;
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <%
            } else {
                response.sendRedirect("MainController?action=");
            }            
        %>
    </body>
</html>
