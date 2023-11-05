<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./ViewUsers.css" />
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
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <script>
            function submitSearchForm() {
                var form = document.querySelector('.searchfunction form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
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
            .table-view {
                height: 100vh;
                overflow-y: auto;
            }
            .btn-accept {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                font-size: 14px;
            }

        </style>
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
                            <div class="frame-div ViewUsers"  style="background-color: #b7b7b7;">
                                <form action="MainController" method="POST" style="display: none;">
                                    <input type="hidden" name="action" value="ViewUsers" />
                                </form>
                                <div class="bookedslot-wrapper">
                                    <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                                    <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                                </div>
                                <div class="view-booking" >Search Users</div>
                            </div>
                            <div class="frame-div request import" onclick="submitFormImport()">
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="importPage" />
                                </form>
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
                                <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zm-1 4v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0z"/>
                                </svg>
                                Import Schedule

                            </div>
                            <div class="frame-div">
                                <div class="logout-wrapper">
                                    <img class="logout-icon1" alt="" src="./public/UsersView/logout1.svg" />
                                </div>
                                <div class="request">
                                    <p class="logout1">Logout</p>
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
                </div>


                <div class="row align-items-center justify-content-center">
                    <div>
                        <form action="MainController" method="POST" class="d-flex justify-content-center" style=" margin-top: 10%;">
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtSearchUserID" value="${param.txtSearchUserID}"  placeholder="Input UserID">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtName"  value="${param.txtName}" placeholder="Input Name">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="txtRoleID" value="${param.txtRoleID}" placeholder="RoleID">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="SearchUsers">Search</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="d-flex table-responsive" style="justify-content: center;   margin-top: 6%; text-align: center">
                    <c:if test="${not empty param.txtSearchUserID and empty param.txtName and empty param.txtRoleID and not empty requestScope.USERS_BY_USERID}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>Role</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS_BY_USERID}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_USERID}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="specific-input in_userID " type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="specific-input in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="specific-input in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="specific-input in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtSearchUserID" 
                                                   value="${param.txtSearchUserID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>
                    <c:if test="${not empty param.txtSearchUserID and not empty param.txtName and not empty param.txtRoleID and not empty requestScope.USERS_BY_ALL}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>Role</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS_BY_ALL}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_ALL}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="in_userID" type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtSearchUserID" 
                                                   value="${param.txtSearchUserID}" readonly="">
                                            <input type="hidden" name="txtName" 
                                                   value="${param.txtName}" readonly="">
                                            <input type="hidden" name="txtRoleID" 
                                                   value="${param.txtRoleID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>
                    <c:if test="${not empty param.txtRoleID and empty param.txtName and empty param.txtSearchUserID and not empty requestScope.USERS_BY_ROLEID}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>Role</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS_BY_ROLEID}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_ID}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="in_userID" type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtRoleID" 
                                                   value="${param.txtRoleID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>
                    <c:if test="${empty param.txtRoleID and not empty param.txtName and empty param.txtSearchUserID and not empty requestScope.USERS_BY_NAME}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>Role</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS_BY_NAME}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_NAME}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="in_userID" type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtName" 
                                                   value="${param.txtName}" readonly="">
                                            <button type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>
                    <c:if test="${not empty param.txtRoleID and not empty param.txtName and empty param.txtSearchUserID and not empty requestScope.USERS_BY_NAME_AND_ID}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>Role</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS_BY_NAME_AND_ID}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_NAME_AND_ID}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="in_userID" type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtName" 
                                                   value="${param.txtName}" readonly="">
                                            <input type="hidden" name="txtRoleID" 
                                                   value="${param.txtRoleID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>
                    <c:if test="${empty param.txtRoleID and empty param.txtName and empty param.txtSearchUserID and not empty requestScope.USERS}">
                        <div>
                            <table border="1" class="table-hover table-primary">
                                <thead class="table-danger">
                                    <tr>
                                        <th>No.</th>
                                        <th>RoleID</th>
                                        <th>Role Name</th>
                                        <th>UserID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.USERS}" 
                                               var="user" varStatus="status">
                                        <tr>
                                    <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>${user.roleID}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input class="in_userID" type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input class="in_userName" type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in_email" type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input class="in-password" type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <c:if test="${user.userStatus == 1}">
                                                <b>
                                                    Activated
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 0}">
                                                <b>
                                                    Banned
                                                </b>
                                            </c:if> 
                                            <c:if test="${user.userStatus == 2}">
                                                <b>
                                                    New
                                                </b>
                                            </c:if> 
                                        </td>
                                        <td>
                                            <!--<input type="hidden" name="action" value="SearchUsers">-->
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <button class="btn-accept" type="submit" name="action"
                                                    value="UpdateUsers">Update</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </c:if>      
                    <c:if test="${empty requestScope.USERS_BY_ROLEID and empty requestScope.USERS_BY_NAME and empty requestScope.USERS_BY_NAME_AND_ID and empty requestScope.USERS_BY_USERID and empty requestScope.USERS}">
                        <h3 style="color: red">${requestScope.VIEW_USERS_MESSAGE}</h3>
                    </c:if>  
                </div>
            

<!--            <div class="backbutton">
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="./public/UsersView/back.svg" />
            </div>-->
        
        <%                                } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
