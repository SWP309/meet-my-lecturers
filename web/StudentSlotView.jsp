<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./StudentSlotView.css" />
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


        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");

            if (us != null) {
        %>
        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
                    window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
                }
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
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
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormViewRequest() {
                var form = document.querySelector('.request-div form');
                form.submit();
            }
            function submitFormHideView() {
                var form = document.querySelector('.hideView form');
                form.submit();
            }
            function submitForm() {
                var form = document.querySelector('.viewCreateSlot form');
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

            function confirmDelete() {
                var result = confirm("Are you sure about delete this Free Slot ?");
                console.log(result);
                if (result) {
                    // N?u ng??i dùng ch?n OK, chuy?n ??n trang MainController ?? x? lý hành ??ng "cancel".
                    // Ví d?:
                    window.location.href = "MainController?action=delete&freeSlotID=2";
//                   window.location.href = "MainController?action=delete&freeSlotID=" + document.querySelector('[name="freeSlotID"]').value;
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
                    // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
                    event.preventDefault();
                }
            }
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }

        </script>
    </head>
    <body>
        <div class="student-viewbookedslot">
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
                        <div class="frame-div request-div" style="background-color: #b7b7b7;">
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
                                <i class="material-icons">logout</i>
                            </div>
                            <div class="logout">
                                <p class="logout1">Logout</p>
                            </div>
                        </div>

                        <div>
                            <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                                 onclick="showUserInfo()" />
                            <div id="user-info" style="display: none;
                                 position: absolute;">
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


            <div class="boxoftable"style=" margin-top: -30%;">
                <c:if test="${requestScope.LIST_STUDENT !=null}">
                    <c:if test="${not empty requestScope.LIST_STUDENT}">
                        <table class="table table-hover table-primary table-rounded">
                            <thead>
                                <tr class="table-danger">
                                    <th>No</th>
                                    <th>Student ID</th>
                                    <th>Student's Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="MainController" method="POST">
                                <c:forEach var="liststudent" varStatus="counter" items="${requestScope.LIST_STUDENT}">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            <span>${liststudent.studentID}</span>
                                        </td>
                                        <td>
                                            <span>${liststudent.studentName}</span>
                                        </td>
                                        <td>
                                            <span>${liststudent.startTime}</span>
                                        </td>
                                        <td>
                                            <span>${liststudent.endTime}</span>
                                        </td>

                                    </tr>
                                </form>
                            </c:forEach>

                            </tbody>
                        </table>
                    </c:if>
                </c:if>

            </div>
        </div>

        <script>
            // L?y thông tin l?i t? bi?n requestScope.ERROR
            var errorMessage = "${requestScope.ERROR}";

            // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
            if (errorMessage.trim() !== "") {
                alert(errorMessage);
            }
        </script>
        <%
            } else {
                response.sendRedirect("MainController");
            }
        %>
    </body>
</html>
