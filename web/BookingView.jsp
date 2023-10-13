<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./BookingView.css" />
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
        %>
        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
                    window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
                }
            }
            function submitFormLogout() {
                var form = document.querySelector('.frame-div form')
                form.submit();
            }
            function submitFormRequest() {
                var form = document.querySelector('.request form');
                form.submit();
            }
            var userDTO = {
                userID: "<%= us.getUserID()%>",
                userName: "<%= us.getUserName()%>",
                userEmail: "<%= us.getUserEmail()%>"
            };
            function showUserInfo() {
                var userInfo = document.getElementById("user-info");
                // Thay ??i n?i dung thông tin ng??i dùng ? ?ây b?ng d? li?u t? UserDTO
//                document.getElementById("user-id").textContent = "User ID: " + userDTO.userID;
//                document.getElementById("user-name").textContent = "User Name: " + userDTO.userName;
//                document.getElementById("user-email").textContent = "User Email: " + userDTO.userEmail;

                userInfo.style.display = "block"; // Hi?n th? thông tin ng??i dùng
                var userID = userDTO.userID;
                var userName = userDTO.userName;
                var userEmail = userDTO.userEmail;

                Swal.fire({
                    title: 'User Information',
                    html: '<b style="color: red;">User ID: </b>' + userID + '<br><b style="color: red;">User Name: </b>'
                            + userName + '<br><b style="color: red;">User Email: </b>' + userEmail,
                });
            }


            function hideUserInfo() {
                var userInfo = document.getElementById("user-info");
                userInfo.style.display = "none"; // ?n thông tin ng??i dùng khi r?i chu?t ra kh?i hình ?nh
            }
            function confirmCancel() {
                var result = confirm("Are you sure about cancel your booking ?");
                if (result) {
                    // N?u ng??i dùng ch?n OK, chuy?n ??n trang MainController ?? x? lý hành ??ng "cancel".
                    // Ví d?:
                    window.location.href = "MainController?action=cancel&bookingID=" + document.querySelector('[name="bookingID"]').value;
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
                        <div class="frame-div request" onclick="submitFormRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                            </form>

                            <i class="material-icons">mail_outline</i> Request
                        </div>
                        <div class="frame-div" onclick="submitFormLogout()">
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
                        <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                             onmouseover="showUserInfo()" onmouseout="hideUserInfo()" />
                        <div id="user-info" style="display: none;">
                            <p id="user-id">User ID: <span></span></p>
                            <p id="user-name">User Name: <span></span></p>
                            <p id="user-email">User Email: <span></span></p>
                        </div>
                    </div>

                </div>
            </div>


            <div class="boxoftable">
                <c:if test="${requestScope.LIST_BOOKING !=null}">
                    <c:if test="${not empty requestScope.LIST_BOOKING}">
                        <table class="table table-hover table-primary table-rounded">
                            <thead>
                                <tr class="table-danger">
                                    <th>No</th>
                                    <th>Subject Code</th>
                                    <th>Lecturer's Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Cancel</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="MainController" method="POST">
                                <c:forEach var="bookings" varStatus="counter" items="${requestScope.LIST_BOOKING}">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            <span>${bookings.subjectCode}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.lectureName}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.startTime}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.endTime}</span>
                                        </td>
                                        <td>
                                            <input type="hidden" name="bookingID" value="${bookings.bookingID}">
                                            <button type="submit" class="btn btn-danger center-content" onclick="confirmCancel()" > 
                                                <i class="material-icons">cancel</i> Cancel</button>

                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>

                            </tbody>
                        </table>

                    </c:if>
                </c:if>
            </div>
            <div class="backbutton" onclick="submitFormBack()">
                <form action="MainController" method="POST" style="display: none;">
                    <input type="hidden" name="action" value="back" />
                </form>
                <div class="back" id="back-button">Back</div>
                <img class="back-icon" alt="" src="public/BookingView/back.svg" />
            </div>
        </div>
        <h3>
            ${requestScope.ERROR}
        </h3> 
    </body>
</html>
