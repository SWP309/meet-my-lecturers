<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

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


        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {

        %>
        <script>
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
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
            function goBack() {
                window.history.back();
            }
        </script>
    </head>
    <body>
        <div class="admin-viewusersedited">
            <div class="admin-viewusers">
                <div class="fptu-eng-1-parent">
                    <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="returnHomePageLecturer" />
                        </form>
                        <img
                            class="fptu-eng-1-icon"
                            alt=""
                            src="public/BookingView/2021fptueng-1@2x.png"
                            />
                    </div>

                    <div class="frame-parent">
                        <div class="frame-group">
                            <div class="frame-Create CreateFSlot" onclick="submitFormCreate()">
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="CreateFS" />
                                </form>

                                <i class="material-icons">create</i> Create Free Slot
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
                            <div class="frame-div hideView" onclick="submitFormHideView()">
                                <form action="MainController" method="POST" style="display: none;">
                                    <input type="hidden" name="action" value="HideView" />
                                </form>
                                <div>
                                    <p class="HideView"><i class="fas fa-search"></i>Hide List</p>
                                </div>
                            </div>
                            <div>
                                <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                                     onclick="showUserInfo()" />
                                <div id="user-info" style="display: none; position: absolute">
                                    <p id="user-id"> </p>
                                    <p id="user-name"></p>
                                    <p id="user-email"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="backbutton"  onclick="goBack()">
                    <div class="back">Back</div>
                    <img class="back-icon" alt="" src="./public/request/back.svg" />
                </div>
                <div class="view-user-table">

                    <c:if test="${not empty requestScope.LIST_REQUESTS}">
                        <div style="display: flex;
                             justify-content: center;
                             margin: auto;
                             margin-top: 6%;">
                            <table border="1" class="table table-hover table-primary table-rounded">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>RequestID</th>
                                        <th>StudentID</th>
                                        <th>Student's Name</th>
                                        <th>Subject Code</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Description</th>
                                        <th>Accept</th>
                                        <th>Decline</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.LIST_REQUESTS}" 
                                               var="request" varStatus="counter">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${counter.count}</td>
                                        <td>${request.requestID}</td>
                                        <td>${request.studentID}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="user" items="${requestScope.LIST_REQUESTS_USERS}">
                                                <c:if test="${!breakLoop and request.studentID eq user.userID}">
                                                    ${user.userName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${request.subjectCode}</td>
                                        <td>${request.startTime}</td>
                                        <td>${request.endTime}</td>
                                        <td>${request.description}</td>
                                        <td>
                                            <input type="hidden" name="txtRequestID" 
                                                   value="${request.requestID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="AcceptRequest">Accept</button>
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtRequestID" 
                                                   value="${request.requestID}" readonly="">
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
                    <c:if test="${empty requestScope.LIST_REQUESTS}">
                        <h3 style="color: red">${requestScope.VIEW_REQUEST_MESSAGE}</h3>
                    </c:if>  
                </div>
            </div>

        </div>
    </body>
    <% }%>
</html>
