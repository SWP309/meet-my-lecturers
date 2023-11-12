<%-- 
    Document   : CheckAttendLec
    Created on : Nov 6, 2023, 8:05:05 AM
    Author     : Minh Khang
--%>

<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.semester.SemesterDAO"%>
<%@page import="sample.semester.SemesterDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./ViewRequest.css" />
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



        <style>
            .table-container {
                display: flex;
                justify-content: center;
                margin: auto;
                margin-top: 5%;
            }

            .custom-table {
                border-collapse: collapse;
                width: 100%;
            }

            .custom-table th,
            .custom-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            .custom-table th {
                background-color: #f2f2f2;
                color: #333;
            }

            .btn-accept {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-decline {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                font-size: 14px;
            }

            .error-message {
                color: red;
                text-align: center;
            }
            .form-control{
                border-radius: 40px;
                width: 30%;
            }

        </style>
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
            function submitFormHistory() {
                var form = document.querySelector('.history form');
                form.submit();
            }
            function submitFormSendEmail() {
                var form = document.querySelector('.sendMail form');
                form.submit();
            }
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
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
                    <div class="frame-div viewCreateSlot" onclick="submitForm()">
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
                            <i class="material-icons">logout</i>
                        </div>
                        <div class="logout">
                            <p class="logout1">Logout</p>
                        </div>
                    </div>

                    <div style="cursor: pointer">
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
        <div class="container">
            <form action="MainController" method="POST">
                <div class="row mt-3">
                    <div class="col-md-2">
                        <c:if test="${not empty requestScope.semester}">
                            <select class="form-select" name="txtsemes">
                                <c:forEach var="semesList" varStatus="counter" items="${requestScope.semester}">
                                    <option value="${semesList.semesterID}">${semesList.semesterName}</option>
                                </c:forEach>
                            </select>
                        </c:if>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" value="attendLecServlet" name="action" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="view-user-table">

            <div class="table-container">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Free Slot ID</th>
                            <th>Semester ID</th>
                            <th>Subject Code</th>                             
                            <th>Start Time</th>                             
                            <th>End Time</th>                             
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.attend}" var="slotAttend" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${slotAttend.freeSlotID}</td>

                                <td>${slotAttend.semesterID}</td>
                                <td>${slotAttend.subjectCode}</td>
                                <td>${slotAttend.startTime}</td>
                                <td>${slotAttend.endTime}</td>

                                <td style="color: green">Present</td>
                                <%--                                
                                                                <c:choose>
                                                                     <c:when test="${slotAttend.status == 2}">
                                                                <td>
                                                                    <button type="submit" name="action" value="AcceptRequest" class="btn-accept">Accept</button>
                                                                </td>
                                                                     </c:when>
                                                                     <c:otherwise>
                                                                <td>
                                                                    <button type="submit" name="action" value="DeleteRequest" class="btn-decline">Decline</button>
                                                                </td>
                                                                </c:otherwise>
                                                                </c:choose>
                                --%>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
        <% } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
