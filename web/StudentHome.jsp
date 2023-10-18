<%-- 
    Document   : StudentHome
    Created on : Oct 10, 2023, 9:25:31 PM
    Author     : Minh Khang
--%>
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

        <link rel="stylesheet" href="./StudentHome.css" />
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
        <link rel="stylesheet" href="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation-prototype.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet" type="text/css">

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
            function submitForm() {
                var form = document.querySelector('.bookingview form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
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

//
//            function hideUserInfo() {
//                var userInfo = document.getElementById("user-info");
//                userInfo.style.display = "none"; // ?n thông tin ng??i dùng khi r?i chu?t ra kh?i hình ?nh
//            }
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
                var form = document.querySelector('.backbutton form');
                form.submit();
            }

        </script>
    </head>
    <body>
        <div class="student-home">
            <div class="fptu-eng-1-parent">
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-div bookingview" onclick="submitForm()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewBooking" />
                            </form>
                            <div class="bookedslot-wrapper">
                                <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                                <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                            </div>
                            <div class="view-booking" >View Booking</div>
                        </div>
                        <div class="frame-div request" onclick="submitFormRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                            </form>

                            <i class="material-icons">mail_outline</i> Request
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
                        <img class="frame-item" alt="" src="./public/StudentHome/group-33.svg" 
                             onclick="showUserInfo()" />
                        <div id="user-info" style="display: none;">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
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
            <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="" data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;" data-resize="co1gk1-orbit" id="co1gk1-orbit" data-e="3gpl68-e" data-events="resize">
                <ul class="orbit-container" tabindex="0" style="height: 530.4px;">
                    <button class="orbit-previous" tabindex="0"><span class="show-for-sr">Previous Slide</span>&#9664;</button>
                    <button class="orbit-next" tabindex="0"><span class="show-for-sr">Next Slide</span>&#9654;</button>
                    <li class="orbit-slide" data-slide="0" style="display: none; position: relative; top: 0px;">
                        <img class="orbit-image" src="./public/StudentHome/anh1.jpg"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">FPT University</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="1" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh3.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Ceremony</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="2" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh4.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Orientation Week</figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="3" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh5.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">F-Camp</figcaption>
                    </li>
                    <li class="orbit-slide is-active" data-slide="4" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh6.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                    <figcaption class="orbit-caption">Training at the military</figcaption>
                    </li>
                </ul>
                <nav class="orbit-bullets">
                    <button class="" data-slide="0"><span class="show-for-sr">First slide details.</span></button>
                    <button data-slide="1" class=""><span class="show-for-sr">Second slide details.</span></button>
                    <button data-slide="2" class=""><span class="show-for-sr">Third slide details.</span></button>
                    <button data-slide="3" class=""><span class="show-for-sr">Third slide details.</span></button>
                    <button data-slide="4" class="is-active"><span class="show-for-sr">Fourth slide details.</span><span class="show-for-sr">Current Slide</span></button>
                </nav>
            </div>


        </div>

    </div>
    <h3>
        ${requestScope.ERROR}
    </h3> 

    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/js/foundation.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.js"></script>
    <script>
                $(document).foundation();
    </script>
</body>
</html>

