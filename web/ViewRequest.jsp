<%@page import="sample.users.UserDTO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./ViewRequest.css" />
        <link rel="stylesheet" href="./style.css">
        <link rel="stylesheet" href="./slick.css">
        <script src="./lecturer.js"></script>
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
            function goBack() {
                window.history.back();
            }
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunctionDropdown() {
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
        <style>
            .form-control {
                border-radius: 35px;
            }
            .form-group {
                margin: 0.4rem;
                border-radius: 35px;
                .table-container {
                    display: flex;
                    justify-content: center;
                    margin: auto;
                    margin-top: 10%;
                }

                .error-message {
                    color: red;
                    text-align: center;
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
                    <div>
                        <img class="frame-item" alt="" style="cursor: pointer" src="public/BookingView/group-33.svg" 
                             onclick="showUserInfo()" />
                            <div id="user-info" style="display: none;
                            position: absolute">
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
                            <div class="frame-div returnHomeDiv" onclick="submitFormHomePageDiv()"> 
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="returnHomePageLecturer" />
                                    <i class="material-icons">home</i>
                                </form>
                                Home
                            </div>
                            <div class="frame-div viewCreateSlot" onclick="submitForm()">
                                <form action="MainController" method="POST" style="display: none;">
                                    <input type="hidden" name="action" value="viewFSlotLecturer" />
                                </form>
                                <i class="material-icons">visibility</i>View Create Slot
                            </div>
                            <div class="frame-div request-div"  style="background-color: #b7b7b7;">
                                <form style="display: flex;
                                      align-content: center;" action="MainController" method="POST">
                                    <input type="hidden" name="action" value="ViewRequest" />
                                    <i class="material-icons">mail_outline</i>
                                </form>
                                View Request
                            </div>
                            <div class="frame-div lecturerProfile" onclick="submitFormViewLecturerProfile()">
                                <form style="display: flex;
                                      align-content: center;" action="MainController" method="POST">
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
            <div class="admin-viewusersedited">
                <div class="admin-viewusers">
                    <div class="container-div" style=" display: flex;
                         flex-direction: column;
                         float: right;">
                        <div class="frame-choice CreateFSlot" style="cursor: pointer;
                             color: white" onclick="submitFormCreate()">
                                 <form action="MainController" method="POST">
                                     <input type="hidden" name="action" value="CreateFS" />
                                 </form>

                                 <i class="material-icons">add</i>
                             </div>
                             <div class="frame-choice history" style="cursor: pointer;
                             color: white" onclick="submitFormHistory()">
                                 <form action="MainController" method="POST">

                                     <input type="hidden" name="action" value="historyLec" />
                                 </form>

                                 <i class="material-icons">history</i>
                             </div>
                             <div class="frame-choice sendMail" style="cursor: pointer;
                             color: white"  onclick="submitFormSendEmail()">
                                 <form action="MainController" method="POST">
                                     <input type="hidden" name="action" value="SendEmailForRemindStudent" />
                                 </form>

                                 <i class="material-icons">send</i>
                             </div>
                        </div>
                        <div class="container-div" style=" display: flex;
                        flex-direction: column;
                        float: right;">
                        <div class="frame-Create CreateFSlot" style="cursor: pointer;
                             color: white" onclick="submitFormCreate()">
                                 <form action="MainController" method="POST">
                                     <input type="hidden" name="action" value="CreateFS" />
                                 </form>

                                 <i class="material-icons">add</i>
                             </div>
                             <div class="frame-History history" style="cursor: pointer;
                             color: white" onclick="submitFormHistory()">
                                 <form action="MainController" method="POST">
                                     <input type="hidden" name="action" value="CreateFS" />
                                 </form>

                                 <i class="material-icons">history</i>
                             </div>
                        </div>
                        <h1 class="text-center textDashBoard" style="margin-top: 20px;">Request table</h1>
                    <div class="container">
                        <div class="row align-items-center justify-content-center" style="margin: 80px 0 -60px 0">
                                <div>
                                    <form action="MainController" method="POST" class="d-flex justify-content-center">
                                        <div class="form-group"  style="margin-left: 5px">
                                            <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}">
                                        </div>
                                        <div class="form-group" style="margin-left: 5px">
                                            <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}">
                                        </div>
                                        <div class="form-group" style="margin-left: 5px">
                                            <select class="form-control" name="txtSubjectCode">
                                                <option value="">All</option>
                                                <option value="PRJ301">PRJ301</option>
                                                <option value="PRM392">PRM392</option>
                                                <option value="SEP490">SEP490</option>
                                                <option value="SWD392">SWD392</option>
                                                <option value="SWP391">SWP391</option>
                                                <option value="SWR302">SWR302</option>
                                                <option value="SWT301">SWT301</option>
                                            </select>
                                        </div>
                                        <div class="form-group" style="margin-left: 5px">
                                            <select class="form-control" name="txtSemesterID">
                                                <option value="FA23">FA23</option>
                                                <option value="SU23">SU23</option>
                                                <option value="SP23">SP23</option>
                                                <option value="FA22">FA22</option>
                                            </select>
                                        </div>
                                        <div class="form-group" style="margin-left: 5px">
                                            <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchRequestForLec">Search</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div>
                            <button> <a href="MainController?action=acceptAllRequest">Accept All</a> </button>
                        </div>
                        <div>
                            <button> <a href="MainController?action=declineAllRequest">Decline All</a> </button>
                        </div>

                        <div class="view-user-table" style="width: 90%;
                        margin: 0 auto;
                        border-radius: 20px;">
                        <c:if test="${not empty requestScope.LIST_REQUESTS}">

                            <div style="display: flex;
                                 justify-content: center;
                                 margin: auto;
                                 margin-top: 10%;">
                                <table class="custom-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Request ID</th>
                                            <th>Semester ID</th>
                                            <th>Free Slot ID</th>
                                            <th>Student ID</th>
                                            <th>Student's Name</th>
                                            <th>Subject Code</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Description</th>
                                            <th>Accept</th>
                                            <th>Note (If decline)</th>
                                            <th>Decline</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.LIST_REQUESTS}" var="request" varStatus="counter">
                                            <tr>
                                        <form action="MainController" method="POST">
                                            <td>${counter.count}</td>
                                            <td>${request.requestID}</td>
                                            <td>${request.semesterID}</td>
                                            <td>${request.freeSlotID}</td>
                                            <td>${request.studentID}</td>
                                            <td>${request.studentName}</td>
                                            <td>${request.subjectCode}</td>
                                            <td>${request.startTime}</td>
                                            <td>${request.endTime}</td>
                                            <td>${request.description}</td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtSemesterID" 
                                                       value="${request.semesterID}" readonly="">
                                                <input type="hidden" name="txtFreeSlotID" 
                                                       value="${request.freeSlotID}" readonly="">
                                                <input type="hidden" name="txtStudentID" 
                                                       value="${request.studentID}" readonly="">
                                                <input type="hidden" name="txtSubjectCode" 
                                                       value="${request.subjectCode}" readonly="">
                                                <input type="hidden" name="txtStartTime" 
                                                       value="${request.startTime}" readonly="">
                                                <input type="hidden" name="txtEndTime" 
                                                       value="${request.endTime}" readonly="">

                                                <button type="submit" name="action"
                                                        value="AcceptRequest" class="btn-accept">Accept</button>
                                            </td>
                                            <td>
                                                <input class="form-control" type="text" name="txtNote" 
                                                       value="${param.txtNote}" placeholder="Note for Student">
                                            </td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtNote" 
                                                       value="${param.txtNote}" readonly="">
                                                <button type="submit" name="action"
                                                        value="DeleteRequest" class="btn-decline">Decline</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>  
                        <c:if test="${empty param.txtSubjectCode and not empty param.txtStartTime and not empty param.txtEndTime and not empty requestScope.SEARCH_REQUEST_BY_ST_ET}">
                            <div style="display: flex;
                                 justify-content: center;
                                 margin: auto;
                                 margin-top: 10%;">
                                <table class="custom-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Request ID</th>
                                            <th>Semester ID</th>
                                            <th>Free Slot ID</th>
                                            <th>Student ID</th>
                                            <th>Student's Name</th>
                                            <th>Subject Code</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Description</th>
                                            <th>Accept</th>
                                            <th>Note (If decline)</th>
                                            <th>Decline</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.SEARCH_REQUEST_BY_ST_ET}" 
                                                   var="request" varStatus="counter">
                                            <tr>
                                        <form action="MainController" method="POST">
                                            <td>${counter.count}</td>
                                            <td>${request.requestID}</td>
                                            <td>${request.semesterID}</td>
                                            <td>${request.freeSlotID}</td>
                                            <td>${request.studentID}</td>
                                            <td>${request.studentName}</td>
                                            <td>${request.subjectCode}</td>
                                            <td>${request.startTime}</td>
                                            <td>${request.endTime}</td>
                                            <td>${request.description}</td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtSemesterID" 
                                                       value="${request.semesterID}" readonly="">
                                                <input type="hidden" name="txtFreeSlotID" 
                                                       value="${request.freeSlotID}" readonly="">
                                                <input type="hidden" name="txtStudentID" 
                                                       value="${request.studentID}" readonly="">
                                                <input type="hidden" name="txtSubjectCode" 
                                                       value="${request.subjectCode}" readonly="">
                                                <input type="hidden" name="txtStartTime" 
                                                       value="${request.startTime}" readonly="">
                                                <input type="hidden" name="txtEndTime" 
                                                       value="${request.endTime}" readonly="">
                                                <input type="hidden" name="txtLinkMeet" 
                                                       value="${param.txtLinkMeet}" readonly="">
                                                <button type="submit" name="action"
                                                        value="AcceptRequest">Accept</button>
                                            </td>
                                            <td>
                                                <input type="text" name="txtNote" 
                                                       value="${param.txtNote}" placeholder="Note for Student">
                                            </td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtNote" 
                                                       value="${param.txtNote}" readonly="">
                                                <button type="submit" name="action"
                                                        value="DeleteRequest">Decline</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>  
                        <c:if test="${not empty param.txtSubjectCode and not empty param.txtStartTime and not empty param.txtEndTime and not empty requestScope.SEARCH_REQUEST_BY_ALL}">
                            <div style="display: flex;
                                 justify-content: center;
                                 margin: auto;
                                 margin-top: 10%;">
                                <table class="custom-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Request ID</th>
                                            <th>Semester ID</th>
                                            <th>Free Slot ID</th>
                                            <th>Student ID</th>
                                            <th>Student's Name</th>
                                            <th>Subject Code</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Description</th>
                                            <th>Accept</th>
                                            <th>Note (If decline)</th>
                                            <th>Decline</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.SEARCH_REQUEST_BY_ALL}" 
                                                   var="request" varStatus="counter">
                                            <tr>
                                        <form action="MainController" method="POST">
                                            <td>${counter.count}</td>
                                            <td>${request.requestID}</td>
                                            <td>${request.semesterID}</td>
                                            <td>${request.freeSlotID}</td>
                                            <td>${request.studentID}</td>
                                            <td>${request.studentName}</td>
                                            <td>${request.subjectCode}</td>
                                            <td>${request.startTime}</td>
                                            <td>${request.endTime}</td>
                                            <td>${request.description}</td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtSemesterID" 
                                                       value="${request.semesterID}" readonly="">
                                                <input type="hidden" name="txtFreeSlotID" 
                                                       value="${request.freeSlotID}" readonly="">
                                                <input type="hidden" name="txtStudentID" 
                                                       value="${request.studentID}" readonly="">
                                                <input type="hidden" name="txtSubjectCode" 
                                                       value="${request.subjectCode}" readonly="">
                                                <input type="hidden" name="txtStartTime" 
                                                       value="${request.startTime}" readonly="">
                                                <input type="hidden" name="txtEndTime" 
                                                       value="${request.endTime}" readonly="">
                                                <input type="hidden" name="txtLinkMeet" 
                                                       value="${param.txtLinkMeet}" readonly="">
                                                <button type="submit" name="action"
                                                        value="AcceptRequest">Accept</button>
                                            </td>
                                            <td>
                                                <input type="text" name="txtNote" 
                                                       value="${param.txtNote}" placeholder="Note for Student">
                                            </td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtNote" 
                                                       value="${param.txtNote}" readonly="">
                                                <button type="submit" name="action"
                                                        value="DeleteRequest">Decline</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>  
                        <c:if test="${not empty param.txtSubjectCode and empty param.txtStartTime and empty param.txtEndTime and not empty requestScope.SEARCH_REQUEST_BY_SUBJECT}">
                            <div style="display: flex;
                                 justify-content: center;
                                 margin: auto;
                                 margin-top: 10%;">
                                <table class="custom-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Request ID</th>
                                            <th>Semester ID</th>
                                            <th>Free Slot ID</th>
                                            <th>Student ID</th>
                                            <th>Student's Name</th>
                                            <th>Subject Code</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Description</th>
                                            <th>Accept</th>
                                            <th>Note (If decline)</th>
                                            <th>Decline</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.SEARCH_REQUEST_BY_SUBJECT}" 
                                                   var="request" varStatus="counter">
                                            <tr>
                                        <form action="MainController" method="POST">
                                            <td>${counter.count}</td>
                                            <td>${request.requestID}</td>
                                            <td>${request.semesterID}</td>
                                            <td>${request.freeSlotID}</td>
                                            <td>${request.studentID}</td>
                                            <td>${request.studentName}</td>
                                            <td>${request.subjectCode}</td>
                                            <td>${request.startTime}</td>
                                            <td>${request.endTime}</td>
                                            <td>${request.description}</td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtSemesterID" 
                                                       value="${request.semesterID}" readonly="">
                                                <input type="hidden" name="txtFreeSlotID" 
                                                       value="${request.freeSlotID}" readonly="">
                                                <input type="hidden" name="txtStudentID" 
                                                       value="${request.studentID}" readonly="">
                                                <input type="hidden" name="txtSubjectCode" 
                                                       value="${request.subjectCode}" readonly="">
                                                <input type="hidden" name="txtStartTime" 
                                                       value="${request.startTime}" readonly="">
                                                <input type="hidden" name="txtEndTime" 
                                                       value="${request.endTime}" readonly="">
                                                <input type="hidden" name="txtLinkMeet" 
                                                       value="${param.txtLinkMeet}" readonly="">
                                                <button type="submit" name="action"
                                                        value="AcceptRequest">Accept</button>
                                            </td>
                                            <td>
                                                <input type="text" name="txtNote" 
                                                       value="${param.txtNote}" placeholder="Note for Student">
                                            </td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtNote" 
                                                       value="${param.txtNote}" readonly="">
                                                <button type="submit" name="action"
                                                        value="DeleteRequest">Decline</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>  
                        <c:if test="${empty param.txtSubjectCode and empty param.txtStartTime and empty param.txtEndTime and not empty requestScope.SEARCH_REQUEST_BY_NULL}">
                            <div style="display: flex;
                                 justify-content: center;
                                 margin: auto;
                                 margin-top: 10%;">
                                <table class="custom-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Request ID</th>
                                            <th>Semester ID</th>
                                            <th>Free Slot ID</th>
                                            <th>Student ID</th>
                                            <th>Student's Name</th>
                                            <th>Subject Code</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Description</th>
                                            <th>Accept</th>
                                            <th>Note (If decline)</th>
                                            <th>Decline</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.SEARCH_REQUEST_BY_NULL}" 
                                                   var="request" varStatus="counter">
                                            <tr>
                                        <form action="MainController" method="POST">
                                            <td>${counter.count}</td>
                                            <td>${request.requestID}</td>
                                            <td>${request.semesterID}</td>
                                            <td>${request.freeSlotID}</td>
                                            <td>${request.studentID}</td>
                                            <td>${request.studentName}</td>
                                            <td>${request.subjectCode}</td>
                                            <td>${request.startTime}</td>
                                            <td>${request.endTime}</td>
                                            <td>${request.description}</td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtSemesterID" 
                                                       value="${request.semesterID}" readonly="">
                                                <input type="hidden" name="txtFreeSlotID" 
                                                       value="${request.freeSlotID}" readonly="">
                                                <input type="hidden" name="txtStudentID" 
                                                       value="${request.studentID}" readonly="">
                                                <input type="hidden" name="txtSubjectCode" 
                                                       value="${request.subjectCode}" readonly="">
                                                <input type="hidden" name="txtStartTime" 
                                                       value="${request.startTime}" readonly="">
                                                <input type="hidden" name="txtEndTime" 
                                                       value="${request.endTime}" readonly="">
                                                <input type="hidden" name="txtLinkMeet" 
                                                       value="${param.txtLinkMeet}" readonly="">
                                                <button type="submit" name="action"
                                                        value="AcceptRequest">Accept</button>
                                            </td>
                                            <td>
                                                <input type="text" name="txtNote" 
                                                       value="${param.txtNote}" placeholder="Note for Student">
                                            </td>
                                            <td>
                                                <input type="hidden" name="txtRequestID" 
                                                       value="${request.requestID}" readonly="">
                                                <input type="hidden" name="txtNote" 
                                                       value="${param.txtNote}" readonly="">
                                                <button type="submit" name="action"
                                                        value="DeleteRequest">Decline</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>  

                    </div>
                    <script>
                        // L?y thông tin l?i t? bi?n requestScope.ERROR
                        var errorMessage = "${requestScope.VIEW_REQUEST_MESSAGE}";

                        // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
                        if (errorMessage.trim() !== "") {
                            alert(errorMessage);
                        }
                    </script>

                </div>

            </div>
        </body>
        <% } else {
                response.sendRedirect("MainController?ation=");
            }
        %>
    </html>
