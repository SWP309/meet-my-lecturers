<%@page import="sample.users.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./request.css" />
        <!--        <link
                    rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap"
                    />-->
        <!--            <link
                    rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Lohit Tamil:wght@400&display=swap"
                    />-->
        <!--            <link
                    rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
                    />-->
        <!-- CSS c?a Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- CSS c?a Bootstrap 4 -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

        <!-- Icon -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <!--         Font Awesome -->
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

        <!-- ThÃªm liÃªn k?t ??n Bootstrap CSS -->
        <link
            rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            >
        <!-- Include Font Awesome CSS -->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">-->
        <style>
            *{
                margin: 0;
                padding: 0;
                border: 0;
                font-family: sans-serif;
            }
            h6 {
                border: none;
                margin-top: 4px;
                margin-bottom: 0px;
                padding: 2px;
                color: red;
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
        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitForm() {
                var form = document.querySelector('.bookingview form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
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
                    userInfo.style.display = "block"; // Hi?n th? thÃ´ng tin khi ???c nh?p chu?t
                } else {
                    userInfo.style.display = "none";
                }

                var userID = userDTO.userID;
                var userName = userDTO.userName;
                var userEmail = userDTO.userEmail;

                Swal.fire({
                    title: 'User Information',
                    html: '<b style="color: red;">User ID: </b>' + userID + '<br><b style="color: red;">User Name: </b>'
                            + userName + '<br><b style="color: red;">User Email: </b>' + userEmail
                });
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

    </head>
    <body>
        <div class="student-home">
            <div class="fptu-eng-1-parent">
                <div class="returnHome"> 
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
                            <div class="frame-div request" style="background-color: #b7b7b7;">
                                <form style="display: flex; justify-content: center;" action="MainController" method="POST">
                                    <input type="hidden" name="action" value="Request" />
                                    <i class="material-icons">mail_outline</i>
                                </form>
                                Request
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
            <div class="container mt-5 create-request" style="margin-top: 8% !important;">
                <form action="MainController" method="POST">


                    <div class="form-group row">
                        <label for="txtSemester" class="col-md-2 col-form-label"><strong>Semester:</strong></label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="txtSemester" name="txtSemester" value="${param.txtSemester}" placeholder="(ex:FA23)" required=""
                                   pattern="^(SP|SU|FA|)[0-9]{2}$">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtLecturer" class="col-md-2 col-form-label"><strong>Lecturer:</strong></label>
                        <div class="col-md-8">
                            <input type="text" class="form-control"  id="txtLecturer"  name="txtLecturer" value="${param.txtLecturer}" placeholder="GVxxxx" required=""
                                   pattern="^GV[0-9]{4}$">
                        </div>
                        <button class="btn btn-primary col-sm-2" type="submit" name="action" value="ViewTimetable">View Timetable</button>

                    </div>

                    <div class="form-group row">
                        <label for="txtSubjectCode" class="col-md-2 col-form-label"><strong>Subject code:</strong></label>
                        <div class="col-md-10">
                            <select class="form-control" name="txtSubjectCode">
                                <option value="PRJ301">PRJ301</option>
                                <option value="PRM392">PRM392</option>
                                <option value="SEP490">SEP490</option>
                                <option value="SWD392">SWD392</option>
                                <option value="SWP391">SWP391</option>
                                <option value="SWR302">SWR302</option>
                                <option value="SWT301">SWT301</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtStartTime" class="col-md-2 col-form-label"><strong>Start time:</strong></label>
                        <div class="col-md-10">
                            <input type="datetime-local" class="form-control" id="txtStartTime" name="txtStartTime" value="${param.txtStartTime}">
                        </div>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.currentDateError}">
                            <h6> ${requestScope.REQUEST_ERROR.currentDateError}</h6>
                        </c:if>
                    </div>
                    <div class="form-group row">
                        <label for="txtEndTime" class="col-md-2 col-form-label"><strong>End time:</strong></label>
                        <div class="col-md-10">
                            <input type="datetime-local" class="form-control" id="txtEndTime" name="txtEndTime" value="${param.txtEndTime}">
                        </div>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.endTimeError}">
                            <h6> ${requestScope.REQUEST_ERROR.endTimeError}</h6>
                        </c:if>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.durationError}">
                            <h6> ${requestScope.REQUEST_ERROR.durationError}</h6>
                        </c:if>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.semesterTimeError}">
                            <h6> ${requestScope.REQUEST_ERROR.semesterTimeError}</h6>
                        </c:if>
                    </div>
                    <div class="form-group row">
                        <label for="txtDescription" class="col-md-2 col-form-label"><strong>Description:</strong></label>
                        <div class="col-md-10">
                            <input type="text" style="font-family: sans-serif " class="form-control" id="txtDescription" name="txtDescription" value="${param.txtDescription}">
                        </div>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateRequestError}">
                            <h6> ${requestScope.REQUEST_ERROR.duplicateRequestError}</h6>
                        </c:if>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateFreeSlotError}">
                            <h6> ${requestScope.REQUEST_ERROR.duplicateFreeSlotError}</h6>
                        </c:if>
                        <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateTimetableError}">
                            <h6> ${requestScope.REQUEST_ERROR.duplicateTimetableError}</h6>
                        </c:if>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-10 offset-md-2">
                            <!--<div  onclick="submitFormSendRequest()">Send Request</div>-->
                            <button class="btn btn-success btn-lg rounded-pill" type="submit" name="action" value="CreateRequest">Send Request</button>
                        </div>
                    </div>
                </form>
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

        <!-- ThÃªm liÃªn k?t ??n Bootstrap JS vÃ  jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-KyZXEAg3QhqLMpG8r+J9pAEz6/LnYV5TOqDGIbpbzFq8qz5S7fF46kSEBzav6U7xj"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI"
            crossorigin="anonymous"
        ></script>
        <% } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
