
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
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


        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");

        %>
        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?�y n?u c?n
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
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function goBack() {
                window.history.back();
            }
            var userDTO = {
                userID: "<%= us.getUserID()%>",
                userName: "<%= us.getUserName()%>",
                userEmail: "<%= us.getUserEmail()%>"
            };
            function showUserInfo() {
                var userInfo = document.getElementById("user-info");
                if (userInfo.style.display === "none" || userInfo.style.display === "") {
                    userInfo.style.display = "block"; // Hi?n th? th�ng tin khi ???c nh?p chu?t
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
                    // N?u ng??i d�ng ch?n OK, chuy?n ??n trang MainController ?? x? l� h�nh ??ng "cancel".
                    // V� d?:
                    window.location.href = "MainController?action=cancel&bookingID=" + document.querySelector('[name="bookingID"]').value;
                } else {
                    // N?u ng??i d�ng ch?n Cancel, kh�ng l�m g� c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? th�ng b�o cho ng??i d�ng
                    // N?u ng??i d�ng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?�.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLink(event, bookingID) {
                var result = confirm("Are you sure about take part in this slot ?");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i y�u c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLink&bookingID=" + bookingID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? l� k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i d�ng ch?n Cancel, kh�ng l�m g� c?.
                    event.preventDefault();
                }
            }

            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
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
        <div class="student-viewbookedslot">
            <div class="fptu-eng-1-parent">
                <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                    <form action="MainController" method="POST">
                        <input type="hidden" name="action" value="returnHomePageStudent" />
                    </form>
                    <img
                        class="fptu-eng-1-icon"
                        alt=""
                        src="public/BookingView/2021fptueng-1@2x.png"
                        />
                </div>

                <div class="frame-parent">
                    <div class="frame-group">
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
            <div class="backbutton"  onclick="goBack()">
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="./public/request/back.svg" />
            </div>
            <div class="container">
                <div class="row align-items-center justify-content-center" style="margin-top: -44%;">
                    <div>
                        <form action="MainController" method="POST" class="d-flex justify-content-center" style=" margin-top: 10%;">
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}">
                            </div>
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtSubjectCode" value="${param.txtSubjectCode}">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchBSlot">Search</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <!--LIST OF SEARCH BY ALL ------------------------------------------------------------------>
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and not empty param.txtSubjectCode}">
                <div class="container mt-5" style="    margin-top: -45% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ALL !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ALL}">
                                <c:forEach var="searchByAll" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ALL}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; height: 192px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByAll.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByAll.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByAll.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByAll.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" href="https://${searchByAll.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByAll.bookingID}')"> Link Meet</a></span></div>
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
            <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and empty param.txtSubjectCode}">
                <div class="container mt-5" style="    margin-top: -45% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET}">
                                <c:forEach var="searchByStEt" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_ST_ET}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; height: 192px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchByStEt.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchByStEt.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchByStEt.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchByStEt.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" href="https://${searchByStEt.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchByStEt.bookingID}')"> Link Meet</a></span></div>
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
            <c:if test="${empty param.txtStartTime and empty param.txtEndTime and not empty param.txtSubjectCode}">
                <div class="container mt-5" style="    margin-top: -45% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT !=null}">
                            <c:if test="${not empty requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT}">
                                <c:forEach var="searchBySubjectCode" varStatus="counter" items="${requestScope.SEARCH_BOOKED_SLOT_BY_SUBJECT}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; height: 192px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${searchBySubjectCode.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${searchBySubjectCode.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${searchBySubjectCode.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${searchBySubjectCode.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" href="https://${searchBySubjectCode.meetLink}" onclick="confirmCheckAttendanceLink(event, '${searchBySubjectCode.bookingID}')"> Link Meet</a></span></div>
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
            <!--SEARCH BY NULL  ------------------------------------------------------------------>
            <c:if test="${empty param.txtStartTime and empty param.txtEndTime and empty param.txtSubjectCode}">
                <div class="container mt-5" style="    margin-top: -45% !important;">
                    <div class="row justify-content-center mt-5">
                        <c:if test="${requestScope.LIST_BOOKING !=null}">
                            <c:if test="${not empty requestScope.LIST_BOOKING}">
                                <c:forEach var="bookings" varStatus="counter" items="${requestScope.LIST_BOOKING}">
                                    <div class="col-md-4"><a h>
                                            <div class="card" style="width: 403px; height: 192px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${bookings.subjectCode.trim()}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${bookings.lectureName}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${bookings.startTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${bookings.endTime}</span></div>
                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Meet Link:</b></strong> <span class="ml-auto"><a class="centered-link" href="https://${bookings.meetLink}" onclick="confirmCheckAttendanceLink(event, '${bookings.bookingID}')"> Link Meet</a></span></div>
                                                    <div class="d-flex justify-content-between btn-book">
                                                        <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                        <div>
                                                            <a class="d-flex justify-content-between" style="text-decoration: none;" 
                                                               onclick="return confirm('Are you sure to cancel this booking')" href="MainController?action=cancel&bookingID=${bookings.bookingID}">
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

            <h3>
                ${requestScope.ERROR}
            </h3> 
    </body>
</html>
