
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./BookingView.css" />
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>


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
            function submitFormRequest() {
                var form = document.querySelector('.request form');
                form.submit();
            }
            function submitSearchForm() {
                var form = document.querySelector('.searchfunction form');
                form.submit();
            }
            function submitFormViewLecturer() {
                var form = document.querySelector('.viewLecturer form');
                form.submit();
            }
            function submitFormRequestStatus() {
                var form = document.querySelector('.requestViewStatus form');
                form.submit();
            }
            function submitFormRequestStatus() {
                var form = document.querySelector('.requestViewStatus form');
                form.submit();
            }
            function submitFormHistory() {
                var form = document.querySelector('.history form');
                form.submit();
            }
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormHistory() {
                var form = document.querySelector('.history form');
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
            function confirmCheckAttendanceLink(event, bookingID) {
                var result = confirm("Are you sure about take part in this slot ?");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLink&bookingID=" + bookingID;
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

            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                if (!event.target.matches('.dropbtn')) {
                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    var i;
                    for (i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }

        </script>
        <style>
            .centered-link {
                display: flex;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <script>
            // L?y thông tin l?i t? bi?n requestScope.ERROR
            var errorMessage = "${requestScope.ERROR}";

            // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
            if (errorMessage.trim() !== "") {
                alert(errorMessage);
            }
        </script>

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
                        <div class="frame-div bookingview" style="background-color: #b7b7b7;">
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
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                            </form>

                            <i class="material-icons">mail_outline</i> Request
                        </div>
                        <div class="frame-div viewLecturer" onclick="submitFormViewLecturer()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewAllLecturers" />
                            </form>

                            <i class="fas fa-search"></i>View Lecturer
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
        <div class="frame-History history" style="cursor: pointer; color: white" onclick="submitFormHistory()">
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="attendanceSemes" />
            </form>

            <i class="material-icons">history</i>
        </div>
        <div class="student-viewbookedslot">
            <div class="container">
                <div class="row align-items-center justify-content-center" style="margin-top: -6%;">
                    <div>
                        <form action="MainController" method="POST" class="d-flex justify-content-center" style=" margin-top: 10%;">
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}">
                            </div>
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtSubjectCode" value="${param.txtSubjectCode}" placeholder="Input the subject code">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtSemesterID" value="${param.txtSemesterID}" placeholder="Input the semester">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchBSlot">Search</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--                            LIST OF THE PAGE------------------------------------------->

            <div class="container mt-5" style=" max-height: 500%; height: 1000px;   margin-top: -17% !important;">
                <div class="row justify-content-center mt-5">
                    <c:if test="${requestScope.LIST_BOOKING !=null}">
                        <c:if test="${not empty requestScope.LIST_BOOKING}">
                            <c:forEach var="listBooking" varStatus="counter" items="${requestScope.LIST_BOOKING}">
                                <div class="col-md-4"><a h>
                                        <div class="card" style="width: 403px;  max-height: 250px; border-radius: 5%;">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${listBooking.subjectCode.trim()}</span></div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${listBooking.lectureName}</span></div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${listBooking.startTime}</span></div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${listBooking.endTime}</span></div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" href="https://${listBooking.meetLink}" onclick="confirmCheckAttendanceLink(event, '${listBooking.bookingID}')"> Link Meet</a></span></div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${listBooking.semesterID}</span></div>
                                                <div class="d-flex justify-content-between btn-book">
                                                    <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                    <div>
                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                           onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${listBooking.bookingID}">
                                                            <i class="material-icons">cancel</i>Cancel</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>          

                </div>
            </div>

            <!--LIST OF SEARCH BY ALL ------------------------------------------------------------------>
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and not empty param.txtSubjectCode and not empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24%!important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ALL !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ALL}">
                                <c:forEach var="searchByAll" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ALL}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px;  max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByAll.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByAll.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByAll.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByAll.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link"  href="https://${searchByAll.meetLink}" target="_blank" onclick="confirmCheckAttendanceLink(event, '${searchByAll.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchByAll.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchByAll.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--SEARCH BY ST AND ET ------------------------------------------------------------------>
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and empty param.txtSubjectCode and empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET}">
                                <c:forEach var="searchByStEt" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px;  max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByStEt.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByStEt.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByStEt.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByStEt.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchByStEt.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByStEt.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchByStEt.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchByStEt.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--SEARCH BY SUBJECT CODE  ------------------------------------------------------------------>
            <c:if test="${empty param.txtStartTime and empty param.txtEndTime and not empty param.txtSubjectCode and empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT}">
                                <c:forEach var="searchBySubjectCode" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchBySubjectCode.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchBySubjectCode.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchBySubjectCode.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchBySubjectCode.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchBySubjectCode.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchBySubjectCode.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchBySubjectCode.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchBySubjectCode.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--SEARCH BY SEMESTER  ------------------------------------------------------------------>
            <c:if test="${empty param.txtStartTime and empty param.txtEndTime and empty param.txtSubjectCode and not empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_SEMESTER !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_SEMESTER}">
                                <c:forEach var="searchBySemesterID" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_SEMESTER}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchBySemesterID.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchBySemesterID.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchBySemesterID.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchBySemesterID.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchBySemesterID.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchBySemesterID.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchBySemesterID.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchBySemesterID.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--SEARCH BY NULL  ------------------------------------------------------------------>
            <c:if test="${empty param.txtStartTime and empty param.txtEndTime and empty param.txtSubjectCode and empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_NULL !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_NULL}">
                                <c:forEach var="searchByNull" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_NULL}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByNull.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByNull.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByNull.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByNull.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchByNull.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByNull.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchByNull.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchByNull.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--LIST OF SEARCH BY ST ET SUBJECT CODE ------------------------------------------------------------------>
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and not empty param.txtSubjectCode and empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SUBJECTCODE !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SUBJECTCODE}">
                                <c:forEach var="searchByStEtSubject" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SUBJECTCODE}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px;  max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByStEtSubject.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByStEtSubject.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByStEtSubject.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByStEtSubject.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchByStEtSubject.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByStEtSubject.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchByStEtSubject.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchByStEtSubject.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>
            <!--LIST OF SEARCH BY ST ET SESMESTER ------------------------------------------------------------------>
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and empty param.txtSubjectCode and not empty param.txtSemesterID }">
                <div class="container mt-5" style="    margin-top: -24% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SEMESTER !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SEMESTER}">
                                <c:forEach var="searchByStEtSemesterID" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET_SEMESTER}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px;  max-height: 250px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByStEtSemesterID.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByStEtSemesterID.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByStEtSemesterID.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByStEtSemesterID.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" target="_blank" href="https://${searchByStEtSemesterID.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByStEtSemesterID.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${searchByStEtSemesterID.semesterID}</span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${searchByStEtSemesterID.bookingID}">
                                                                <i class="material-icons">cancel</i>Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>          

                    </div>
                </div>
            </c:if>



            <% } else {
                    response.sendRedirect("MainController?action=");
                }

            %>
    </body>
</html>
