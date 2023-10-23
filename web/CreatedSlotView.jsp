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

        <link rel="stylesheet" href="./CreatedSlotView.css" />
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
            function submitFormViewRequest() {
                var form = document.querySelector('.request form');
                form.submit();
            }
            function submitFormHideView() {
                var form = document.querySelector('.hideView form');
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
            function submitFormBack() {
                var form = document.querySelector('.backbutton form')
                form.submit();
            }

        </script>
        <style>
            td {
                position: relative;
            }

            input[type="text"] {
                width: 100%;
                box-sizing: border-box;
                position: absolute;
                top: 0;
                left: 0;
                bottom: 0;
                right: 0;
                font-size: 14px;
                text-align: center;
                background-color: #cfe2ff;
                border: none; /* Lo?i b? vi?n */
            }
            button[type="submit"]{
                border: none; /* Lo?i b? vi?n */
                background-color: #cfe2ff;
                color: #007bff;
            }
        </style>
    </head>
    <body>
        <div class="student-viewbookedslot">
            <div class="fptu-eng-1-parent">
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-div request" onclick="submitFormViewRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewRequest" />
                            </form>

                            <i class="material-icons">mail_outline</i>View Request(10)
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
                            <div id="user-info" style="display: none;">
                                <p id="user-id"> </p>
                                <p id="user-name"></p>
                                <p id="user-email"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="backbutton" onclick="submitFormBack()">
                <form action="MainController" method="POST" style="display: none;">
                    <input type="hidden" name="action" value="back" />
                </form>
                <div class="back" id="back-button">Back</div>
                <img class="back-icon" alt="" src="public/BookingView/back.svg" />
            </div>

            <div class="table-container">
                <c:if test="${requestScope.LIST_CREATED_SLOT !=null}">
                    <c:if test="${not empty requestScope.LIST_CREATED_SLOT}">
                        <table class="table table-hover table-primary table-rounded">
                            <thead>
                                <tr class="table-danger">
                                    <th>No</th>
                                    <th>Subject Code</th>
                                    <th>Lecturer's Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Hide</th>
                                    <th>Delete</th>
                                    <th>View</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="MainController" method="POST">
                                <c:forEach var="listCreatedSlot" varStatus="counter" items="${requestScope.LIST_CREATED_SLOT}">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            <input type="text" name="subjectCode" value="${listCreatedSlot.subjectCode.trim()}" required=""/>
                                        </td>
                                        <c:if test="${counter.count == 1}">
                                            <td class="merged-row" style="text-align: center;
                                                vertical-align: middle !important;
                                                height: 100px!important;" rowspan="${requestScope.LIST_CREATED_SLOT.size()}">
                                                <span>${listCreatedSlot.lectureName}</span>
                                            </td>
                                        </c:if>
                                        <td>
                                            <input type="text" name="startTime" value="${listCreatedSlot.startTime}" required=""/>
                                        </td>
                                        <td>
                                            <input type="text" name="endTime" value="${listCreatedSlot.endTime}" required=""/>
                                        </td>
                                        <td>
                                            <a style="display: flex; text-decoration: none; justify-content: center;" onclick="return confirm('Are you sure to hide this Free Slot')"
                                               href="MainController?action=hideFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                <i class="material-icons">cancel</i>Hide</a>

                                        </td>
                                        <td>
                                            <a style="display: flex; text-decoration: none; justify-content: center;" onclick="return confirm('Are you sure to delete this Free Slot')"
                                               href="MainController?action=deleteFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                <i class="material-icons">delete</i>Delete</a>

                                        </td>
                                        <td>
                                            <a style="display: flex; text-decoration: none; justify-content: center;"
                                               href="MainController?action=viewFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                <i class="fas fa-search"></i>View</a>

                                        </td>
                                        <td>
                                            <!--                                                                                        <a style="display: flex; text-decoration: none; justify-content: center;"
                                                                                                                                       href="MainController?action=updateFS&freeSlotID=${listCreatedSlot.freeSlotID}&subjectCode=${listCreatedSlot.subjectCode}&startTime=${listCreatedSlot.startTime}&endTime=${listCreatedSlot.endTime}">
                                                                                                                                        <i class="material-icons">update</i>Update</a>-->
                                            <form action="MainController" method="GET">
                                                <input type="hidden" name="action" value="updateFS">
                                                <input type="hidden" name="freeSlotID" value="${listCreatedSlot.freeSlotID}">
                                                <input type="hidden" name="subjectCode" value="${listCreatedSlot.subjectCode.trim()}" required/>
                                                <input type="hidden" name="startTime" value="${listCreatedSlot.startTime}">
                                                <input type="hidden" name="endTime" value="${listCreatedSlot.endTime}">
                                                <button type="submit" style="display: flex; text-decoration: none; justify-content: center;">
                                                    <i class="material-icons">update</i>Update
                                                </button>
                                            </form>

                                        </td>


                                    </tr>
                                </form>
                            </c:forEach>

                            </tbody>
                        </table>
                    </c:if>
                </c:if>
            </div>
           
            <h3>
                <span class="error-message">
                    ${requestScope.ERROR}
                </span>
            </h3> 

            <script>
                // L?y thông tin l?i t? bi?n requestScope.ERROR
                var errorMessage = "${requestScope.ERROR}";

                // Ki?m tra n?u errorMessage không r?ng, hi?n th? h?p tho?i c?nh báo
                if (errorMessage.trim() !== "") {
                    alert(errorMessage);
                }
            </script>
    </body>
</html>
