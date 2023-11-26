
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./StudentHome_1.css" />
        <script src="./student.js"></script>
        <!-- Thêm liên kết đến Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <!-- Material Icons CSS -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!--        text gg -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
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
            .table-rounded{
                /* transform: scale(0.9); */
                transform: 0.9;
                width: 85%;
                margin: auto;
                /* padding: 28px; */
                margin-top: 10%;
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
                        <div class="frame-div requestViewStatus" style="background-color: #b7b7b7;" id="booking-view-div">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewRequestStatus" />
                            </form>
                            <i class="material-icons">visibility</i>View Request Status
                        </div>
                        <div class="frame-div viewLecturer" onclick="submitFormViewLecturer()">
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
        <div class="frame-choice history" style="cursor: pointer; color: white" onclick="submitFormHistory()">
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="attendanceSemes" />
            </form>

            <i class="material-icons">history</i>
        </div>

        <h1 class="text-center text-custom">Table of Requests</h1>
        <div class="row justify-content-center mt-5">
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
                            <option value="Overdue">Overdue</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="txtSemesterID">
                            <c:forEach items="${requestScope.ListSemes}" 
                                       var="listSemes" varStatus="status">
                                <option value="${listSemes.semesterID}" >${listSemes.semesterID}</option>
                            </c:forEach>
                            <!--                            <option value="FA23">FA23</option>
                                                        <option value="SU23">SU23</option>
                                                        <option value="SP23">SP23</option>
                                                        <option value="FA22">FA22</option>-->
                        </select>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" type="submit" name="action" value="SearchRequestStatus">Search</button>
                    </div>
                </div>
            </form>
            <c:if test="${empty param.txtSubjectCode and not empty requestScope.LIST_REQUEST}">
                <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Request ID</th>
                            <th>Semester</th>
                            <th>Free Slot ID</th>
                            <th>Subject Code</th>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.LIST_REQUEST}" 
                                   var="request" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${request.requestID}</td>
                                <td>${request.semesterID}</td>
                                <td>${request.freeSlotID}</td>
                                <td>${request.subjectCode}</td>
                                <td>${request.lecturerID}</td>
                                <td>${request.lecturerName}</td>
                                <td>${request.startTime}</td>
                                <td>${request.endTime}</td>
                                <td>${request.description}</td>
                                <td>
                                    <c:if test="${request.status == 1}">
                                        <b style="color: green">Accepted</b>
                                    </c:if>
                                    <c:if test="${request.status == 2}">
                                        <b style="color: #cccc00">In progress</b>
                                    </c:if>
                                    <c:if test="${request.status == 0}">
                                        <b style="color: red">Declined</b>

                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if></c:if>
                                    <c:if test="${request.status == 3}">
                                        <b style="color: gray">Overdue</b>
                                    </c:if>
                                </td>
                                <c:if test="${empty request.note || request.note == null}">
                                    <td>
                                        <b>None</b>
                                    </td>
                                </c:if>
                                <c:if test="${not empty request.note || request.note != null}">
                                    <td>
                                        <b>${request.note}</b>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_STATUS}">
                <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Request ID</th>
                            <th>Semester</th>
                            <th>Free Slot ID</th>
                            <th>Subject Code</th>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.REQUEST_BY_STATUS}" 
                                   var="request" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${request.requestID}</td>
                                <td>${request.semesterID}</td>
                                <td>${request.freeSlotID}</td>
                                <td>${request.subjectCode}</td>
                                <td>${request.lecturerID}</td>
                                <td>${request.lecturerName}</td>
                                <td>${request.startTime}</td>
                                <td>${request.endTime}</td>
                                <td>${request.description}</td>
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
                                    <c:if test="${request.status == 3}">
                                        <b style="color: gray">Overdue</b>
                                    </c:if>
                                </td>
                                <c:if test="${empty request.note || request.note == null}">
                                    <td>
                                        <b>None</b>
                                    </td>
                                </c:if>
                                <c:if test="${not empty request.note || request.note != null}">
                                    <td>
                                        <b>${request.note}</b>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${not empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_SUBCODE_AND_STATUS}">
                <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Request ID</th>
                            <th>Semester</th>
                            <th>Free Slot ID</th>
                            <th>Subject Code</th>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.REQUEST_BY_SUBCODE_AND_STATUS}" 
                                   var="request" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${request.requestID}</td>
                                <td>${request.semesterID}</td>
                                <td>${request.freeSlotID}</td>
                                <td>${request.subjectCode}</td>
                                <td>${request.lecturerID}</td>
                                <td>${request.lecturerName}</td>
                                <td>${request.startTime}</td>
                                <td>${request.endTime}</td>
                                <td>${request.description}</td>
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
                                    <c:if test="${request.status == 3}">
                                        <b style="color: gray">Overdue</b>
                                    </c:if>
                                </td>
                                <c:if test="${empty request.note || request.note == null}">
                                    <td>
                                        <b>None</b>
                                    </td>
                                </c:if>
                                <c:if test="${not empty request.note || request.note != null}">
                                    <td>
                                        <b>${request.note}</b>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST}">
                <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Request ID</th>
                            <th>Semester</th>
                            <th>Free Slot ID</th>
                            <th>Subject Code</th>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.ALL_REQUEST}" 
                                   var="request" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${request.requestID}</td>
                                <td>${request.semesterID}</td>
                                <td>${request.freeSlotID}</td>
                                <td>${request.subjectCode}</td>
                                <td>${request.lecturerID}</td>
                                <td>${request.lecturerName}</td>
                                <td>${request.startTime}</td>
                                <td>${request.endTime}</td>
                                <td>${request.description}</td>
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
                                    <c:if test="${request.status == 3}">
                                        <b style="color: gray">Overdue</b>
                                    </c:if>
                                </td>
                                <c:if test="${empty request.note || request.note == null}">
                                    <td>
                                        <b>None</b>
                                    </td>
                                </c:if>
                                <c:if test="${not empty request.note || request.note != null}">
                                    <td>
                                        <b>${request.note}</b>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${not empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST_BY_SUBCODE}">
                <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Request ID</th>
                            <th>Semester</th>
                            <th>Free Slot ID</th>
                            <th>Subject Code</th>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.ALL_REQUEST_BY_SUBCODE}" 
                                   var="request" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${request.requestID}</td>
                                <td>${request.semesterID}</td>
                                <td>${request.freeSlotID}</td>
                                <td>${request.subjectCode}</td>
                                <td>${request.lecturerID}</td>
                                <td>${request.lecturerName}</td>
                                <td>${request.startTime}</td>
                                <td>${request.endTime}</td>
                                <td>${request.description}</td>
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
                                    <c:if test="${request.status == 3}">
                                        <b style="color: gray">Overdue</b>
                                    </c:if>
                                </td>
                                <c:if test="${empty request.note || request.note == null}">
                                    <td>
                                        <b>None</b>
                                    </td>
                                </c:if>
                                <c:if test="${not empty request.note || request.note != null}">
                                    <td>
                                        <b>${request.note}</b>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>        
    <div id="customAlert">
        <div id="alertContent">
            <!-- N?i dung c?nh báo s? ???c thêm vào ?ây -->
        </div>
        <button class="closeButton">X</button>
    </div>
    <style>
        #customAlert {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            padding: 28px;
            font-family: Arial, sans-serif;
            font-size: 18px;
            text-align: center;
            z-index: 9999;
            width: 36%;
            color: red;
            font-weight: bold;
        }
        #alertContent{
            font-family: 'Oswald','Playpen Sans';
            padding: 20px;
        }
        .closeButton {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            font-weight: bold;
            border: none;
        }
        .closeButton:hover{
            opacity: 0.5;
        }

        #alertContent {
            /* N?u b?n mu?n tu? ch?nh ki?u ch? và màu s?c, hãy ?i?u ch?nh ?o?n CSS này */
        }
    </style>
    <script>

        var errorMessage = "${requestScope.ERROR}";


// Ki?m tra n?u errorMessage không r?ng, hi?n th? thông báo c?nh báo
        if (errorMessage.trim() !== "") {
            showAlert(errorMessage);
        }

        function showAlert(message) {
            var alertDiv = document.getElementById("customAlert");
            var alertContentDiv = document.getElementById("alertContent");
            alertContentDiv.textContent = message;
            alertDiv.style.display = "block";
            var closeButton = alertDiv.querySelector(".closeButton");
            closeButton.addEventListener("click", function () {
                alertDiv.style.display = "none";
            });
        }
    </script>
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
