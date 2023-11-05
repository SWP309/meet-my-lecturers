
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Thêm liên kết đến Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <!-- Material Icons CSS -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="./StudentHome_1.css" />
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
            th {
                text-align: center;
            }
            td {
                text-align: center;
            }
        </style>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitForm() {
                var form = document.querySelector('.bookingview form');
                form.submit();
            }
             function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
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
            function submitFormViewLecturer() {
                var form = document.querySelector('.viewLecturer form');
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
    </head>
    <body>
        <div class="fptu-eng-1-parent">
             <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageStudent" />
                </form>
            </div>
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
                    <div class="frame-div requestViewStatus" style="background-color: #b7b7b7;" id="booking-view-div">
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

                        <i class="fas fa-search"></i> <p style="font-size: 16px">View Lecturer</p>
                    </div>
                    <div class="frame-div logout" onclick="submitFormLogout()" style="width: 10%; text-align: center">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="Logout" />
                        </form>
                        <i class="material-icons">logout</i> Logout
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
                <div class="row align-items-center">
                    <div class="form-group">
                        <input type="text" class="form-control " name="txtSubjectCode" value="${param.txtSubjectCode}" placeholder="SubjectCode" pattern="^[A-Z]{3}[0-9]{3}$">
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="txtRequestStatus">
                            <option value="All">All Requests</option>
                            <option value="Accepted">Accepted</option>
                            <option value="Declined">Declined</option>
                            <option value="InProgress">In progress</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" type="submit" name="action" value="SearchRequestStatus">Search</button>
                    </div>
                </div>
            </form>
                    
                    
            <div class="row justify-content-center mt-5">
                <c:if test="${empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_STATUS}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.REQUEST_BY_STATUS}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.USER_BY_STATUS}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${not empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_SUBCODE_AND_STATUS}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.REQUEST_BY_SUBCODE_AND_STATUS}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.USER_BY_SUBCODE_AND_STATUS}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.ALL_REQUEST}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.ALL_USER}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${not empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST_BY_SUBCODE}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.ALL_REQUEST_BY_SUBCODE}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.ALL_USER_BY_SUBCODE}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>        
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