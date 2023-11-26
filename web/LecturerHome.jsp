<%-- 
    Document   : LecturerHome
    Created on : Nov 23, 2023, 9:35:57 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDTO"%>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./LecturerPage.css" />
        <link rel="stylesheet" href="./LecturerHome.css" />
        <script src="./lecturer.js"></script>
        <!-- Google Fonts - Poppins -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap">

        <!-- Google Fonts - Lohit Tamil -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lohit Tamil:wght@400&display=swap">

        <!-- Google Fonts - Lexend -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap">

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- Font Awesome 6 Beta 3 CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- Foundation Min CSS -->
        <link rel="stylesheet" href="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">

        <!-- Motion UI CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.css">

        <!-- Foundicons CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet" type="text/css">

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <!-- Font Awesome 6 Beta 3 JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>

        <!-- Foundation JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/js/foundation.min.js"></script>

        <!-- Motion UI JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.js"></script>

        <!-- Owl Carousel JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

        <!-- Icon -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!------text gg ----->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">


        <!-- Facebook and Twitter integration -->
        <meta property="og:title" content=""/>
        <meta property="og:image" content=""/>
        <meta property="og:url" content=""/>
        <meta property="og:site_name" content=""/>
        <meta property="og:description" content=""/>
        <meta name="twitter:title" content="" />
        <meta name="twitter:image" content="" />
        <meta name="twitter:url" content="" />
        <meta name="twitter:card" content="" />
        <title>Lecturer Home</title>
        <%

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                ViewCreatedSlotDTO listCreatedSlot = (ViewCreatedSlotDTO) request.getAttribute("listCreatedSlot");

        %>
        <script>
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


            function myFunctionDropdown() {
                var dropdown = document.getElementById("myDropdown");
                dropdown.classList.toggle("show");

                if (dropdown.classList.contains('show')) {
                    dropdown.style.display = "flex";
                    setTimeout(function () {
                        dropdown.style.opacity = 1;
                        dropdown.style.transform = "scaleY(1)";
                    }, 10);
                } else {
                    dropdown.style.opacity = 0;
                    dropdown.style.transform = "scaleY(0)";
                    setTimeout(function () {
                        dropdown.style.display = "none";
                    }, 400);
                }
            }


            // Lấy phần header
            var header = document.getElementById("myHeader");

            // Xác định vị trí của header trên trình duyệt
            var headerOffsetTop = header.offsetTop;

            // Xác định chiều cao của header
            var headerHeight = header.clientHeight;

            // Thêm sự kiện cuộn trang
            window.addEventListener('scroll', function () {
                // Lấy vị trí hiện tại của thanh cuộn
                var scrollPosition = window.scrollY;

                // Kiểm tra nếu vị trí cuộn lớn hơn vị trí của header
                if (scrollPosition > headerOffsetTop) {
                    // Thêm lớp CSS để đặt độ mờ cho header
                    header.classList.add('header-transparent');
                } else {
                    // Xóa lớp CSS nếu vị trí cuộn nhỏ hơn hoặc bằng vị trí của header
                    header.classList.remove('header-transparent');
                }
            });

        </script>
        <style>
            .header-transparent {
                opacity: 0.5;
            }
        </style>
    </head>
    <body>

        <div id="myHeader" class="fptu-eng-1-parent">
            <div class="returnHome" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageLecturer" />
                </form>
            </div>
            <div class="frame-parent">
                <div>
                    <img class="frame-item" alt="" style="cursor: pointer" src="public/BookingView/group-33.svg" 
                         onclick="showUserInfo()" />
                    <div id="user-info" style="display: none;
                         position: absolute">
                        <p id="user-id"> </p>
                        <p id="user-name"></p>
                        <p id="user-email"></p>
                    </div>
                </div>
                <div class="dropdown">
                    <button onclick="myFunctionDropdown()" class="dropbtn"> 
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div id="myDropdown" class="dropdown-content" style="right: 0px;
                         flex-direction: column;    z-index: 999;
                         ">
                        <div class="frame-div returnHomeDiv" style="background-color: #b7b7b7;"> 
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="returnHomePageLecturer" />
                                <i class="material-icons">home</i>
                            </form>
                            Home
                        </div>
                        <div class="frame-div viewCreateSlot" onclick="submitForm()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="viewFSlotLecturer" />
                            </form>
                            <i class="material-icons">visibility</i>View Create Slot
                        </div>
                        <div class="frame-div request-div"  onclick="submitFormViewRequest()()">
                            <form style="display: flex;
                                  align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewRequest" />
                                <i class="material-icons">mail_outline</i>
                            </form>
                            View Request
                        </div>
                        <div class="frame-div lecturerProfile" onclick="submitFormViewLecturerProfile()">
                            <form style="display: flex;
                                  align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="viewLecturerProfile" />
                                <i class="material-icons">person</i>
                            </form>
                            View Lecturer Profile
                        </div>
                        <div class="frame-div hideView" onclick="submitFormHideView()()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="HideView" />
                            </form>
                            <i class="fas fa-search"></i>Hide List</p>
                        </div>
                        <div class="frame-div logout" onclick="submitFormLogout()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="Logout" />
                            </form>
                            <i class="material-icons">logout</i> Logout
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="page">

            <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="" data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;" data-resize="co1gk1-orbit" id="co1gk1-orbit" data-e="3gpl68-e" data-events="resize">
                <ul class="orbit-container" tabindex="0" style="height: 613.389px;">
                    <button class="orbit-previous" tabindex="0" style="color: gray;"><span class="show-for-sr">Previous Slide</span>&#9664;</button>
                    <button class="orbit-next" tabindex="0" style="color: gray;"><span class="show-for-sr">Next Slide</span>&#9654;</button>
                    <li class="orbit-slide" data-slide="0" style="display: none; position: relative; top: 0px;">
                        <img class="orbit-image" src="./public/StudentHome/HCM-scaled.jpeg"  style="width: 100%; height: auto; object-fit:cover;" alt="Space">
                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">FPT University</p></figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="1" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh3.png"  style="width: 100%; height: auto; object-fit:cover;"alt="Space">
                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">Ceremony</p></figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="2" style="position: relative; top: 0px; display: none;">
                        <img class="orbit-image" src="./public/StudentHome/anh4.png"  style="width: 100%; height: auto; object-fit:cover;" alt="Space">
                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">Orientation Week</p></figcaption>
                    </li>
                    <li class="orbit-slide" data-slide="3" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh5.png"  style="width: 100%; height: auto; object-fit:cover;" alt="Space">
                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">F-Camp</p></figcaption>
                    </li>
                    <li class="orbit-slide is-active" data-slide="4" style="position: relative; top: 0px; display: block;" aria-live="polite">
                        <img class="orbit-image" src="./public/StudentHome/anh6.png"  style="width: 100%; height: auto; object-fit:cover;" alt="Space">
                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">Training at the military</p></figcaption>
                    </li>
                </ul>
                <nav class="orbit-bullets">
                    <button class="" data-slide="0"><span class="show-for-sr">First slide details.</span></button>
                    <button data-slide="1" class=""><span class="show-for-sr">Second slide details.</span></button>
                    <button data-slide="2" class=""><span class="show-for-sr">Third slide details.</span></button>
                    <button data-slide="3" class=""><span class="show-for-sr">Fourth slide details.</span></button>
                    <button data-slide="4" class="is-active"><span class="show-for-sr">Fifth slide details.</span><span class="show-for-sr">Current Slide</span></button>
                </nav>
            </div>
            <h1 class="text-center text-custom">Top Aggressive Students</h1>
            <div style="display: flex;">
                <div class="col-md-11" id="fh5co-staff">
                    <div class="container">
                        <div class="row">
                            <c:forEach items="${requestScope.Top5StuBookSlots}" 
                                       var="stmbLT" varStatus="status">
                                <div class="col-md-3 animate-box text-center">
                                    <div class="staff">
                                        <div class="staff-img" style="background-image: url(./public/StudentHome/User-avatar.png);">
                                            <ul class="fh5co-social" style="display: flex;
                                                align-items: center;
                                                justify-content: center;">
                                                <li><a href="https://www.facebook.com/lam.cat.77770/"><i class="material-icons">facebook</i></a></li>
                                                <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                                <li><a href="#"><i class="material-icons">phone</i></a></li>
                                                <li><a href="#"><i class="fa fa-globe"></i></a></li>
                                            </ul>
                                        </div>
                                        <span>${stmbLT.userID}</span>
                                        <h3>${stmbLT.userName}</h3>
                                        <p>${stmbLT.userEmail}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="col-md-1" style=" display: flex;
                     flex-direction: column; float: right;">
                    <div class="frame-choice CreateFSlot" style="cursor: pointer; color: white" onclick="submitFormCreate()" title="Create free slots">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="CreateFS" />
                        </form>

                        <i class="material-icons">add</i>
                    </div>
                    <div class="frame-choice history" style="cursor: pointer; color: white" onclick="submitFormHistory()"  title="View history attendance">
                        <form action="MainController" method="POST">

                            <input type="hidden" name="action" value="historyLec" />
                        </form>

                        <i class="material-icons">history</i>
                    </div>
                    <div class="frame-choice sendMail" style="cursor: pointer; color: white"  onclick="submitFormSendEmail()" title="Send email for students">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="SendEmailForRemindStudent" />
                        </form>

                        <i class="material-icons">send</i>
                    </div>

                </div> 
            </div>





            <div class="footer1">
                <div class="powered-by-fpt-container1">
                    © Powered by
                    <a class="fpt-university2" href="http://fpt.edu.vn/" target="_blank">
                        <span class="fpt-university3">FPT University</span>
                    </a>
                    |
                    <a class="fpt-university2" href="http://library.fpt.edu.vn/" target="_blank">
                        <span class="fpt-university3">library</span>
                    </a>
                    <span class="fpt-university2" >| Contact us: meet.my.lecturers.fpt.edu@gmail.com</span>
                </div>
            </div>
        </div>

        <script>
            $(document).foundation();
        </script>
        <% }%>
    </body>
</html>
