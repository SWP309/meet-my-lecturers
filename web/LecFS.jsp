
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            .card-body > div {
                margin-bottom: 0.2rem;
            }

            .card-body > .btn-book {
                margin-top: 1rem;
            }

            .form-group {
                margin: 0.4rem;
                border-radius: 35px;
            }

            .form-control {
                border-radius: 35px;
            }

            .cus {
                background-color: #f27125;
                margin: 0 0.5rem;
                border-radius: 5px;
                color: #fff!important;
            }

            .text-black {
                color: #333!important;
                font-size: 18px;
            }

            .navbar {
                padding: 2rem;
                border-bottom: 1px solid black;
            }

            @media screen and (max-width: 980px) {
                .cus {
                    background: none!important;
                    color: #333!important;
                }
            }
            th {
                text-align: center;
            }
            td {
                text-align: center;
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

            /* Tùy chỉnh màu nền khi hover */
            .table-rounded tbody tr:hover {
                background-color: #e0e0e0;
            }
            .frame-choice{
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


        <div class="container mt-5">
            <form action="MainController" method="POST">
<!--                <div class="row align-items-center">
                    <div class="form-group">
                        <input type="text" class="form-control " name="txtUserID" value="${param.txtUserID}" placeholder="UserID" pattern="^[A-Z]{2}[0-9]{4}+$">
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" type="submit" name="action" value="SearchDashBoardInfo">Search</button>
                    </div>
                </div>-->
            </form>
            <h1 class="text-center text-custom">Lecturer Free Slot Information</h1>
            <div class="row justify-content-center mt-5">
                <c:if test="${not empty requestScope.LECTURER_FS_INFO}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Free Slot ID</th>
                                <th>Lecturer ID</th>
                                <th>Subject Code</th>
                                <th>Capacity</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Semester ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.LECTURER_FS_INFO}" 
                                       var="freeslot" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${freeslot.freeSlotID}</td>
                                    <td>${freeslot.lecturerID}</td>
                                    <td>${freeslot.subjectCode}</td>
                                    <td>${freeslot.capacity}</td>
                                    <td>${freeslot.startTime}</td>
                                    <td>${freeslot.endTime}</td>
                                    <td>${freeslot.semesterID}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>        
        <!--        <div class="footer1">
                    <div class="powered-by-fpt-container1">
                        © Powered by
                        <a class="fpt-university2" href="http://fpt.edu.vn/" target="_blank">
                            <span class="fpt-university3">FPT University</span>
                        </a>
                        |
                        <a class="fpt-university2" href="http://library.fpt.edu.vn/" target="_blank">
                            <span class="fpt-university3">library</span>
                        </a>
                    </div>
                </div>-->
        <%} else {
                response.sendRedirect("MainController");
            }%>
        <!-- Thêm liên kết đến Bootstrap JS và jQuery -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
