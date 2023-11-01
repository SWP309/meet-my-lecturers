<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./ViewLecturer.css" />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
            />
        <!-- CSS c?a Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
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
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
        </script>
    </head>
    <body>
        <div class="student-lectures-schedule-edi">
            <div class="table-timetable" style="margin-right: 21%;
                 margin-top: 18%;
                 margin-left: -13%;
                 width: 92%;">
                <c:if test="${not empty requestScope.LIST_LECTURERS}">

                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.LIST_LECTURERS}" 
                                       var="lecturer" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${lecturer.userID}</td>
                                    <td>${lecturer.userName}</td>
                                    <td>${lecturer.userEmail}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${empty requestScope.LIST_LECTURERS}">
                    <h3 style="color: red">${requestScope.MESSAGE}</h3>
                </c:if>

            </div>
            <div class="backbutton"  onclick="goBack()">
                <div class="back"><p class="backWord" style="margin-left: 45px;">Back</p></div>
                <img class="back-icon" alt="" src="./public/request/back.svg" />
            </div>
            <div class="header1">
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

                        <div class="frame-div logout" onclick="submitFormLogout()">
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
                    </div>
                    <div>
                        <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                             onclick="showUserInfo()"  style="cursor: pointer"/>
                        <div id="user-info" style="display: none; position: absolute">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
                response.sendRedirect("MainController");
            }
        %>
    </body>
</html>
