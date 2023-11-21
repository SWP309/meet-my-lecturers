<%-- 
    Document   : index
    Created on : Oct 28, 2023, 1:20:11 AM
    Author     : Minh Khang
--%>
<%@page import="sample.adminView.ViewBookedSlotAdminDTO"%>
<%@page import="sample.subjects.SubjectDTO"%>
<%@page import="sample.subjects.SubjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.roles.RoleDAO"%>
<%@page import="sample.roles.RoleDTO"%>
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
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <!--        text gg -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
        <title>File Upload</title>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                ArrayList<ViewBookedSlotAdminDTO> listSlot = (ArrayList<ViewBookedSlotAdminDTO>) request.getAttribute("listSlot");
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
            function submitFormAddData() {
                var form = document.querySelector('.AdminAddData form');
                form.submit();
            }
            function submitFormViewSlots() {
                var form = document.querySelector('.AdminViewSlot form');
                form.submit();
            }
            function submitFormImport() {
                var form = document.querySelector('.import form');
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
            function submitAddForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "add"; // Set the option value for the "Add" button
                form.submit();
            }

            function submitRemoveForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "remove"; // Set the option value for the "Remove" button
                form.submit();
            }

            function submitUpdateForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "update"; // Set the option value for the "Update" button
                form.submit();
            }
          function myFunction() {
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

        <style>


            .btn-primary{
                border-color: black;
            }
            #remove{
                background-color: #F27125;
            }
            #add{
                background-color: #0066B2;
            }
            #update{
                background-color: #0DB04B;
            }
            .table-container {
                display: flex;
                justify-content: center;
                margin: auto;
                margin-top: 5%;
            }
            .table-rounded th,
            .table-rounded td {
                padding: 8px;
                border: 1px solid black;
                text-align: center;
            }

            .table-rounded thead {
                background-color: #f27125;
                color: white;
            }
            .table-rounded{
                width: 100%;
                transform: scale(0.95); /* Tỉ lệ thu nhỏ bảng là 80% */
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
                    <button onclick="myFunction()" class="dropbtn"> 
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div id="myDropdown" class="dropdown-content" style="right: 0px;
                         flex-direction: column; z-index: 10;
                         ">
                        <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewUsers" />
                            </form>
                            <i class="material-icons">event</i>
                            <div class="view-booking" >Search Users</div>
                        </div>
                        <div class="frame-div request import" onclick="submitFormImport()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="importPage" />
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
                                <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zm-1 4v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0z"/>
                                </svg>
                            </form>
                            Import Schedule
                        </div>
                        <div class="frame-div AdminAddData" onclick="submitFormAddData()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="AdminAddData" />
                                <i class="material-icons">add</i> 
                            </form>
                            Add data page
                        </div>
                        <div class="frame-div AdminViewSlot" style="background-color: #b7b7b7;">
                            <form action="MainController" method="POST" style="display: none">
                                <input type="hidden" name="action" value="AdminViewSlot" />
                            </form>
                            <i class="fas fa-users-cog"></i>
                            Manage slot page
                        </div>
                        <div class="frame-div logout" onclick="submitFormLogout()" >
                            <form action="MainController" method="POST" style="display: none">
                                <input type="hidden" name="action" value="Logout" />
                            </form>
                            <i class="material-icons">logout</i> Logout
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h1 class="text-center text-custom">Manage Slots</h1>
        <div class="container mt-5">

            <div class="row align-items-center justify-content-center">

                <form action="MainController" method="POST" class="d-flex justify-content-center" style=" margin-top: 10%;">
                    <div class="form-group">
                        <input type="datetime-local" class="form-control" name="txtStartTime" required>
                    </div>
                    <div class="form-group">
                        <input type="datetime-local" class="form-control" name="txtEndTime" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="txtUser" placeholder="User ( SE171435)" required>
                    </div>
                    <div class="form-group">
                        <select name="txtRole" class="form-control" required>
                            <option value="2">Slots created by Lecturer</option>
                            <option value="3">Slots booked by Student</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchSlot">Search</button>
                    </div> <br>
                </form>

            </div>
            <%
                if (listSlot != null) {
            %>

        </div> 
        <div class="view-user-table" style="width: 100%; margin: 0 auto; border-radius: 20px;">
            <div class="table-container">
                <table class="custom-table table-hover table-primary table-rounded">
                    <tr style="background-color: tomato">
                        <th>Lecturer ID</th>
                        <th>Student ID</th>
                        <th>Subject Code</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Slot ID</th>
                        <th>Meet Link</th>
                    </tr>
                    <%
                        for (ViewBookedSlotAdminDTO slot : listSlot) {
                    %>
                    <tr>
                        <td><%= slot.getLecturerID()%></td>
                        <td><%= slot.getStudentID()%></td>
                        <td><%= slot.getSubjectCode()%></td>
                        <td><%= slot.getStartTime()%></td>
                        <td><%= slot.getEndTime()%></td>
                        <td><%= slot.getFreeSlotID()%></td>
                        <td><%= slot.getMeetLink()%></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
        <%
            }
        %>

        <div id="customAlert">
            <div id="alertContent">
                <!-- N?i dung c?nh báo s? ???c thêm vào ?ây -->
            </div>
            <button class="closeButton">X</button>
        </div>
        <style>
            #customAlert {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                border-radius: 4px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                padding: 28px;
                font-family: Arial, sans-serif;
                font-size: 18px;
                text-align: center;
                z-index: 9999;
                width: 36%;
                color: red;
                font-weight: bold;
            }
            #alertContent{
                font-family: 'Oswald','Playpen Sans';
                padding: 20px;
            }
            .closeButton {
                padding: 4px 4px;
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
                font-weight: bold;
                border: none;
            }
            .closeButton:hover{
                opacity: 0.5;
            }

            #alertContent {
                /* N?u b?n mu?n tu? ch?nh ki?u ch? và màu s?c, hãy ?i?u ch?nh ?o?n CSS này */
            }
        </style>
        <script>
            var errorMessage = "${requestScope.Error}";

            // Ki?m tra n?u errorMessage không r?ng, hi?n th? thông báo c?nh báo
            if (errorMessage.trim() !== "") {
                showAlert(errorMessage);
            }

            // Hàm ?? hi?n th? thông báo tùy ch?nh
            function showAlert(message) {
                var alertDiv = document.getElementById("customAlert");
                var alertContentDiv = document.getElementById("alertContent");
                alertContentDiv.textContent = message;
                alertDiv.style.display = "block";
                var closeButton = alertDiv.querySelector(".closeButton");
                closeButton.addEventListener("click", function () {
                    alertDiv.style.display = "none";
                });
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
