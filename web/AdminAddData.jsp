<%-- 
    Document   : index
    Created on : Oct 28, 2023, 1:20:11 AM
    Author     : Minh Khang
--%>
<%@page import="sample.subjects.SubjectDTO"%>
<%@page import="sample.subjects.SubjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.roles.RoleDAO"%>
<%@page import="sample.roles.RoleDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">-->
        <link rel="stylesheet" href="./AdminHome.css">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>File Upload</title>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                ArrayList<RoleDTO> listRole = RoleDAO.getAllRole();
//                ArrayList<SubjectDTO> listSub = SubjectDAO.getAllSubject();
                ArrayList<SubjectDTO> ListSubject = (ArrayList<SubjectDTO>) request.getAttribute("ListSubject");
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
            function submitAddForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "add"; // Set the option value for the "Add" button
                form.submit();
            }

            function submitRemoveForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "remove"; // Set the option value for the "Remove" button
                form.submit();
            }

            function submitUpdateForm() {
                var form = document.querySelector('.container form');
                var optionInput = document.querySelector('.container form input[name="option"]');
                optionInput.value = "update"; // Set the option value for the "Update" button
                form.submit();
            }
        </script>

        <style>


            .btn-primary{
                border-color: black;
            }
            #remove{
                background-color: #F27125;
            }
            #add{
                background-color: #0066B2;
            }
            #update{
                background-color: #0DB04B;
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
                    <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewUsers" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <i class="material-icons">event</i>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div request import"  style="background-color: #b7b7b7;">
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
                            <i class="material-icons">logout</i>
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
        <div class="container mt-5">
            <form action="MainController" method="POST">
                <div style="padding-right: 100px; display: inline-block">
                    Add new subject
                </div>
                <%
                    String Status = (String) request.getAttribute("Status");

                    if (Status != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= Status%>
                </span>
                <%
                    }
                %>
                <div class="form-group input-group">
                    <!--<input type="hidden" value="importTB" name="action">-->

                    <input type="text" class="form-control" name="txtsubject" placeholder="E.g: SWP391" required>
                    <input type="text" class="form-control" name="txtdescription" placeholder="E.g: Software development project" required>
                    <div class="input-group-append">
                        <button id="add" type="submit" value="AddSub" name="action" class="btn btn-primary custom-submit-button">Add</button>
                    </div>
                </div>
            </form>

            <form action="MainController" method="POST">
                <div style="padding-right: 100px; display: inline-block">
                    Add new User
                </div>
                <%
                    String AddUserStatus = (String) request.getAttribute("AddUserStatus");

                    if (AddUserStatus != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= AddUserStatus%>
                </span>
                <%
                    }
                %>
                <div class="form-group input-group">
                    <!--<input type="hidden" value="importTB" name="action">-->
                    <input type="text" class="form-control" name="txtuserid" placeholder="User ID" required>
                    <input type="text" class="form-control" name="txtusername" placeholder="User name (Nguyễn Văn A)" required>
                    <input type="text" class="form-control" name="txtuseremail" placeholder="User email (abc@fpt.edu.vn)" required>
                    <select class="form-control" name="txtuserrole">
                        <%
                            for (RoleDTO role : listRole) {
                        %> 
                        <option value="<%=  role.getRoleID()%>" > <%=  role.getRoleName()%>   </option> 
                        <% } %>
                    </select>
                    <div class="input-group-append">
                        <button id="add" type="submit" value="AddUser" name="action" class="btn btn-primary custom-submit-button">Add</button>
                    </div>
                </div>
            </form>
            <div class="row align-items-center justify-content-center">

                <form action="MainController" method="POST" class="d-flex justify-content-center" style=" margin-top: 10%;">
                    <div class="form-group">
                        <input type="text" class="form-control" name="txtInputSubject" placeholder="Input Subject">
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchsj">Search</button>
                    </div> <br>
                    <%
                        String RemoveStatus = (String) request.getAttribute("RemoveStatus");

                        if (RemoveStatus != null) {
                    %>
                    <span style="color: red; font-size: 1rem;">
                        <%= RemoveStatus%>
                    </span>
                    <%
                        }
                    %>
                </form>

            </div>
            <%
                if (ListSubject != null) {
            %>
            <form>
                <%
                    for (SubjectDTO sub : ListSubject) {
                %>
                <div class="form-group input-group">

                    <input type="hidden" class="form-control" name="txtoldcode" value="<%= sub.getSubjectCode()%>">
                    <input type="text" class="form-control" name="txtsubject" value="<%= sub.getSubjectCode()%>" required>
                    <input style="color: tomato" type="text" class="form-control" name="txtdescription" value="<%=  sub.getSubjectName()%>" required>
                    <div class="input-group-append">
                        <button id="update" type="submit" value="UpdateSub" name="action" class="btn btn-primary custom-submit-button">Update</button>
                    </div>
                    <div class="input-group-append">
                        <button id="remove" type="submit" value="RemoveSub" name="action" class="btn btn-primary custom-submit-button">Remove</button>
                    </div>
                </div>
                <%
                    }
                %>
            </form>
            <%
                }
            %>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <%
            } else {
                response.sendRedirect("MainController?action=");
            }
        %>
    </body>
</html>
