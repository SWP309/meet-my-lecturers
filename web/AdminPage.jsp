<%-- 
    Document   : AdminPage
    Created on : Oct 24, 2023, 1:50:25 AM
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
        <link rel="stylesheet" href="./AdminHome.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">



        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
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
        </script>
        <style>
            .textDashBoard{
                font-family: 'Agbalumo', 'Playfair Display', sans-serif;
            }
        </style>

        <title>Dashboard</title>
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
                            <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div import" onclick="submitFormImport()">
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

        <div class="container mt-4">
            <h1 class="text-center textDashBoard">Dashboard</h1>
            <form action="MainController" method="POST">
                <div class="d-flex justify-content-between mt-2">
                    <input type="hidden" value="Find" name="action"/>
                    <input type="text" name="txtsemester" class="form-control mx-auto" placeholder="E.g FA23">
                    <button type="submit" value="Find" class="btn btn-primary float-right">Find</button>
                </div>
            </form>
            <p class="text-danger text-center mt-2">${requestScope.MSG}</p>
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên <span style="color: red" >ĐẶT NHIỀU SLOT NHẤT</span></h5>                              
                            </div>                            
                            <p class="mt-2">Số lượt đặt: <b style="color: red">${requestScope.UserMaxSlot.number}</b></p>
                            <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxSlot.userID}</b></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên GỬI <span style="color: red" >NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.UserMaxRequest.number}</b></p>
                            <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxRequest.userID}</b></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên <span style="color: red" >TẠO NHIỀU SLOT NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt tạo slot: <b style="color: red">${requestScope.LecturerMaxSlot.number}</b></p>
                            <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxSlot.userID}</b></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên <span style="color: red" >NHẬN ĐƯỢC NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.LecturerMaxRequest.number}</b></p>
                            <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxRequest.userID}</b></p>
                        </div>
                    </div>
                </div>
            </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <%            } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
