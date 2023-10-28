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
            if (us != null) {
                ViewCreatedSlotDTO listCreatedSlot = (ViewCreatedSlotDTO) request.getAttribute("listCreatedSlot");

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
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
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
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function goBack() {
                window.history.back();
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
                    window.location.href = "MainController?action=delete&freeSlotID=" + listCreatedSlot.freeSlotID;
//                   window.location.href = "MainController?action=delete&freeSlotID=" + document.querySelector('[name="freeSlotID"]').value;
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
                    // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
                    event.preventDefault();
                }
            }
            function confirmCheckAttendanceLink(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
             function confirmCheckAttendanceLinkByStEt(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
             function confirmCheckAttendanceLinkByAll(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
             function confirmCheckAttendanceLinkBySubjectCode(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }
             function confirmCheckAttendanceLinkByNull(event, freeSlotID) {
                var result = confirm("Are you sure about teach this slot ? if you check in , you will take attendane and this free slot will disapear");
                if (result) {
                    // Th?c hi?n AJAX request ?? g?i yêu c?u ??n action trong controller
                    var xhr = new XMLHttpRequest();
                    var url = "MainController?action=AttendanceLinkLecturer&freeSlotID=" + freeSlotID;
                    xhr.open("POST", url, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // X? lý k?t qu? tr? v? n?u c?n
                        }
                    };
                    xhr.send();
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
                    event.preventDefault();
                }
            }

        </script>
        <style>
            td {
                position: relative;
            }

            .specific-input{
                /*                width: 100%;
                                box-sizing: border-box;
                                position: absolute;
                                top: 0;
                                left: 0;
                                bottom: 0;
                                right: 0;*/
                /*                font-size: 14px;*/
                width: 198px;
                text-align: center;
                border: none; /* Lo?i b? vi?n */
            }
            button[type="submit"]{
                border: none; /* Lo?i b? vi?n */
                background-color: white;
                color: #007bff;
            }
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

            .btn-book > .btn {
                border-radius: 15px;
                border: 1px solid black;
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
        </style>


    </head>
    <body>
        <div class="student-viewbookedslot">
            <div class="fptu-eng-1-parent">
                <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                    <form action="MainController" method="POST">
                        <input type="hidden" name="action" value="returnHomePageLecturer" />
                    </form>
                    <img
                        class="fptu-eng-1-icon"
                        alt=""
                        src="public/BookingView/2021fptueng-1@2x.png"
                        />
                </div>

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-Create CreateFSlot" onclick="submitFormCreate()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="CreateFS" />
                            </form>

                            <i class="material-icons">create</i> Create Free Slot
                        </div>
                        <div class="frame-div request" style="width: 25%;" onclick="submitFormViewRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewRequest" />
                            </form>

                            <i class="material-icons">mail_outline</i>View Request
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
            <div class="backbutton"  onclick="goBack()">
                <div class="back"><p>Back</p></div>
                <img class="back-icon" alt="" src="./public/request/back.svg" />
            </div>

            <div class="row align-items-center" style="margin-top: -38%;">
                <form action="MainController" method="POST">
                    <div class="form-group">
                        <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}">
                    </div>
                    <div class="form-group">
                        <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="txtSubjectCode" value="${param.txtSubjectCode}">
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" style="border-color: black" type="submit" name="action" value="searchCSlot">Search</button>
                    </div>
                </form>
            </div>


            <!--  LIST OF THE PAGE -------------------------------------------------------------->
            <div class="container mt-5" style="    margin-top: -22% !important;">
                <div class="row justify-content-center mt-5 tableview">
                    <c:if test="${requestScope.LIST_CREATED_SLOT !=null}">
                        <c:if test="${not empty requestScope.LIST_CREATED_SLOT}">
                            <c:forEach var="listCreatedSlot" varStatus="counter" items="${requestScope.LIST_CREATED_SLOT}">
                                <div class="col-md-4">
                                    <div class="card" style="width: 357px; height: 242px; border-radius: 5%;">
                                        <div class="card-body">
                                            <form action="MainController" method="POST">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="subjectCode" value="${listCreatedSlot.subjectCode.trim()}"/>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                    <span class="ml-auto">${listCreatedSlot.lectureName}</span>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="startTime" value="${listCreatedSlot.startTime}"/>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${listCreatedSlot.endTime}"/>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${listCreatedSlot.meetLink}"/>-->
                                                    <a class="ml-auto" href="https://${listCreatedSlot.meetLink}" onclick="confirmCheckAttendanceLink(event, '${listCreatedSlot.freeSlotID}')"> Link Meet</a>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="semesterID" value="${listCreatedSlot.semesterID}"/>
                                                </div>
                                                <div class="d-flex justify-content-between btn-book">

                                                    <div>
                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to hide this Free Slot')" href="MainController?action=hideFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                            <i class="material-icons">cancel</i>Hide
                                                        </a>
                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to delete this Free Slot')" href="MainController?action=deleteFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                            <i class="material-icons">delete</i>Delete
                                                        </a>
                                                    </div>
                                                    <div>

                                                        <a class="d-flex justify-content-between" style="text-decoration: none; gap: 2px; width: 11px; margin-left: 10px;" href="MainController?action=viewFS&freeSlotID=${listCreatedSlot.freeSlotID}">
                                                            <i class="fas fa-search"></i>View
                                                        </a>
                                                        <form action="MainController" method="GET">
                                                            <input type="hidden" name="action" value="updateFS">
                                                            <input type="hidden" name="freeSlotID" value="${listCreatedSlot.freeSlotID}">
                                                            <input type="hidden" name="subjectCode" value="${listCreatedSlot.subjectCode.trim()}" required/>
                                                            <input type="hidden" name="startTime" value="${listCreatedSlot.startTime}">
                                                            <input type="hidden" name="endTime" value="${listCreatedSlot.endTime}">
                                                            <input type="hidden" name="semesterID" value="${searchByNull.semesterID}">
                                                            <button type="submit" style="display: flex; text-decoration: none; justify-content: center;  background-color: white;">
                                                                <i class="material-icons">update</i>Update
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>          

                </div>
                <!--     SEARCH BY ST AND ET ---------------------------------------------------------->
                <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and empty param.txtSubjectCode}">
                    <div class="container mt-5" style="    margin-top: -3% !important;">
                        <div class="row justify-content-center mt-5">
                            <c:if test="${requestScope.SEARCH_FREE_SLOT_BY_ST_ET !=null}">
                                <c:if test="${not empty requestScope.SEARCH_FREE_SLOT_BY_ST_ET}">
                                    <c:forEach var="searchByStEt" varStatus="counter" items="${requestScope.SEARCH_FREE_SLOT_BY_ST_ET}">
                                        <div class="col-md-4">
                                            <div class="card" style="width: 364px; height: 242px; border-radius: 5%;">
                                                <div class="card-body">
                                                    <form action="MainController" method="POST">
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="subjectCode" value="${searchByStEt.subjectCode.trim()}"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                            <span class="ml-auto">${searchByStEt.lectureName}</span>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByStEt.startTime}"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByStEt.endTime}"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByStEt.meetLink}"/>-->
                                                            <a class="ml-auto" href="https://${searchByStEt.meetLink}" onclick="confirmCheckAttendanceLinkByStEt(event, '${searchByStEt.freeSlotID}')"> Link Meet</a>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="semesterID" value="${searchByStEt.semesterID}"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between btn-book">

                                                            <div>
                                                                <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to hide this Free Slot')" href="MainController?action=hideFS&freeSlotID=${searchByStEt.freeSlotID}">
                                                                    <i class="material-icons">cancel</i>Hide
                                                                </a>
                                                                <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to delete this Free Slot')" href="MainController?action=deleteFS&freeSlotID=${searchByStEt.freeSlotID}">
                                                                    <i class="material-icons">delete</i>Delete
                                                                </a>
                                                            </div>
                                                            <div>

                                                                <a class="d-flex justify-content-between" style="text-decoration: none; gap: 2px; width: 11px; margin-left: 10px;" href="MainController?action=viewFS&freeSlotID=${searchByStEt.freeSlotID}">
                                                                    <i class="fas fa-search"></i>View
                                                                </a>
                                                                <form action="MainController" method="GET">
                                                                    <input type="hidden" name="action" value="updateFS">
                                                                    <input type="hidden" name="freeSlotID" value="${searchByStEt.freeSlotID}">
                                                                    <input type="hidden" name="subjectCode" value="${searchByStEt.subjectCode.trim()}" required/>
                                                                    <input type="hidden" name="startTime" value="${searchByStEt.startTime}">
                                                                    <input type="hidden" name="endTime" value="${searchByStEt.endTime}">
                                                                    <input type="hidden" name="semesterID" value="${searchByNull.semesterID}">
                                                                    <button type="submit" style="display: flex; text-decoration: none; justify-content: center; background-color: white;">
                                                                        <i class="material-icons">update</i>Update
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </c:if>          

                        </div>
                    </c:if>
                    <!--     SEARCH BY ALL ---------------------------------------------------------->
                    <c:if test="${not empty param.txtStartTime and not empty param.txtEndTime and  not empty param.txtSubjectCode}">
                        <div class="container mt-5" style="    margin-top: -3% !important;">
                            <div class="row justify-content-center mt-5">
                                <c:if test="${requestScope.SEARCH_FREE_SLOT_BY_ALL !=null}">
                                    <c:if test="${not empty requestScope.SEARCH_FREE_SLOT_BY_ALL}">
                                        <c:forEach var="searchByAll" varStatus="counter" items="${requestScope.SEARCH_FREE_SLOT_BY_ALL}">
                                            <div class="col-md-4">
                                                <div class="card" style="width: 364px; height: 242px; border-radius: 5%;">
                                                    <div class="card-body">
                                                        <form action="MainController" method="POST">
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="subjectCode" value="${searchByAll.subjectCode.trim()}"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                <span class="ml-auto">${searchByAll.lectureName}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByAll.startTime}"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByAll.endTime}"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByAll.meetLink}"/>-->
                                                                <a class="ml-auto" href="https://${searchByAll.meetLink}" onclick="confirmCheckAttendanceLinkByAll(event, '${searchByAll.freeSlotID}')"> Link Meet</a>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="semesterID" value="${searchByAll.semesterID}"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between btn-book">

                                                                <div>
                                                                    <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to hide this Free Slot')" href="MainController?action=hideFS&freeSlotID=${searchByAll.freeSlotID}">
                                                                        <i class="material-icons">cancel</i>Hide
                                                                    </a>
                                                                    <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to delete this Free Slot')" href="MainController?action=deleteFS&freeSlotID=${searchByAll.freeSlotID}">
                                                                        <i class="material-icons">delete</i>Delete
                                                                    </a>
                                                                </div>
                                                                <div>

                                                                    <a class="d-flex justify-content-between" style="text-decoration: none; gap: 2px; width: 11px; margin-left: 10px;" href="MainController?action=viewFS&freeSlotID=${searchByAll.freeSlotID}">
                                                                        <i class="fas fa-search"></i>View
                                                                    </a>
                                                                    <form action="MainController" method="GET">
                                                                        <input type="hidden" name="action" value="updateFS">
                                                                        <input type="hidden" name="freeSlotID" value="${searchByAll.freeSlotID}">
                                                                        <input type="hidden" name="subjectCode" value="${searchByAll.subjectCode.trim()}" required/>
                                                                        <input type="hidden" name="startTime" value="${searchByAll.startTime}">
                                                                        <input type="hidden" name="endTime" value="${searchByAll.endTime}">
                                                                        <input type="hidden" name="semesterID" value="${searchByNull.semesterID}">
                                                                        <button type="submit" style="display: flex; text-decoration: none; justify-content: center; background-color: white;">
                                                                            <i class="material-icons">update</i>Update
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </c:if>          

                            </div>
                        </c:if>

                        <!--     SEARCH BY subjectCode ---------------------------------------------------------->
                        <c:if test="${empty param.txtStartTime and empty param.txtEndTime and not empty param.txtSubjectCode}">
                            <div class="container mt-5" style="    margin-top: -3% !important;">
                                <div class="row justify-content-center mt-5">
                                    <c:if test="${requestScope.SEARCH_FREE_SLOT_BY_SUBJECT !=null}">
                                        <c:if test="${not empty requestScope.SEARCH_FREE_SLOT_BY_SUBJECT}">
                                            <c:forEach var="searchBySubjectCode" varStatus="counter" items="${requestScope.SEARCH_FREE_SLOT_BY_SUBJECT}">
                                                <div class="col-md-4">
                                                    <div class="card" style="width: 364px; height:  242px; border-radius: 5%;">
                                                        <div class="card-body">
                                                            <form action="MainController" method="POST">
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="subjectCode" value="${searchBySubjectCode.subjectCode.trim()}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                    <span class="ml-auto">${searchBySubjectCode.lectureName}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="startTime" value="${searchBySubjectCode.startTime}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchBySubjectCode.endTime}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchBySubjectCode.meetLink}"/>-->
                                                                    <a class="ml-auto" href="https://${searchBySubjectCode.meetLink}" onclick="confirmCheckAttendanceLinkBySubjectCode(event, '${searchBySubjectCode.freeSlotID}')"> Link Meet</a>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="semesterID" value="${searchBySubjectCode.semesterID}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between btn-book">

                                                                    <div>
                                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to hide this Free Slot')" href="MainController?action=hideFS&freeSlotID=${searchBySubjectCode.freeSlotID}">
                                                                            <i class="material-icons">cancel</i>Hide
                                                                        </a>
                                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to delete this Free Slot')" href="MainController?action=deleteFS&freeSlotID=${searchBySubjectCode.freeSlotID}">
                                                                            <i class="material-icons">delete</i>Delete
                                                                        </a>
                                                                    </div>
                                                                    <div>

                                                                        <a class="d-flex justify-content-between" style="text-decoration: none; gap: 2px; width: 11px; margin-left: 10px;" href="MainController?action=viewFS&freeSlotID=${searchBySubjectCode.freeSlotID}">
                                                                            <i class="fas fa-search"></i>View
                                                                        </a>
                                                                        <form action="MainController" method="GET">
                                                                            <input type="hidden" name="action" value="updateFS">
                                                                            <input type="hidden" name="freeSlotID" value="${searchBySubjectCode.freeSlotID}">
                                                                            <input type="hidden" name="subjectCode" value="${searchBySubjectCode.subjectCode.trim()}" required/>
                                                                            <input type="hidden" name="startTime" value="${searchBySubjectCode.startTime}">
                                                                            <input type="hidden" name="endTime" value="${searchBySubjectCode.endTime}">
                                                                            <input type="hidden" name="semesterID" value="${searchByNull.semesterID}">
                                                                            <button type="submit" style="display: flex; text-decoration: none; justify-content: center;">
                                                                                <i class="material-icons">update</i>Update
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:if>          

                                </div>
                            </c:if>
                        <!--     SEARCH BY NULL ---------------------------------------------------------->
                        <c:if test="${empty param.txtStartTime and empty param.txtEndTime and empty param.txtSubjectCode}">
                            <div class="container mt-5" style="    margin-top: -3% !important;">
                                <div class="row justify-content-center mt-5">
                                    <c:if test="${requestScope.SEARCH_CREATED_SLOT_BY_NULL !=null}">
                                        <c:if test="${not empty requestScope.SEARCH_CREATED_SLOT_BY_NULL}">
                                            <c:forEach var="searchByNull" varStatus="counter" items="${requestScope.SEARCH_CREATED_SLOT_BY_NULL}">
                                                <div class="col-md-4">
                                                    <div class="card" style="width: 364px; height:  242px; border-radius: 5%;">
                                                        <div class="card-body">
                                                            <form action="MainController" method="POST">
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="subjectCode" value="${searchByNull.subjectCode.trim()}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                    <span class="ml-auto">${searchByNull.lectureName}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByNull.startTime}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByNull.endTime}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByNull.meetLink}"/>-->
                                                                    <a class="ml-auto" href="https://${searchByNull.meetLink}" onclick="confirmCheckAttendanceLinkByNull(event, '${searchByNull.freeSlotID}')"> Link Meet</a>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="semesterID" value="${searchByNull.semesterID}"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between btn-book">

                                                                    <div>
                                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to hide this Free Slot')" href="MainController?action=hideFS&freeSlotID=${searchByNull.freeSlotID}">
                                                                            <i class="material-icons">cancel</i>Hide
                                                                        </a>
                                                                        <a class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to delete this Free Slot')" href="MainController?action=deleteFS&freeSlotID=${searchByNull.freeSlotID}">
                                                                            <i class="material-icons">delete</i>Delete
                                                                        </a>
                                                                    </div>
                                                                    <div>

                                                                        <a class="d-flex justify-content-between" style="text-decoration: none; gap: 2px; width: 11px; margin-left: 10px;" href="MainController?action=viewFS&freeSlotID=${searchByNull.freeSlotID}">
                                                                            <i class="fas fa-search"></i>View
                                                                        </a>
                                                                        <form action="MainController" method="GET">
                                                                            <input type="hidden" name="action" value="updateFS">
                                                                            <input type="hidden" name="freeSlotID" value="${searchByNull.freeSlotID}">
                                                                            <input type="hidden" name="subjectCode" value="${searchByNull.subjectCode.trim()}" required/>
                                                                            <input type="hidden" name="startTime" value="${searchByNull.startTime}">
                                                                            <input type="hidden" name="endTime" value="${searchByNull.endTime}">
                                                                            <input type="hidden" name="semesterID" value="${searchByNull.semesterID}">
                                                                            <button type="submit" style="display: flex; text-decoration: none; justify-content: center;">
                                                                                <i class="material-icons">update</i>Update
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:if>          

                                </div>
                            </c:if>


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
                            <% }%>
                            </body>
                            </html>
