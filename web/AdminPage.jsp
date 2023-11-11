<%-- 
    Document   : AdminPage
    Created on : Oct 24, 2023, 1:50:25 AM
    Author     : Minh Khang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />



        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormViewUsers() {
                var form = document.querySelector('.ViewUsers form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormImport() {
                var form = document.querySelector('.import form');
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
        <style>
            .textDashBoard{
                font-family: 'Agbalumo', 'Playfair Display', sans-serif;
            }
        </style>

        <title>Dashboard</title>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageAdmin" />
                </form>
            </div>

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewUsers" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                            <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div import" onclick="submitFormImport()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="importPage" />
                        </form>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
                        <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zm-1 4v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0z"/>
                        </svg>
                        Import Schedule

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

        <div class="container mt-4">
            <h1 class="text-center textDashBoard">Dashboard</h1>
            <p class="text-danger text-center mt-2">${requestScope.MSG}</p>

            <div class="container mt-5" style="width: 80%; border-radius: 10px">

                <div class="row" style="border-radius: 10px">
                    <div class="col"  class="tab" style="border-radius: 10px;">
                        <div class="row" style="border-radius: 10px;">
                            <div class="col"  >
                                <button class="tablinks active" 
                                        style="background-color:#f27125; color: white;border: solid 2px #f27125; 
                                        border-radius: 10px;text-align: center;width: 120px;height: 53px; margin: 0 10px 10px 0;"
                                        ><b>Top Student Cancel</b></button>
                            </div>
                            <div class="col"  >
                                <button class="tablinks" 
                                        style="background-color:#f27125; color: white;border: solid 2px #f27125; 
                                        border-radius: 10px;text-align: center;width: 120px;height: 53px; margin: 0 10px 10px 0;"
                                        ><b>Top Student Absent</b></button>  
                            </div>
                        </div>
                        <div class="row" style="border-radius: 10px;">
                            <div class="col" >
                                <button class="tablinks" style="background-color:#f27125; color: white;border: solid 2px #f27125; border-radius: 10px; text-align: center;width: 120px;height: 53px"><b>Most Free Slot</b></button> 
                            </div>
                            <div class="col" >
                                <button class="tablinks " style="background-color:#f27125; color: white;border: solid 2px #f27125; border-radius: 10px;text-align: center;width: 120px;height: 53px"><b>Most Request</b></button> 
                            </div>
                        </div>
                    </div>
                    <div id="Top Student Cancel" class="tabcontent">
                        <div class="col d-flex" 
                             style="border: 4px solid #f27125; margin-top: 30px; border-radius: 10px; text-align: center; justify-content: space-around"
                             >
                            <table style="align-items: center; height: 208px; width: 400px; margin-top: -70px">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Number</th>
                                        <th>Ban</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.Top5StuMaxCancelNum}" var="booking">
                                        <tr>
                                            <td class="px-5"><a href="MainController?action=SearchStatistics&txtStudentID=${booking.studentID}&check=2">${booking.studentID}</a></td>
                                            <td class="px-5">${booking.numberOfCancelSlot}</td>
                                            <td class="px-5"><a href="MainController?action=BanUser&txtStudentID=${booking.studentID}"><span class="material-symbols-outlined">Cancel</span></a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>

                    <div id="Top Student Absent" class="tabcontent">
                        <div class="col d-flex" 
                             style="border: 4px solid #f27125; border-radius: 10px; text-align: center; justify-content: space-around"
                             >
                            <table style="align-items: center; height: 168px; width: 400px">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Number</th>
                                        <th>Ban</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.Top5StuMaxAbsentNum}" var="booking">
                                        <tr>
                                            <td class="px-5"><a href="MainController?action=SearchStatistics&txtStudentID=${booking.studentID}&check=1">${booking.studentID}</a></td>
                                            <td class="px-5">${booking.numberOfAbsenceSlot}</td>
                                            <td class="px-5"><a href="MainController?action=BanUser&txtStudentID=${booking.studentID}"><span class="material-symbols-outlined">Cancel</span></a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                    <div id="Most Free Slot" class="tabcontent">
                        <div class="col d-flex" 
                             style="border: 4px solid #f27125; border-radius: 10px; text-align: center; justify-content: space-around"
                             >
                            <table style="align-items: center;height: 168px; width: 400px">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Number</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.Top5LecCreatedMaxSlot}" var="user">
                                        <tr>
                                            <td class="px-5"><a href="MainController?action=SearchStatistics&txtLecturerID=${user.userID}&check=3">${user.userID}</a></td>
                                            <td class="px-5">${user.createdSlot}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                    <div id="Most Request" class="tabcontent">
                        <div class="col d-flex" 
                             style="border: 4px solid #f27125; border-radius: 10px; text-align: center; justify-content: space-around"
                             >
                            <table style="align-items: center;height: 168px; width: 350px">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Number</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.Top5LecReceivedMaxRequest}" var="user">
                                        <tr>
                                            <td class="px-5"><a href="MainController?action=SearchStatistics&txtLecturerID=${user.userID}&check=4">${user.userID}</a></td>
                                            <td class="px-5">${user.receivedRequest}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${empty Top5StuMaxCancelNum}">
                <h4 style="color: red;">${requestScope.MAX_CANCEL_MESSAGE}</h3>
            </c:if>   
            <c:if test="${empty Top5StuMaxAbsentNum}">
                <h4 style="color: red;">${requestScope.MAX_ABSENT_MESSAGE}</h3>
            </c:if>   
            <c:if test="${empty Top5LecCreatedMaxSlot}">
                <h4 style="color: red;">${requestScope.MAX_FS_MESSAGE}</h3>
            </c:if>   
            <c:if test="${empty Top5LecReceivedMaxRequest}">
                <h4 style="color: red;">${requestScope.MAX_REQUEST_MESSAGE}</h3>
            </c:if> 



            <!--            <div class="row mt-4">
                            <div class="col-md-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <h5 class="card-title">Sinh viên <span style="color: red" >ĐẶT NHIỀU SLOT NHẤT</span></h5>                              
                                        </div>                            
                                        <p class="mt-2">Số lượt đặt: <b style="color: red">${requestScope.UserMaxSlot.number}</b></p>
                                        <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxSlot.userID}</b></p>
                                    </div>
                                </div>
                            </div>
            
            
                            <div class="col-md-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <h5 class="card-title">Sinh viên GỬI <span style="color: red" >NHIỀU REQUEST NHẤT</span></h5>
            
                                        </div>
            
                                        <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.UserMaxRequest.number}</b></p>
                                        <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxRequest.userID}</b></p>
                                    </div>
                                </div>
                            </div>
                                    <div class="col-md-6" style="height: 500px; background-color: green;">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <h5 class="card-title">wqeqw <span style="color: red" >NHIỀU REQUEST NHẤT</span></h5>
            
                                        </div>
            
                                        <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.UserMaxRequest.number}</b></p>
                                        <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxRequest.userID}</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
            
                        <div class="row mt-4">
                            <div class="col-md-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <h5 class="card-title">Giảng viên <span style="color: red" >TẠO NHIỀU SLOT NHẤT</span></h5>
            
                                        </div>
            
                                        <p class="mt-2">Số lượt tạo slot: <b style="color: red">${requestScope.LecturerMaxSlot.number}</b></p>
                                        <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxSlot.userID}</b></p>
                                    </div>
                                </div>
                            </div>
            
                            <div class="col-md-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <h5 class="card-title">Giảng viên <span style="color: red" >NHẬN ĐƯỢC NHIỀU REQUEST NHẤT</span></h5>
            
                                        </div>
            
                                        <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.LecturerMaxRequest.number}</b></p>
                                        <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxRequest.userID}</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>-->

        </div>

        <script type="text/javascript">
            var buttons = document.getElementsByClassName('tablinks');
            var contents = document.getElementsByClassName('tabcontent');
            function showContent(id) {
                for (var i = 0; i < contents.length; i++) {
                    contents[i].style.display = 'none';
                }
                var content = document.getElementById(id);
                content.style.display = 'block';
            }
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].addEventListener("click", function () {
                    var id = this.textContent;
                    for (var i = 0; i < buttons.length; i++) {
                        buttons[i].classList.remove("active");
                    }
                    this.className += " active";
                    showContent(id);
                });
            }
            showContent('Top Student Cancel');
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <%            } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
