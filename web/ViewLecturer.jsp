<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./ViewLecturer.css" />
        <link rel="stylesheet" href="./LecturerHome.css" />
        <script src="./student.js"></script>
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
        <!--        text gg -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
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
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" onclick="submitFormHomePage()"> 
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
                    <button onclick="myFunction()" class="dropbtn"> 
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div id="myDropdown" class="dropdown-content" style="right: 0px;
                         flex-direction: column;
                         ">
                        <div class="frame-div returnHomeDiv" onclick="submitFormHomePageDiv()"> 
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="returnHomePageStudent" />
                                <i class="material-icons">home</i>
                            </form>
                            Home
                        </div>
                        <div class="frame-div bookingview" onclick="submitForm()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewBooking" />
                            </form>
                            <i class="material-icons">event</i>View Booked Slots
                        </div>
                        <div class="frame-div requestViewStatus" style=" cursor: pointer" onclick="submitFormRequestStatus()" id="booking-view-div">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewRequestStatus" />
                            </form>
                            <i class="material-icons">visibility</i>View Request Status
                        </div>
                        <div class="frame-div request" onclick="submitFormRequest()">
                            <form style="display: flex; justify-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                                <i class="material-icons">mail_outline</i>
                            </form>
                            Request
                        </div>
                        <div class="frame-div viewLecturer" style="background-color: #b7b7b7;">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewAllLecturers" />
                                <i class="fas fa-search"></i>
                            </form>
                            View Lecturer
                        </div>
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
        <div class="student-lectures-schedule-edi">

            <div class="frame-choice history" style="cursor: pointer; color: white" onclick="submitFormHistory()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="attendanceSemes" />
                </form>

                <i class="material-icons">history</i>
            </div>

            <h1 class="text-center text-custom">Table of Lecturer</h1>

            <div id="fh5co-staff">
                <div class="container">
                    <div class="row">
                        <c:if test="${not empty requestScope.LIST_LECTURERS}">
                            <c:forEach items="${requestScope.LIST_LECTURERS}" 
                                       var="lecturer" varStatus="status">
                                <div class="col-md-3 animate-box text-center">
                                    <div class="staff">
                                        <div class="staff-img" style="background-image: url(./public/StudentHome/User-avatar.png);">
                                            <ul class="fh5co-social" style="display: flex;
                                                align-items: center;
                                                justify-content: center;">
                                                <li><a href="https://www.facebook.com/lam.cat.77770/"><i class="material-icons">facebook</i></a></li>
                                                <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                                <li><a href="#"><i class="material-icons">phone</i></a></li>
                                                <li><a href="#"><i class="fa fa-globe"></i></a></li>
                                            </ul>
                                        </div>
                                        <span>${lecturer.userID}</span>
                                        <h3>${lecturer.userName}</h3>
                                        <p>${lecturer.userEmail}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="footer1">
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
            </div>
        </div>
        <script>
            // L?y thông tin l?i t? bi?n requestScope.ERROR
            var errorMessage = "${requestScope.MESSAGE}";

            // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
            if (errorMessage.trim() !== "") {
                alert(errorMessage);
            }
        </script>

        <%
            } else {
                response.sendRedirect("MainController");
            }
        %>
    </body>
</html>
