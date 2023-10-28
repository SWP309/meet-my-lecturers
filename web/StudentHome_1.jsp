
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./StudentHome_1.css" />
        <!-- Google Fonts - Poppins -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap">

        <!-- Google Fonts - Lohit Tamil -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lohit Tamil:wght@400&display=swap">

        <!-- Google Fonts - Lexend -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <!-- Font Awesome 6 Beta 3 CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Material Icons CSS -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>

        <!-- Foundation Min CSS -->
        <link rel="stylesheet" href="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">

        <!-- Foundation CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css">

        <!-- Motion UI CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.css">

        <!-- Foundation Prototype CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation-prototype.min.css">

        <!-- Foundicons CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet" type="text/css">


        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
                    window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
                }
            }
            function submitForm() {
                var form = document.querySelector('.bookingview form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormRequest() {
                var form = document.querySelector('.request form');
                form.submit();
            }
            function submitSearchForm() {
                var form = document.querySelector('.searchfunction form');
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

//
//            function hideUserInfo() {
//                var userInfo = document.getElementById("user-info");
//                userInfo.style.display = "none"; // ?n thông tin ng??i dùng khi r?i chu?t ra kh?i hình ?nh
//            }
            function confirmCancel() {
                var result = confirm("Are you sure about cancel your booking ?");
                if (result) {
                    // N?u ng??i dùng ch?n OK, chuy?n ??n trang MainController ?? x? lý hành ??ng "cancel".
                    // Ví d?:
                    window.location.href = "MainController?action=cancel&bookingID=" + document.querySelector('[name="bookingID"]').value;
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
                    // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
                    event.preventDefault();
                }
            }
            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }

        </script>
        <style>
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
        </style>
    </head>
    <body>
        <div class="student-home">
            <div class="fptu-eng-1-parent">
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-div bookingview" onclick="submitForm()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewBooking" />
                            </form>
                            <div class="bookedslot-wrapper">
                                <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                                <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                            </div>
                            <div class="view-booking" >View Booking</div>
                        </div>
                        <div class="frame-div request" onclick="submitFormRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                            </form>

                            <i class="material-icons">mail_outline</i> Request
                        </div>
                        <div class="frame-div logout" onclick="submitFormLogout()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="Logout" />
                            </form>
                            <div class="logout-wrapper">
                                <img class="logout-icon" alt="" src="./public/StudentHome/logout.svg" />
                            </div>
                            <div class="request">
                                <p class="logout1">Logout</p>
                            </div>
                        </div>
                    </div>
                    <div>
                        <img class="frame-item" alt="" src="./public/StudentHome/group-33.svg" 
                             onclick="showUserInfo()" />
                        <div id="user-info" style="display: none;">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
                        </div>
                    </div>

                </div>
            </div>

            <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="" data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;" data-resize="co1gk1-orbit" id="co1gk1-orbit" data-e="3gpl68-e" data-events="resize" style="margin-top: 100px;">
                <ul class="orbit-container" tabindex="0" style="height: 613.389px;">
                    <button class="orbit-previous" tabindex="0" style="color: gray;"><span class="show-for-sr">Previous Slide</span>&#9664;</button>
                    <button class="orbit-next" tabindex="0" style="color: gray;"><span class="show-for-sr">Next Slide</span>&#9654;</button>
                    <li class="orbit-slide" data-slide="0" style="display: none; position: relative; top: 0px;">
                        <img class="orbit-image" src="./public/StudentHome/anh1.jpg"  style="width: 2000px; height: 600px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">FPT University</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="1" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh3.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Ceremony</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="2" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh4.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Orientation Week</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="3" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh5.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">F-Camp</figcaption>
                    </li>
                    <li class="orbit-slide is-active" data-slide="4" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh6.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Training at the military</figcaption>
                    </li>
                </ul>
                <nav class="orbit-bullets">
                    <button class="" data-slide="0"><span class="show-for-sr">First slide details.</span></button>
                    <button data-slide="1" class=""><span class="show-for-sr">Second slide details.</span></button>
                    <button data-slide="2" class=""><span class="show-for-sr">Third slide details.</span></button>
                    <button data-slide="3" class=""><span class="show-for-sr">Third slide details.</span></button>
                    <button data-slide="4" class="is-active"><span class="show-for-sr">Fourth slide details.</span><span class="show-for-sr">Current Slide</span></button>
                </nav>
            </div>


        </div>
        <div class="admin-viewusersedited">
            <div class="searchfunction">
                <!--                <div class="search" style="cursor: pointer ">
                                    <div class="search-child" onclick="submitSearchForm()">
                                        <div class="search1">Search</div>
                                    </div>
                                </div>-->
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="SearchFSlot"/>

                    <div class="lecture-4">
                        <div class="searchbylec-parent">
                            <img
                                class="searchbylec-parent"
                                alt=""
                                src="./public/UsersView/searchbylec.svg"
                                onclick="submitSearchForm()"
                                />
                            <div class="userid"><input class="in_search_userID" type="text" name="txtSubjectCode" value="${param.txtSubjectCode}" placeholder="Subject Code"/></div>
                        </div>
                        <div class="bysemester">
                            <img
                                class="bysemester-child"
                                alt=""
                                src="./public/UsersView/rectangle-13.svg"
                                />

                            <div class="username"><input class="in_name" type="text" name="txtUserID" value="${param.txtUserID}" placeholder="Lecturer's ID(Ex:GVxxxx)"/></div>
                        </div>
                        <div class="bysemester" style="margin-left: 33%;">
                            <img
                                class="bysemester-child"
                                alt=""
                                src="./public/UsersView/rectangle-13.svg"
                                />

                            <div class="username"><input class="in_name" type="text" name="txtUserName" value="${param.txtUserName}" placeholder="Input lecturer's name"/></div>
                        </div>
                        <div class="bysemester " style="margin-left: 66%;">
                            <img
                                class="bysemester-child"
                                alt=""
                                src="./public/UsersView/rectangle-13.svg"
                                />

                            <div class="username"><input class="in_name" type="text" name="txtSemesterID" value="${param.txtSemesterID}" placeholder="SemesterID(Ex:FA23)"/></div>
                        </div>

                    </div>
                </form>
            </div>
            <div class="container mt-5" style="    margin-top: 14% !important;">
                <div class="row justify-content-center mt-5">
                    <c:if test="${not empty param.txtSubjectCode and empty param.txtUserID and empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBJECT}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBJECT}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>    
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and not empty param.txtUserID and empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_LECTURERID}">
                        <c:forEach items="${requestScope.FREESLOT_BY_LECTURERID}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and empty param.txtUserID and not empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_LECNAME}">
                        <c:forEach items="${requestScope.FREESLOT_BY_LECNAME}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtUserName" 
                                                           value="${param.txtUserName}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and empty param.txtUserID and empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SEMESTERID}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SEMESTERID}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and not empty param.txtUserID and empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBJECT_AND_LECID}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBJECT_AND_LECID}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and empty param.txtUserID and not empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBJECT_AND_LECNAME}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBJECT_AND_LECNAME}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserName" 
                                                           value="${param.txtUserName}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and empty param.txtUserID and empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBJECT_AND_SEMESTER}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBJECT_AND_SEMESTER}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and not empty param.txtUserID and empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_LECID_AND_SEMESTER}">
                        <c:forEach items="${requestScope.FREESLOT_BY_LECID_AND_SEMESTER}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and empty param.txtUserID and not empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_LECNAME_AND_SEMESTER}">
                        <c:forEach items="${requestScope.FREESLOT_BY_LECNAME_AND_SEMESTER}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtUserName" 
                                                           value="${param.txtUserName}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and not empty param.txtUserID and empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBCODE_AND_LECID_AND_SEMESTER}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBCODE_AND_LECID_AND_SEMESTER}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and empty param.txtUserID and not empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_SUBCODE_AND_LECNAME_AND_SEMESTER}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBCODE_AND_LECNAME_AND_SEMESTER}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserName" 
                                                           value="${param.txtUserName}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty param.txtSubjectCode and not empty param.txtUserID and not empty param.txtUserName and not empty param.txtSemesterID and not empty requestScope.FREESLOT_BY_ALL}">
                        <c:forEach items="${requestScope.FREESLOT_BY_ALL}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtUserName" 
                                                           value="${param.txtUserName}" readonly="">
                                                    <input type="hidden" name="txtSemesterID" 
                                                           value="${param.txtSemesterID}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty param.txtSubjectCode and empty param.txtUserID and empty param.txtUserName and empty param.txtSemesterID and not empty requestScope.FREESLOT}">
                        <c:forEach items="${requestScope.FREESLOT}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="width: 357px; height: 211px; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlot.endTime}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlot.capacity}" readonly="">
                                                    <button type="submit" name="action"
                                                            value="BookFreeSlot">Book</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.FREESLOT_BY_SUBJECT }">
                        <h3 style="color: red">${requestScope.SEARCH_FREESLOT_MESSAGE}</h3>
                    </c:if>  
                </div>

            </div>
            <!-- Thêm liên k?t ??n Bootstrap JS và jQuery -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
            <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/js/foundation.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.js"></script>

            <script>
                                    $(document).foundation();
            </script>
            <%} else {
                    response.sendRedirect("MainController");
                }%>
    </body>
</html>

