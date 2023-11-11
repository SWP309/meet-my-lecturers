<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./CreatedSlotView.css" />
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


        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                ViewCreatedSlotDTO listCreatedSlot = (ViewCreatedSlotDTO) request.getAttribute("listCreatedSlot");

        %>
        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
                    window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
                }
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
                form.submit();
            }
            function submitFormSendEmail() {
                var form = document.querySelector('.history form');
                form.submit();
            }
            function submitFormViewRequest() {
                var form = document.querySelector('.request-div form');
                form.submit();
            }
            function submitFormHideView() {
                var form = document.querySelector('.hideView form');
                form.submit();
            }
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
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

            function confirmDelete() {
                var result = confirm("Are you sure about delete this Free Slot ?");
                console.log(result);
                if (result) {
                    // N?u ng??i dùng ch?n OK, chuy?n ??n trang MainController ?? x? lý hành ??ng "cancel".
                    // Ví d?:
                    window.location.href = "MainController?action=delete&freeSlotID=" + listCreatedSlot.freeSlotID;
//                   window.location.href = "MainController?action=delete&freeSlotID=" + document.querySelector('[name="freeSlotID"]').value;
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
                    // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLink(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLinkByStEt(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLinkByAll(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLinkBySubjectCode(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLinkByNull(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }

        </script>
        <style>
            td {
                position: relative;
            }

            .specific-input{
                /*                width: 100%;
                                box-sizing: border-box;
                                position: absolute;
                                top: 0;
                                left: 0;
                                bottom: 0;
                                right: 0;*/
                /*                font-size: 14px;*/
                width: 198px;
                text-align: center;
                border: none; /* Lo?i b? vi?n */
            }
            button[type="submit"]{
                border: none; /* Lo?i b? vi?n */
                background-color: white;
                color: #007bff;
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

            .btn-book > .btn {
                border-radius: 15px;
                border: 1px solid black;
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
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageLecturer" />
                </form>
            </div>
            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div viewCreateSlot" onclick="submitForm()" >
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="viewFSlotLecturer" />
                        </form>
                        <i class="material-icons">visibility</i>View Create Slot
                    </div>
                    <div class="frame-div request-div" onclick="submitFormViewRequest()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="ViewRequest" />
                        </form>

                        <i class="material-icons">mail_outline</i>View Request
                    </div>
                    <div class="frame-div timetable-lec" onclick="submitFormViewTimetableForLec()" style="background-color: #b7b7b7;">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="ViewTimetableForLec" />
                        </form>

                        <i class="material-icons">mail_outline</i>View Timetable
                    </div>
                    <div class="frame-div hideView" onclick="submitFormHideView()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="HideView" />
                        </form>
                        <div>
                            <p class="HideView"><i class="fas fa-search"></i>Hide List</p>
                        </div>
                    </div>
                    <div class="frame-div logout" style="text-align: center;" onclick="submitFormLogout()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="Logout" />
                        </form>
                        <div class="logout-wrapper">
                            <img class="logout-icon" alt="" src="./public/StudentHome/logout.svg" />
                        </div>
                        <div class="logout">
                            <p class="logout1">Logout</p>
                        </div>
                    </div>

                    <div>
                        <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                             onclick="showUserInfo()" />
                        <div id="user-info" style="display: none; position: absolute;">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="container-div" style=" display: flex;
             flex-direction: column; float: right;">
            <div class="frame-Create CreateFSlot" style="cursor: pointer; color: white" onclick="submitFormCreate()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="CreateFS" />
                </form>

                <i class="material-icons">add</i>
            </div>
            <div class="frame-History history" style="cursor: pointer; color: white" onclick="submitFormSendEmail()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="SendEmailForRemindStudent" />
                </form>

                <i class="material-icons">send</i>
            </div>
        </div>
        <div class="student-lectures-schedule-edi">
            <div class="table-timetable" style="margin-top: 10%; padding: 40px;">
                <c:if test="${not empty requestScope.TB_TIMETABLES}">
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
                            <c:forEach items="${requestScope.TB_TIMETABLES}" 
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
                <c:if test="${empty requestScope.TB_TIMETABLES}">
                    <h3 style="color: red">${requestScope.TB_MESSAGE}</h3>
                </c:if>

            </div>
            <!--            <div class="backbutton"  onclick="submitFormBack()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="txtLecturer" value="${requestScope.TB_TIMETABLES.get(0).lecturerID}" />
                                <input type="hidden" name="txtSemester" value="${requestScope.TB_TIMETABLES.get(0).semesterID}" />
                                <input type="hidden" name="action" value="BackToRequest" />
                            </form>
                            <div class="back">Back</div>
                            <img class="back-icon" alt="" src="./public/request/back.svg" />
                        </div>-->

        </div>
        <%} else {
                response.sendRedirect("MainController");
            }%>
    </body>
</html>
