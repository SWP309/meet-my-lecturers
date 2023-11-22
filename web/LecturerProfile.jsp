

<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./LecturerPage.css" />
        <link rel="stylesheet" href="./style.css">
        <link rel="stylesheet" href="./slick.css">
        <script src="./lecturer.js"></script>
        <title>Lecturer Profile</title>
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
            $(document).ready(function () {


                /* Navigation burger onclick side navigation show */
                $('.burger-container').on('click', function () {
                    $('.main-navigation').toggle('slow');
                    if ($('#myBtn').hasClass('change')) {
                        $('body').addClass('stop-scroll');
                    } else {
                        $('body').removeClass('stop-scroll');
                    }
                });
            });


        </script>
        <style>
            .table-rounded th,
            .table-rounded td {
                border: 1px solid black;
                text-align: center;
            }

            .table-rounded thead {
                background-color: #f27125;
            }
            .table-rounded{
                width: 100%;
            }
            /* Tùy chỉnh màu nền khi hover */
            .table-rounded tbody tr:hover {
                background-color: #e0e0e0;
            }
            .table-rounded tbody tr{
                background-color: white;
            }
            .delete{
                background-color: #dc3535;
                cursor: pointer;
                font-weight: bold;
            }
            .delete:hover{
                opacity: 0.5;
            }

        </style>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageLecturer" />
                </form>
            </div>
            <div class="frame-parent">
                <!-- Navigation -->
                <nav class="site-navigation">
                    <div class="site-navigation-inner site-container">
                        <div class="main-navigation">
                            <ul class="main-navigation__ul">
                                <li class="frame-choice" onclick="submitFormHomePage()"> 
                                    <form action="MainController" method="POST">
                                        <input type="hidden" name="action" value="returnHomePageLecturer" />
                                    </form>
                                    <i class="material-icons">home</i>Home Page
                                </li>
                                <li class="frame-choice CreateFSlot" onclick="submitFormCreate()" title="Create free slots">
                                    <form action="MainController" method="POST">
                                        <input type="hidden" name="action" value="CreateFS" />
                                    </form>
                                    <i class="material-icons">add</i>Create New Slots
                                </li>
                                <li class="frame-choice history" onclick="submitFormHistory()"  title="View history attendance">
                                    <form action="MainController" method="POST">
                                        <input type="hidden" name="action" value="historyLec" />
                                    </form>
                                    <i class="material-icons text-icon">history</i>View History Attendance
                                </li>
                                <li class="frame-choice sendMail"  onclick="submitFormSendEmail()" title="Send email for students">
                                    <form action="MainController" method="POST">
                                        <input type="hidden" name="action" value="SendEmailForRemindStudent" />
                                    </form>
                                    <i class="material-icons">send</i>Send Email for Students
                                </li>
                            </ul>
                        </div>
                        <div id="myBtn" class="burger-container" onclick="myFunction(this)">
                            <div class="bar1"></div>
                            <div class="bar2"></div>
                            <div class="bar3"></div>
                        </div>
                        <script>
                            function myFunction(x) {
                                x.classList.toggle("change");
                            }
                        </script>

                    </div>
                </nav>
                <!-- Navigation end -->
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
                        <div class="frame-div viewCreateSlot" onclick="submitForm()" >
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="viewFSlotLecturer" />
                            </form>
                            <i class="material-icons">visibility</i>View Create Slot
                        </div>
                        <div class="frame-div request-div" onclick="submitFormViewRequest()">
                            <form style="display: flex; align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewRequest" />
                                <i class="material-icons">mail_outline</i>
                            </form>
                            View Request
                        </div>
                        <div class="frame-div lecturerProfile" style="background-color: #b7b7b7;">
                            <form style="display: flex; align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="viewLecturerProfile" />
                                <i class="material-icons">person</i>
                            </form>
                            View Lecturer Profile
                        </div>
                        <div class="frame-div hideView" onclick="submitFormHideView()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="HideView" />
                            </form>
                            <i class="fas fa-search"></i>Hide List</p>
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

        <section class="fh5co-about-me">
            <div class="about-me-inner site-container">
                <article class="portfolio-wrapper">
                    <c:choose>
                        <c:when test="${USER.userName eq 'Nguyễn Ngọc Lâm'}">
                            <div class="portfolio__img">
                                <img src="./public/UsersView/about-me.jpg" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:when>
                        <c:when test="${USER.userName eq 'Nguyễn Thế Hoàng'}">
                            <div class="portfolio__img">
                                <img src="./public/UsersView/thayHoang.png" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:when>
                        <c:when test="${USER.userName eq 'Đỗ Tấn Nhàn'}">
                            <div class="portfolio__img">
                                <img src="./public/UsersView/sensei1.jpg" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:when>
                        <c:when test="${USER.userName eq 'Lâm Hữu Khánh Phương'}">
                            <div class="portfolio__img">
                                <img src="./public/UsersView/sensei2.jpg" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:when>
                        <c:when test="${USER.userName eq 'Trương Long'}">
                            <div class="portfolio__img">
                                <img src="./public/UsersView/sensei3.jpg" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="portfolio__img">
                                <img src="./public/StudentHome/User-avatar.png" class="about-me__profile" alt="about me profile picture">
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="portfolio__bottom">
                        <div class="portfolio__name">
                            <span>N</span>
                            <h2 class="universal-h2">ame: ${USER.userName}</h2>
                        </div>
                        <p>Lecturer ID: ${USER.userID}</p>
                        <p>Email: ${USER.userEmail}</p>
                    </div>
                </article>
                <div class="about-me__text">
                    <div class="about-me-slider">
                        <div class="about-me-single-slide">
                            <h2 class="universal-h2 universal-h2-bckg">About me</h2>
                            <p><span>H</span> e has work appearing or forthcoming in over a dozen venues, including Buzzy Mag, The Spirit of Poe, and the British Fantasy Society journal Dark Horizons. He is also CEO of a company, specializing in custom book publishing and social media marketing services, have created a community for authors to learn and connect.He has work appearing or forthcoming in over a dozen venues, including Buzzy Mag, The Spirit of Poe, and have created a community for authors to learn and connect.</p>
                            <h4>Author</h4>
                            <a href="https://github.com/doit-now" class="p-white">See me</a>
                        </div>
                    </div>
                    <form action="MainController" method="POST">
                        <div style="    width: 100%;
                             display: flex;
                             justify-content: space-between;">
                            <div class="form-group" style=" width: 120%;">
                                <select class="form-control" name="txtSubjectCode">
                                    <c:forEach items="${LIST_ADD_MAJORS}" var="subject">
                                        <option value="${subject.subjectCode}">${subject.subjectCode}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group" style="width: 20%;">
                                <button style="height: 100% " class="form-control" type="submit" name="action" value="AddMajor">Add</button>
                            </div>
                        </div>
                    </form>
                    <c:if test="${not empty requestScope.LIST_MAJORS}">
                        <div>
                            <table class="custom-table table-hover table-rounded" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Lecturer ID</th>
                                        <th>Subject Code</th>
                                        <th>Subject Name</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.LIST_MAJORS}" 
                                               var="major" varStatus="status">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${status.count}</td>
                                        <td>${major.lecturerID}</td>
                                        <td>${major.subjectCode}</td>
                                        <td>${major.subjectName}</td>
                                        <td>
                                            <input type="hidden" name="txtSubjectCode" 
                                                   value="${major.subjectCode}" readonly="">
                                            <button class="form-control delete" type="submit" name="action"
                                                    value="DeleteMajor">Delete</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="about-me-bckg"></div>
        </section>
        <!-- About me end -->
        <h1 class="text-center text-custom">Timetable</h1>
        <div>
            <c:if test="${not empty requestScope.LIST_TIMETABLES}">
                <table border="1" class="table table-hover table-rounded">
                    <thead style="font-size: 20px;">
                        <tr  class="table table-warning">
                            <th>No.</th>
                            <th>Semester ID</th>
                            <th>Slot ID</th>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Day 1</th>
                            <th>Day 2</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.LIST_TIMETABLES}" 
                                   var="timetable" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${timetable.semesterID}</td>
                                <td>${timetable.slotID}</td>
                                <td>${timetable.subjectCode}</td>
                                <td>
                                    <c:forEach var="subject" items="${requestScope.TB_SUBJECTS}">
                                        <c:if test="${subject.subjectCode eq timetable.subjectCode}">
                                            ${subject.subjectName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.day1}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.day2}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.startTime}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.endTime}
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty requestScope.LIST_TIMETABLES}">
                <h3 style="color: red">${requestScope.TIMETABLE_MESSAGE}</h3>
            </c:if>
        </div>
        <script>
            // L?y thông tin l?i t? bi?n requestScope.ERROR
            var errorMessage = "${requestScope.ERROR}";
            // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
            if (errorMessage.trim() !== "") {
                alert(errorMessage);
            }
        </script>
        <% }%>

    </body>
</html>
