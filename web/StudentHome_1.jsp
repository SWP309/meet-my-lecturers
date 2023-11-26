

<%@page import="java.util.Random"%>
<%@page import="sample.freeslots.FreeSlotsDAO"%>
<%@page import="sample.freeslots.FreeSlotsDTO"%>
<%@page import="sample.users.Top3StudentDTO"%>
<%@page import="sample.users.UserDAO"%>
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                UserDAO dao = new UserDAO();
                List<Top3StudentDTO> listTop3 = dao.GetlistTop3();
                if (listTop3 != null) {
                    request.setAttribute("LIST_TOP3", listTop3);
                }

        %>
        <meta charset="UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./StudentHome_1.css" />
        <link rel="stylesheet" href="./LecturerHome.css" />
        <script src="./student.js"></script>
        <script src="./simplyCountdown.js"></script>
        <!-- Google Fonts - Poppins -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap">

        <!-- Google Fonts - Lohit Tamil -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lohit Tamil:wght@400&display=swap">

        <!-- Google Fonts - Lexend -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <!-- Font Awesome 6 Beta 3 CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Material Icons CSS -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.all.min.js"></script>

        <!-- Foundation Min CSS -->
        <link rel="stylesheet" href="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">

        <!-- Foundation CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css">

        <!-- Motion UI CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.css">

        <!-- Foundation Prototype CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation-prototype.min.css">

        <!-- Foundicons CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet" type="text/css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <!--        font ch? gg-->
        <link href="https://fonts.googleapis.com/css2?family=Agbalumo&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playpen+Sans&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Oswald&display=swap" rel="stylesheet">


        <script>

            var userDTO = {
                userID: "<%= us.getUserID()%>",
                userName: "<%= us.getUserName()%>",
                userEmail: "<%= us.getUserEmail()%>"
            };
            function showUserInfo() {
                var userInfo = document.getElementById("user-info");
                if (userInfo.style.display === "none" || userInfo.style.display === "") {
                    userInfo.style.display = "block"; // Hi?n th? th�ng tin khi ???c nh?p chu?t
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

            function confirmCancel() {
                var result = confirm("Are you sure about cancel your booking ?");
                if (result) {
                    // N?u ng??i d�ng ch?n OK, chuy?n ??n trang MainController ?? x? l� h�nh ??ng "cancel".
                    // V� d?:
                    window.location.href = "MainController?action=cancel&bookingID=" + document.querySelector('[name="bookingID"]').value;
                } else {
                    // N?u ng??i d�ng ch?n Cancel, kh�ng l�m g� c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? th�ng b�o cho ng??i d�ng
                    // N?u ng??i d�ng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?�.
                    event.preventDefault();
                }
            }
            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }
            var userStatus = <%= us.getUserStatus()%>;
            if (userStatus === 2) {
                var errorMessage2 = confirm("${requestScope.showConfirmation}");
                if (errorMessage2) {
                    window.location.href = "MainController?action=changePass";
                } else {
                    event.preventDefault();
                }
            }

            function searchbyname(param) {
                var contentDiv = document.getElementById("content");
                var scrollValue = contentDiv.style.overflowY;
                if (param)
                    var txtSearch = param.value;
                if (txtSearch.trim() === "") {
                    contentDiv.style.display = "none";
                } else {
                    contentDiv.style.display = "flex";
                    console.log(txtSearch);
                    $.ajax({
                        url: "/meet-my-lecturers/ViewOptionSubjectByLecturerID",
                        type: "get", //send it through get method
                        data: {
                            txt: txtSearch
                        },
                        success: function (data) {
                            if (data === "") {
                                contentDiv.style.height = "auto";
                                contentDiv.style.overflowY = "visible";
                                contentDiv.innerHTML = "<p>  No results found.</p>";
                            } else {
                                var maxHeight = 300;
                                contentDiv.style.height = maxHeight + "px";
                                contentDiv.style.overflowY = "scroll";
                                contentDiv.innerHTML = data;
                            }
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                }
            }

        </script>
        <style>
            .card-body > div {
                margin-bottom: 0.2rem;
            }

            .card-body > .btn-book {
                margin-top: 1rem;
            }

            .form-group {
                margin: 0.4rem;
                border-radius: 35px;
            }

            .form-control {
                border-radius: 35px;
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

            .button-style {
                display: flex;
                justify-content: center;
                align-items: center;
                text-decoration: none;
                background-color: white;
                border: none;
                cursor: pointer;
            }

            .button-style:hover {
                background-color: #007bff;
                color: blue;
            }

            .dropbtn{
                background-color: #000000;
            }
            @media (max-width: 767px) {
                .logout i {
                    display: none;
                }
            }

        </style>
    </head>
    <body>
        <div class="student-home" style="height: auto">
            <div class="fptu-eng-1-parent">
                <div class="returnHome"> 
                    <form action="MainController" method="POST">
                        <input type="hidden" name="action" value="returnHomePageStudent" />
                    </form>
                </div>
                <div class="frame-parent">

                    <div>
                        <img class="frame-item" alt="" style="cursor: pointer" src="public/BookingView/group-33.svg" 
                             onclick="showUserInfo()" />
                        <div id="user-info" style="display: none; position: absolute">
                            <p id="user-id"> </p>
                            <p id="user-name"></p>
                            <p id="user-email"></p>
                        </div>
                    </div>
                    <div class="dropdown">
                        <button onclick="myFunction()" class="dropbtn"> 
                            <i class="fa fa-caret-down"></i>
                        </button>
                        <div id="myDropdown" class="dropdown-content" style="right: 0px;
                             flex-direction: column;
                             ">
                            <div class="frame-div returnHomeDiv" onclick="submitFormHomePageDiv()"> 
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="returnHomePageStudent" />
                                    <i class="material-icons">home</i>
                                </form>
                                Home
                            </div>
                            <div class="frame-div bookingview" onclick="submitForm()">
                                <form action="MainController" method="POST" style="display: none;">
                                    <input type="hidden" name="action" value="ViewBooking" />
                                </form>
                                <i class="material-icons">event</i>View Booked Slots
                            </div>
                            <div class="frame-div requestViewStatus" style=" cursor: pointer" onclick="submitFormRequestStatus()" id="booking-view-div">
                                <form action="MainController" method="POST" style="display: none;">
                                    <input type="hidden" name="action" value="ViewRequestStatus" />
                                </form>
                                <i class="material-icons">visibility</i>View Request Status
                            </div>
                            <!--                            <div class="frame-div request" onclick="submitFormRequest()">
                                                            <form action="MainController" method="POST">
                                                                <input type="hidden" name="action" value="Request" />
                                                                <i class="material-icons">mail_outline</i> 
                                                            </form>
                                                            Request
                                                        </div>-->
                            <div class="frame-div viewLecturer" onclick="submitFormViewLecturer()">
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="ViewAllLecturers" />
                                    <i class="fas fa-search"></i>
                                </form>
                                View Lecturer
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


            <div class="container-fluid ar-content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9 pr-5">
                            <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="" data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;" data-resize="co1gk1-orbit" id="co1gk1-orbit" data-e="3gpl68-e" data-events="resize">
                                <ul class="orbit-container" tabindex="0" style="height: 613.389px;">
                                    <button class="orbit-previous" tabindex="0" style="color: gray;"><span class="show-for-sr">Previous Slide</span>&#9664;</button>
                                    <button class="orbit-next" tabindex="0" style="color: gray;"><span class="show-for-sr">Next Slide</span>&#9654;</button>
                                    <li class="orbit-slide" data-slide="0" style="display: none; position: relative; top: 0px;">
                                        <img class="orbit-image" src="./public/StudentHome/HCM-scaled.jpeg"  style="width: 2000px; height: 600px; object-fit:contain;" alt="Space">
                                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">FPT University</p></figcaption>
                                    </li>
                                    <li class="orbit-slide" data-slide="1" style="position: relative; top: 0px; display: none;">
                                        <img class="orbit-image" src="./public/StudentHome/anh3.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">Ceremony</p></figcaption>
                                    </li>
                                    <li class="orbit-slide" data-slide="2" style="position: relative; top: 0px; display: none;">
                                        <img class="orbit-image" src="./public/StudentHome/anh4.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">Orientation Week</p></figcaption>
                                    </li>
                                    <li class="orbit-slide" data-slide="3" style="position: relative; top: 0px; display: block;" aria-live="polite">
                                        <img class="orbit-image" src="./public/StudentHome/anh5.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
                                    <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;">F-Camp</p></figcaption>
                                    </li>
                                    <li class="orbit-slide is-active" data-slide="4" style="position: relative; top: 0px; display: block;" aria-live="polite">
                                        <img class="orbit-image" src="./public/StudentHome/anh6.png"  style="width: 2000px; height: 750px; object-fit:contain;" alt="Space">
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
                        </div>
                        <div class="col-lg-3 pl-0">
                            <div class="sidebar">
                                <hr class="bg-white" />
                                <c:set var="listTop3" value="${requestScope.LIST_TOP3}" /> 
                                <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="" data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;" data-resize="co1gk1-orbit" id="co1gk1-orbit" data-e="3gpl68-e" data-events="resize" style="margin-top: 54px;">
                                    <ul class="orbit-container" tabindex="0" style="height: 613.389px;">
                                        <li class="orbit-slide" data-slide="0" style="display: none; position: relative; top: 0px;">
                                            <img class="orbit-image" src="./public/StudentHome/User-avatar.png"  style="width: 2000px; height: 400px; object-fit:contain;" alt="Space">
                                            <c:if test="${requestScope.LIST_TOP3 !=null}">
                                            <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;"><b>${requestScope.LIST_TOP3[0].userName}</b></br>The number of booking slots: ${requestScope.LIST_TOP3[0].bookingCount}</p></figcaption>
                                                    </c:if>
                                        </li>
                                        <li class="orbit-slide" data-slide="1" style="position: relative; top: 0px; display: none;">
                                            <img class="orbit-image" src="./public/StudentHome/User-avatar.png"  style="width: 2000px; height: 400px; object-fit:contain;" alt="Space">
                                            <c:if test="${requestScope.LIST_TOP3 !=null}">
                                            <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;"><b>${requestScope.LIST_TOP3[1].userName}</b></br>The number of booking slots: ${requestScope.LIST_TOP3[1].bookingCount}</p></figcaption>
                                                    </c:if>
                                        </li>
                                        <li class="orbit-slide is-active" data-slide="4" style="position: relative; top: 0px; display: block;" aria-live="polite">
                                            <img class="orbit-image" src="./public/StudentHome/User-avatar.png"  style="width: 2000px; height: 400px; object-fit:contain;" alt="Space">
                                            <c:if test="${requestScope.LIST_TOP3 !=null}">
                                            <figcaption class="orbit-caption"><p style="font-family: 'Playpen Sans', sans-serif;"><b>${requestScope.LIST_TOP3[2].userName}</b></br>The number of booking slots: ${requestScope.LIST_TOP3[2].bookingCount}</p></figcaption>
                                                    </c:if>
                                        </li>
                                    </ul>
                                    <nav class="orbit-bullets">
                                        <button class="" data-slide="0"><span class="show-for-sr">First slide details.</span></button>
                                        <button data-slide="1" class=""><span class="show-for-sr">Second slide details.</span></button>
                                        <button data-slide="2" class="is-active"><span class="show-for-sr">Fourth slide details.</span><span class="show-for-sr">Current Slide</span></button>
                                    </nav>
                                </div>
                                <h3 style="text-align: center; font-family: 'Agbalumo', sans-serif;">Top Student</h3>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="width: 100%; display: flex; justify-content: center">
                <div style="position: relative; width:50%;">
                    <input class="form-control" oninput="searchbyname(this)" type="text" name="txt" value="${txtS}" placeholder="Search for names.." title="Type in a name of lecturer">

                    <div class="result" style="display: none;
                         flex-direction: column;
                         background: #e9ecef;
                         height: 150px;
                         overflow-y: scroll;
                         border-radius: 15px;" id="content">
                    </div>
                </div>

                <form action="MainController" method="POST" class="d-flex justify-content-center" style="margin-top: -7px;">
                    <div class="form-group">
                        <select style="padding: 5px; width: 100px; text-align: center" class="form-control option" name="txtMode" onchange="updateHiddenField(this, 'hiddenSubjectCode')" title="Select a Mode of the slots">

                            <option value="0">Mode</option>
                            <option value="1" >Book</option>
                            <option value="2" >Request</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control Search-custom" type="submit" name="action" value="SearchFSlotByMode">Search</button>
                    </div>
                </form>
            </div>

            <div class="container mt-5">
                <div class="row justify-content-center mt-5 tableview">

                    <!--lecturer id and subject-->        
                    <c:if test="${not empty requestScope.FREESLOT_BY_SUBJECT_AND_LECID}">
                        <c:forEach items="${requestScope.FREESLOT_BY_SUBJECT_AND_LECID}" 
                                   var="freeslot" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="    width: 100%;
                                     height: auto; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>FreeSlotID:</b></strong> <span class="ml-auto"> ${freeslot.freeSlotID}</span></div>
                                            <c:if test="${freeslot.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            </c:if>
                                            <c:if test="${freeslot.mode == 2 and freeslot.subjectCode == null}">
                                                <div style="gap: 30%;" class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> 
                                                        <select class="form-control" name="txtSubjectCode">
                                                            <c:forEach items="${freeslot.listMajor}" var="major">
                                                                <option value="${major.subjectCode}">${major.subjectCode} - ${major.subjectName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeslot.mode == 2 and freeslot.subjectCode != null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${freeslot.subjectCode}</span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeslot.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeslot.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeslot.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeslot.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeslot.semesterID}</span></div>
                                                <c:if test="${freeslot.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Capacity:</b></strong> <span class="ml-auto">${freeslot.bookedStudent}/${freeslot.capacity}</span></div>
                                            </c:if>
                                            <c:if test="${freeslot.mode == 2}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Description: </b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtDescription" value="${param.txtDescription}" style="border: none; margin: 0px" placeholder="Input your wish" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeslot.password ne null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px" placeholder="Input password" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeslot.password == null}">
                                                <div style="margin-bottom: 16px" class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <b>None</b>
                                                    </span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between">
                                                <c:if test="${freeslot.bookedStudent < freeslot.capacity and freeslot.mode == 1}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeslot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeslot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeslot.endTime}" readonly="">
                                                    <input type="hidden" name="txtLecturerID" 
                                                           value="${freeslot.lecturerID}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeslot.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeslot.password}">
                                                    <button type="submit" name="action" value="BookFreeSlot" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Book
                                                    </button>

                                                </c:if>
                                                <c:if test="${freeslot.bookedStudent == freeslot.capacity and freeslot.mode == 1}">
                                                    <button disabled  class="button-style" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color: #808588; padding: 10px 15px; color: white">
                                                        Full
                                                    </button>
                                                </c:if>
                                                <c:if test="${freeslot.mode == 2}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeslot.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeslot.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeslot.endTime}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${major.subjectCode}" readonly="">
                                                    <input type="hidden" name="txtDescription" 
                                                           value="${param.txtDescription}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeslot.password}">
                                                    <button type="submit" name="action" value="CreateRequest" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Request
                                                    </button>
                                                </c:if>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </c:if>
                    <!--search by lecturerName-->
                    <c:if test="${not empty requestScope.FREESLOT_BY_LECTURER_NAME}">
                        <c:forEach items="${requestScope.FREESLOT_BY_LECTURER_NAME}" 
                                   var="freeSlotByLecturerName" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="    width: 100%;
                                     height: auto; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>FreeSlotID:</b></strong> <span class="ml-auto"> ${freeSlotByLecturerName.freeSlotID}</span></div>
                                            <c:if test="${freeSlotByLecturerName.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeslot.subjectCode}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByLecturerName.mode == 2 and freeSlotByLecturerName.subjectCode == null}">
                                                <div style="gap: 30%;" class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> 
                                                        <select class="form-control" name="txtSubjectCode">
                                                            <c:forEach items="${freeSlotByLecturerName.listMajor}" var="major">
                                                                <option value="${major.subjectCode}">${major.subjectCode} - ${major.subjectName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByLecturerName.mode == 2 and freeSlotByLecturerName.subjectCode != null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.subjectCode}</span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.semesterID}</span></div>
                                                <c:if test="${freeSlotByLecturerName.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Capacity:</b></strong> <span class="ml-auto">${freeSlotByLecturerName.bookedStudent}/${freeSlotByLecturerName.capacity}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByLecturerName.mode == 2}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Description: </b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtDescription" value="${param.txtDescription}" style="border: none; margin: 0px" placeholder="Input your wish" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByLecturerName.password ne null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px" placeholder="Input password" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByLecturerName.password == null}">
                                                <div style="margin-bottom: 16px" class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <b>None</b>
                                                    </span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between">
                                                <c:if test="${freeSlotByLecturerName.bookedStudent < freeSlotByLecturerName.capacity and freeSlotByLecturerName.mode == 1}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByLecturerName.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByLecturerName.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByLecturerName.endTime}" readonly="">
                                                    <input type="hidden" name="txtLecturerID" 
                                                           value="${freeSlotByLecturerName.lecturerID}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlotByLecturerName.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByLecturerName.password}">
                                                    <button type="submit" name="action" value="BookFreeSlot" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Book
                                                    </button>

                                                </c:if>
                                                <c:if test="${freeSlotByLecturerName.bookedStudent == freeSlotByLecturerName.capacity and freeSlotByLecturerName.mode == 1}">
                                                    <button disabled  class="button-style" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color: #808588; padding: 10px 15px; color: white">
                                                        Full
                                                    </button>
                                                </c:if>
                                                <c:if test="${freeSlotByLecturerName.mode == 2}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByLecturerName.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByLecturerName.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByLecturerName.endTime}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${major.subjectCode}" readonly="">
                                                    <input type="hidden" name="txtDescription" 
                                                           value="${param.txtDescription}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByLecturerName.password}">
                                                    <button type="submit" name="action" value="CreateRequest" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Request
                                                    </button>
                                                </c:if>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!--search by mode-->


                    <c:if test="${not empty requestScope.FREESLOT_BY_MODE1}">
                        <c:forEach items="${requestScope.FREESLOT_BY_MODE1}" 
                                   var="freeSlotByMode1" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="    width: 100%;
                                     height: auto; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>FreeSlotID:</b></strong> <span class="ml-auto"> ${freeSlotByMode1.freeSlotID}</span></div>
                                            <c:if test="${freeSlotByMode1.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeSlotByMode1.subjectCode}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByMode1.mode == 2 and freeSlotByMode1.subjectCode == null}">
                                                <div style="gap: 30%;" class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> 
                                                        <select class="form-control" name="txtSubjectCode">
                                                            <c:forEach items="${freeSlotByMode1.listMajor}" var="major">
                                                                <option value="${major.subjectCode}">${major.subjectCode} - ${major.subjectName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode1.mode == 2 and freeSlotByMode1.subjectCode != null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${freeSlotByMode1.subjectCode}</span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeSlotByMode1.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeSlotByMode1.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeSlotByMode1.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeSlotByMode1.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeSlotByMode1.semesterID}</span></div>
                                                <c:if test="${freeSlotByMode1.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Capacity:</b></strong> <span class="ml-auto">${freeSlotByMode1.bookedStudent}/${freeSlotByMode1.capacity}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByMode1.mode == 2}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Description: </b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtDescription" value="${param.txtDescription}" style="border: none; margin: 0px" placeholder="Input your wish" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode1.password ne null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px" placeholder="Input password" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode1.password == null}">
                                                <div style="margin-bottom: 16px" class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <b>None</b>
                                                    </span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between">
                                                <c:if test="${freeSlotByMode1.bookedStudent < freeSlotByMode1.capacity and freeSlotByMode1.mode == 1}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByMode1.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByMode1.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByMode1.endTime}" readonly="">
                                                    <input type="hidden" name="txtLecturerID" 
                                                           value="${freeSlotByMode1.lecturerID}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlotByMode1.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByMode1.password}">
                                                    <button type="submit" name="action" value="BookFreeSlot" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Book
                                                    </button>

                                                </c:if>
                                                <c:if test="${freeSlotByMode1.bookedStudent == freeSlotByMode1.capacity and freeSlotByMode1.mode == 1}">
                                                    <button disabled  class="button-style" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color: #808588; padding: 10px 15px; color: white">
                                                        Full
                                                    </button>
                                                </c:if>
                                                <c:if test="${freeSlotByMode1.mode == 2}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByMode1.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByMode1.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByMode1.endTime}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${major.subjectCode}" readonly="">
                                                    <input type="hidden" name="txtDescription" 
                                                           value="${param.txtDescription}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByMode1.password}">
                                                    <button type="submit" name="action" value="CreateRequest" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Request
                                                    </button>
                                                </c:if>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <c:if test="${not empty requestScope.FREESLOT_BY_MODE2}">
                        <c:forEach items="${requestScope.FREESLOT_BY_MODE2}" 
                                   var="freeSlotByMode2" varStatus="status">
                            <div class="col-md-4">
                                <div class="card" style="    width: 100%;
                                     height: auto; border-radius: 5%;">
                                    <div class="card-body">
                                        <form action="MainController" method="POST">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>FreeSlotID:</b></strong> <span class="ml-auto"> ${freeSlotByMode2.freeSlotID}</span></div>
                                            <c:if test="${freeSlotByMode2.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> ${freeSlotByMode2.subjectCode}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByMode2.mode == 2 and freeSlotByMode2.subjectCode == null}">
                                                <div style="gap: 30%;" class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto"> 
                                                        <select class="form-control" name="txtSubjectCode">
                                                            <c:forEach items="${freeSlotByMode2.listMajor}" var="major">
                                                                <option value="${major.subjectCode}">${major.subjectCode} - ${major.subjectName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode2.mode == 2 and freeSlotByMode2.subjectCode != null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${freeSlotByMode2.subjectCode}</span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's ID:</b></strong> <span class="ml-auto">${freeSlotByMode2.lecturerID}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's name:</b></strong> <span class="ml-auto">${freeSlotByMode2.lecturerName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${freeSlotByMode2.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${freeSlotByMode2.endTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> <span class="ml-auto">${freeSlotByMode2.semesterID}</span></div>
                                                <c:if test="${freeSlotByMode2.mode == 1}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Capacity:</b></strong> <span class="ml-auto">${freeSlotByMode2.bookedStudent}/${freeSlotByMode2.capacity}</span></div>
                                            </c:if>
                                            <c:if test="${freeSlotByMode2.mode == 2}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Description: </b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtDescription" value="${param.txtDescription}" style="border: none; margin: 0px" placeholder="Input your wish" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode2.password ne null}">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <input class="form-control" type="text" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px" placeholder="Input password" required="">
                                                    </span></div>
                                                </c:if>
                                                <c:if test="${freeSlotByMode2.password == null}">
                                                <div style="margin-bottom: 16px" class="d-flex justify-content-between"><strong style="color: red"><b>Password:</b></strong> <span class="ml-auto">
                                                        <b>None</b>
                                                    </span></div>
                                                </c:if>
                                            <div class="d-flex justify-content-between">
                                                <c:if test="${freeSlotByMode2.bookedStudent < freeSlotByMode2.capacity and freeSlotByMode2.mode == 1}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByMode2.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByMode2.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByMode2.endTime}" readonly="">
                                                    <input type="hidden" name="txtLecturerID" 
                                                           value="${freeSlotByMode2.lecturerID}" readonly="">
                                                    <input type="hidden" name="intCapacity" 
                                                           value="${freeSlotByMode2.capacity}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${param.txtSubjectCode}" readonly="">
                                                    <input type="hidden" name="txtUserID" 
                                                           value="${param.txtUserID}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByMode2.password}">
                                                    <button type="submit" name="action" value="BookFreeSlot" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Book
                                                    </button>

                                                </c:if>
                                                <c:if test="${freeSlotByMode2.bookedStudent == freeSlotByMode2.capacity and freeSlotByMode2.mode == 1}">
                                                    <button disabled  class="button-style" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color: #808588; padding: 10px 15px; color: white">
                                                        Full
                                                    </button>
                                                </c:if>
                                                <c:if test="${freeSlotByMode2.mode == 2}">
                                                    <input type="hidden" name="txtFSlotID" 
                                                           value="${freeSlotByMode2.freeSlotID}" readonly="">
                                                    <input type="hidden" name="txtStartTime" 
                                                           value="${freeSlotByMode2.startTime}" readonly="">
                                                    <input type="hidden" name="txtEndTime" 
                                                           value="${freeSlotByMode2.endTime}" readonly="">
                                                    <input type="hidden" name="txtSubjectCode" 
                                                           value="${major.subjectCode}" readonly="">
                                                    <input type="hidden" name="txtDescription" 
                                                           value="${param.txtDescription}" readonly="">
                                                    <input type="hidden" name="txtPassword" value="${param.txtPassword}" style="border: none; margin: 0px">
                                                    <input type="hidden" name="password" value="${freeSlotByMode2.password}">
                                                    <button type="submit" name="action" value="CreateRequest" style="display: flex; text-decoration: none; border-radius: 20px; justify-content: center;  background-color:#018df7; padding: 10px 15px; color: white;">
                                                        Request
                                                    </button>
                                                </c:if>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>



                </div>
            </div>
            <%
                UserDAO userDAO = new UserDAO();
                userDAO.getListLecturers();
                List<UserDTO> lecturers = userDAO.getLecturers();
                Random random = new Random();
                int randomIndex = random.nextInt(lecturers.size());
            %>

            <div id="fh5co-register" style="background-image: url(./public/UsersView/anhTruongFPT.jpg);">
                <div class="overlay"></div>
                <div class="row">
                    <div class="col-md-12 col-md-offset-2 animate-box">
                        <div class="date-counter text-center">
                            <h2>Get 400 of Online Courses for Free</h2>
                            <h3><%= lecturers.get(randomIndex).getUserName()%></h3>
                            <div class="simply-countdown simply-countdown-one"></div>
                            <p><strong>Limited Offer, Hurry Up!</strong></p>
                            <p><a href="MainController?action=SearchFSlotByMode&txtMode=1" class="btn btn-primary btn-lg btn-reg">Register Now!</a></p>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div id="customAlert">
            <div id="alertContent">
                <!-- N?i dung c?nh b�o s? ???c th�m v�o ?�y -->
            </div>
            <button class="closeButton">X</button>
        </div>
        <style>
            #customAlert {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                border-radius: 4px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                padding: 28px;
                font-family: Arial, sans-serif;
                font-size: 18px;
                text-align: center;
                z-index: 9999;
                width: 36%;
                color: red;
                font-weight: bold;
            }
            #alertContent{
                font-family: 'Oswald','Playpen Sans';
                padding: 20px;
            }
            .closeButton {
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
                font-weight: bold;
                border: none;
                background: white;
            }
            .closeButton:hover{
                opacity: 0.5;
            }

            #alertContent {
                /* N?u b?n mu?n tu? ch?nh ki?u ch? v� m�u s?c, h�y ?i?u ch?nh ?o?n CSS n�y */
            }
        </style>
    </div>
    <!-- Th�m li�n k?t ??n Bootstrap JS v� jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/js/foundation.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/motion-ui/1.2.3/motion-ui.min.js"></script>
    <script>
                            var errorMessage = "${requestScope.ERROR}";
                            var errorMessage1 = "${requestScope.BOOKING_ERROR.duplicateBookedSlot}";
                            var errorMessage2 = "${requestScope.BOOKING_ERROR.checkPassword}";
                            var errorMessage3 = "${requestScope.BOOKING_ERROR.inBlockList}";
                            var errorMessage4 = "${requestScope.SEARCH_FREESLOT_MESSAGE}";


                            // Ki?m tra n?u errorMessage kh�ng r?ng, hi?n th? th�ng b�o c?nh b�o
                            if (errorMessage.trim() !== "") {
                                showAlert(errorMessage);
                            }
                            if (errorMessage1.trim() !== "") {
                                showAlert(errorMessage1);
                            }
                            if (errorMessage2.trim() !== "") {
                                showAlert(errorMessage2);
                            }
                            if (errorMessage3.trim() !== "") {
                                showAlert(errorMessage3);
                            }
                            if (errorMessage4.trim() !== "") {
                                showAlert(errorMessage4);
                            }

                            // H�m ?? hi?n th? th�ng b�o t�y ch?nh
                            function showAlert(message) {
                                var alertDiv = document.getElementById("customAlert");
                                var alertContentDiv = document.getElementById("alertContent");
                                alertContentDiv.textContent = message;
                                alertDiv.style.display = "block";
                                var closeButton = alertDiv.querySelector(".closeButton");
                                closeButton.addEventListener("click", function () {
                                    alertDiv.style.display = "none";
                                });
                            }



                            var d = new Date(new Date().getTime() + 1000 * 120 * 120 * 2000);

                            // default example
                            simplyCountdown('.simply-countdown-one', {
                                year: d.getFullYear(),
                                month: d.getMonth() + 1,
                                day: d.getDate()
                            });

                            //jQuery example
                            $('#simply-countdown-losange').simplyCountdown({
                                year: d.getFullYear(),
                                month: d.getMonth() + 1,
                                day: d.getDate(),
                                enableUtc: false
                            });

    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script>
                            $(document).foundation();
    </script>
    <%} else {
            response.sendRedirect("MainController");
        }%>
</body>
</html>
