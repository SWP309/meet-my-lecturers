<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <script>
            function submitSearchForm() {
                var form = document.querySelector('.searchfunction form');
                form.submit();
            }
        </script>
        <style>
            .table-view {
                height: 100vh;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <div class="admin-viewusersedited">
            <div class="admin-viewusers">
                <div class="fptu-eng-1-parent">
                    <img
                        class="fptu-eng-1-icon1"
                        alt=""
                        src="./public/UsersView/2021fptueng-11@2x.png"
                        />

                    <div class="frame-parent">
                        <div class="frame-group">
                            <div class="frame-container">
                                <div class="wrapper">
                                    <div class="div">+</div>
                                </div>
                                <div class="div add-new-user">Add new User</div>
                            </div>
                            <div class="frame-div">
                                <div class="logout-wrapper">
                                    <img class="logout-icon1" alt="" src="./public/UsersView/logout1.svg" />
                                </div>
                                <div class="div">
                                    <p class="logout2">Logout</p>
                                </div>
                            </div>
                        </div>
                        <img class="frame-child" alt="" src="./public/UsersView/group-33.svg" />
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

                <div class="d-flex table table-responsive" style="justify-content: center;   margin-top: 6%;">
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
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
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
                                        </td>
                                        <td>
                                            <!--<input type="hidden" name="action" value="SearchUsers">-->
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
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
                    <c:if test="${empty requestScope.USERS_BY_ROLEID and empty requestScope.USERS_BY_NAME and empty requestScope.USERS_BY_NAME_AND_ID and empty requestScope.USERS_BY_USERID and empty requestScope.USERS}">
                        <h3 style="color: red">${requestScope.VIEW_USERS_MESSAGE}</h3>
                    </c:if>  
                </div>
            </div>

            <div class="backbutton">
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="./public/UsersView/back.svg" />
            </div>
        </div>
    </body>
</html>
