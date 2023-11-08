<%-- 
    Document   : send-email
    Created on : Nov 5, 2023, 6:28:48 PM
    Author     : W10(hiep-tm)
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Email Form</title>
        <link rel="stylesheet" href="./createfreeSlot.css" />
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
        <!-- Thêm liên kết đến Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <!-- Thêm liên kết đến Bootstrap JS và jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+J9pAEz6/LnYV5TOqDGIbpbzFq8qz5S7fF46kSEBzav6U7xj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
        <style>
            .card-body {
                display: flex;
                flex-direction: column;
                justify-content: space-around;
            }
            h6 {
                border: none;
                margin-top: 4px;
                margin-bottom: 0px;
                padding: 2px;
                color: red;
            }
            .d-flex > input {
                width: 60%;
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
            @media (min-width: 768px){
                .col-md-6 {
                    -ms-flex: 0 0 50%;
                    flex: 0 0 50%;
                    max-width: 39%;
                }
            }
            .option{
                width: 60%;

            }
        </style>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
        %>
        <script>
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormViewRequest() {
                var form = document.querySelector('.request-div form');
                form.submit();
            }
            function submitForm() {
                var form = document.querySelector('.viewCreateSlot form');
                form.submit();
            }
            function submitFormHideView() {
                var form = document.querySelector('.hideView form');
                form.submit();
            }
            function submitFormHistory() {
                var form = document.querySelector('.history form');
                form.submit();
            }
            function submitFormSendEmail() {
                var form = document.querySelector('.sendMail form');
                form.submit();
            }
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
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
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormViewRequest() {
                var form = document.querySelector('.request-div form');
                form.submit();
            }

        </script>

        <script>
            function updateHiddenField(selectElement, hiddenFieldId) {
                var selectedValue = selectElement.value;
                document.getElementById(hiddenFieldId).value = selectedValue;
            }
        </script>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageLecturer" />
                </form>
            </div>
            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div viewCreateSlot" onclick="submitForm()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="viewFSlotLecturer" />
                        </form>
                        <i class="material-icons">visibility</i>View Create Slot
                    </div>
                    <div class="frame-div request-div" onclick="submitFormViewRequest()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="ViewRequest" />
                        </form>

                        <i class="material-icons">mail_outline</i>View Request
                    </div>
                    <div class="frame-div hideView" onclick="submitFormHideView()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="HideView" />
                        </form>
                        <div>
                            <p class="HideView"><i class="fas fa-search"></i>Hide List</p>
                        </div>
                    </div>
                    <div class="frame-div logout" style="text-align: center;" onclick="submitFormLogout()">
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

                    <div>
                        <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                             onclick="showUserInfo()" />
                        <div id="user-info" style="display: none; position: absolute;">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="container-div" style=" display: flex;
             flex-direction: column; float: right;">
            <div class="frame-choice CreateFSlot" style="cursor: pointer; color: white" onclick="submitFormCreate()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="CreateFS" />
                </form>

                <i class="material-icons">add</i>
            </div>
            <div class="frame-choice history" style="cursor: pointer; color: white" onclick="submitFormHistory()">
                <form action="MainController" method="POST">

                    <input type="hidden" name="action" value="historyLec" />
                </form>

                <i class="material-icons">history</i>
            </div>
            <div class="frame-choice sendMail" style="cursor: pointer; color: white"  onclick="submitFormSendEmail()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="SendEmailForRemindStudent" />
                </form>

                <i class="material-icons">send</i>
            </div>
        </div>

        <c:if test="${sessionScope.loginedUser != null && sessionScope.loginedUser.roleID == '2'}"></c:if>
            <div class="container mt-5 div-CreateFS">
                <div class="d-flex justify-content-center">
                    <div class="card" style="border-radius: 5%; width: 800px; max-height: 800px;">
                        <div class="card-body">
                            <form action="MainController" method="POST">

                                <div class="d-flex justify-content-between"><strong>Recipient:</strong> <input type="text" class="form-control" name="txtRecipient" value="${param.txtRecipient}" required=""></div>
                            <div class="d-flex justify-content-between"><strong>Subject Code:</strong> <input type="text" class="form-control" name="txtSubjectCode" value="${param.txtSubjectCode}" required=""></div>
                            <div class="d-flex justify-content-between"><strong>Start Time:</strong> <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}" required=""></div>
                            <div class="d-flex justify-content-between"><strong>End Time:</strong> <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}" required=""></div>
                            <div class="d-flex justify-content-between"><strong>Password(access code of your free slot):</strong> <input type="text" class="form-control" name="txtPassword" value="${param.txtPassword}" required=""></div>
                            <div class="d-flex justify-content-between"><strong>Message(optional):</strong> <textarea style="width: 60%" name="txtMessage" rows="10" cols="60"></textarea></div>

                            <div class="d-flex justify-content-center btn-book">
                                <input type="hidden" value="sendEMailAction" name="action"/>
                                <input type="submit" class="btn btn-primary" value="Send email">
                            </div>

                            <input type="hidden" value="${param.txtPassword}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${sessionScope.loginedUser == null || sessionScope.loginedUser.roleID != '2' }">
            <c:redirect url="LoginFeID.jsp"> </c:redirect>
        </c:if>
        <% }%>
    </body>
</html>

