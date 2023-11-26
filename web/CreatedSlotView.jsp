<%@page import="sample.freeslots.FreeSlotsDTO"%>
<%@page import="sample.freeslots.FreeSlotsDAO"%>
<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDAO"%>
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

        <link rel="stylesheet" href="./LecturerPage.css" />
        <link rel="stylesheet" href="./style.css">
        <link rel="stylesheet" href="./slick.css">
        <script src="./lecturer.js"></script>
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
        <!--        animation --------------->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

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
            function updateFileName(inputId) {
                const input = document.getElementById(inputId);
                const fileName = input.value.split('\\').pop();
                input.nextElementSibling.innerHTML = fileName;
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
        <div class="fptu-eng-1-parent">
            <div class="returnHome" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageLecturer" />
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
                    <button onclick="myFunctionDropdown()" class="dropbtn"> 
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div id="myDropdown" class="dropdown-content" style="right: 0px;
                         flex-direction: column;
                         ">
                        <div class="frame-div returnHomeDiv" onclick="submitFormHomePageDiv()"> 
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="returnHomePageLecturer" />
                                <i class="material-icons">home</i>
                            </form>
                            Home
                        </div>
                        <div class="frame-div viewCreateSlot" style="background-color: #b7b7b7;">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="viewFSlotLecturer" />
                            </form>
                            <i class="material-icons">visibility</i>View Create Slot
                        </div>
                        <div class="frame-div request-div" onclick="submitFormViewRequest()">
                            <form style="display: flex; align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="ViewRequest" />
                                <i class="material-icons">mail_outline</i>
                            </form>
                            View Request
                        </div>
                        <div class="frame-div lecturerProfile" onclick="submitFormViewLecturerProfile()">
                            <form style="display: flex; align-content: center;" action="MainController" method="POST">
                                <input type="hidden" name="action" value="viewLecturerProfile" />
                                <i class="material-icons">person</i>
                            </form>
                            View Lecturer Profile
                        </div>
                        <div class="frame-div hideView" onclick="submitFormHideView()">
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
        <div class="container-div" style=" display: flex;
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
            <div id="mybutton" class="frame-choice importTimetables" style="cursor: pointer; color: white" onclick="submitFormImportTimetables()" title="Import timetables">
                <i class="fas fa-file-import"></i>
            </div>
        </div> 
        <div class="container mt-5" id="myModal" style="display: none;">

            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="padding-right: 100px; display: inline-block">
                    Import Timetables
                </div>
                <%
                    String TIMESERVLET = (String) request.getAttribute("TIMESERVLET");
                    String DUPLICATEDATA = (String) request.getAttribute("DUPLICATEDATA");
                    String DUPLICATEDATATIMETABLE = (String) request.getAttribute("DUPLICATEDATATIMETABLE");

                    if (TIMESERVLET != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= TIMESERVLET%>
                </span>
                <%
                    }
                %>
                <a href="https://drive.google.com/drive/folders/1s_yu8ElI5rP6RaON6SLxFOIN5kmEUh4D?usp=drive_link" target="_blank" style="color: blueviolet">Download template</a>
                <div class="form-group input-group">
                    <div class="custom-file">
                        <input type="file" name="txtexcel" class="custom-file-input" id="DSSV"  onchange="updateFileName('DSSV')" required>
                        <label class="custom-file-label">Choose file</label>
                    </div>                    
                    <input type="text" class="form-control" name="lecID" placeholder="E.g: GV0001" required>
                    <input type="text" class="form-control" name="semesID" placeholder="E.g: FA23" required>
                    <div class="input-group-append">
                        <button style="background-color: #0d6efd; color: white;" type="submit" value="importTB" name="action" class="btn btn-primary custom-submit-button">Submit</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="student-viewbookedslot">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div>
                        <form action="MainController" method="POST" class="d-flex justify-content-center">
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtStartTime" value="${param.txtStartTime}">
                            </div>
                            <div class="form-group">
                                <input type="datetime-local" class="form-control" name="txtEndTime" value="${param.txtEndTime}">
                            </div>
                            <%  FreeSlotsDAO searchDao = new FreeSlotsDAO();
                                List<FreeSlotsDTO> listSubject = searchDao.GetListSubject();%>
                            <div class="form-group">
                                <select class="form-control option" name="txtSubjectCode" onchange="updateHiddenField(this, 'hiddenSubjectCode')">
                                    <% for (FreeSlotsDTO list : listSubject) {%>
                                    <option value="<%= list.getSubjectCode()%>"><%= list.getSubjectCode()%></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary form-control Search-custom" style="border-color: black; background: #0d6efd; color: white;" type="submit" name="action" value="searchCSlot">Search</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <!--  LIST OF THE PAGE -------------------------------------------------------------->
            <div class="container mt-5" style="    margin-top: -13% !important; max-height: 1000%; height: 1000px">

                <!--                        <div class="pagination">
                                            <a class="d-flex justify-content-between" href="MainController?action=countPageAction&CountPage=${counter.count}">${counter.count}</a>
                                        </div>-->
                <div class="row justify-content-center mt-5 tableview">
                    <c:if test="${requestScope.LIST_CREATED_SLOT !=null}">
                        <c:if test="${not empty requestScope.LIST_CREATED_SLOT}">
                            <c:forEach var="listCreatedSlot" varStatus="counter" items="${requestScope.LIST_CREATED_SLOT}">
                                <div class="col-md-4">
                                    <div class="card" style="    width: 100%;
                                         height: auto;
                                         border-radius: 5%;">
                                        <div class="card-body">
                                            <form action="MainController" method="POST">
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture ID:</b></strong> 
                                                    <span class="ml-auto specific-input">${listCreatedSlot.freeSlotID}</span>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                    <span class="ml-auto specific-input">${listCreatedSlot.subjectCode.trim()}</span>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                    <span class="ml-auto specific-input">${listCreatedSlot.lectureName}</span>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="startTime" value="${listCreatedSlot.startTime}"  pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${listCreatedSlot.endTime}"   pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Link Meet:</b></strong> 
    <!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${listCreatedSlot.meetLink}"/>-->
                                                    <a class="ml-auto specific-input" href="https://${listCreatedSlot.meetLink}" onclick="confirmCheckAttendanceLink(event, '${listCreatedSlot.freeSlotID}')" target="_blank"> Link Meet</a>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> 
                                                    <span class="ml-auto specific-input">${listCreatedSlot.semesterID}</span>
                                                </div>
                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Joined Members:</b></strong> 
                                                    <span class="ml-auto specific-input"> ${listCreatedSlot.joinedMembers}/${listCreatedSlot.capacity}</span>
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
                                                            <input type="hidden" name="subjectCode" id="subjectCodeInput" value="${listCreatedSlot.subjectCode.trim()}" required/>
                                                            <input type="hidden" name="startTime" value="${listCreatedSlot.startTime}">
                                                            <input type="hidden" name="endTime" value="${listCreatedSlot.endTime}">
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
                                            <div class="card" style="    width: 100%;
                                                 height: auto;
                                                 border-radius: 5%;">
                                                <div class="card-body">
                                                    <form action="MainController" method="POST">
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture ID:</b></strong> 
                                                            <span class="ml-auto specific-input">${searchByStEt.freeSlotID}</span>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                            <span class="ml-auto specific-input">${searchByStEt.subjectCode.trim()}</span>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                            <span class="ml-auto specific-input">${searchByStEt.lectureName}</span>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByStEt.startTime}"    pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                            <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByStEt.endTime}"    pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Link Meet:</b></strong> 
    <!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByStEt.meetLink}"/>-->
                                                            <a class="ml-auto specific-input" href="https://${searchByStEt.meetLink}" target="_blank" onclick="confirmCheckAttendanceLinkByStEt(event, '${searchByStEt.freeSlotID}')"> Link Meet</a>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> 
                                                            <span class="ml-auto specific-input">${searchByStEt.semesterID}</span>
                                                        </div>
                                                        <div class="d-flex justify-content-between"><strong style="color: red"><b>Joined Members:</b></strong> 
                                                            <span class="ml-auto specific-input"> ${searchByStEt.joinedMembers}/${searchByStEt.capacity}</span>
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
                                                <div class="card" style="    width: 100%;
                                                     height: auto;
                                                     border-radius: 5%;">
                                                    <div class="card-body">
                                                        <form action="MainController" method="POST">
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture ID:</b></strong> 
                                                                <span class="ml-auto specific-input">${searchByAll.freeSlotID}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                <span class="ml-auto specific-input">${searchByAll.subjectCode.trim()}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                <span class="ml-auto specific-input">${searchByAll.lectureName}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByAll.startTime}"   pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByAll.endTime}"    pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Link Meet:</b></strong> 
    <!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByAll.meetLink}"/>-->
                                                                <a class="ml-auto specific-input" href="https://${searchByAll.meetLink}" target="_blank" onclick="confirmCheckAttendanceLinkByAll(event, '${searchByAll.freeSlotID}')"> Link Meet</a>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> 
                                                                <span class="ml-auto specific-input">${searchByAll.semesterID}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Joined Members:</b></strong> 
                                                                <span class="ml-auto specific-input"> ${searchByAll.joinedMembers}/${searchByAll.capacity}</span>                                                            </div>
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
                                                    <div class="card" style="    width: 100%;
                                                         height: auto;
                                                         border-radius: 5%;">
                                                        <div class="card-body">
                                                            <form action="MainController" method="POST">
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture ID:</b></strong> 
                                                                    <span class="ml-auto specific-input">${searchBySubjectCode.freeSlotID}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                    <span class="ml-auto specific-input">${searchBySubjectCode.subjectCode.trim()}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                    <span class="ml-auto specific-input">${searchBySubjectCode.lectureName}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="startTime" value="${searchBySubjectCode.startTime}"   pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchBySubjectCode.endTime}"    pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b >Link Meet:</b></strong> 
<!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchBySubjectCode.meetLink}"/>-->
                                                                    <a class="ml-auto specific-input" href="https://${searchBySubjectCode.meetLink}" target="_blank" onclick="confirmCheckAttendanceLinkBySubjectCode(event, '${searchBySubjectCode.freeSlotID}')"> Link Meet</a>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> 
                                                                    <span class="ml-auto specific-input">${searchBySubjectCode.semesterID}</span>
                                                                </div>
                                                                <div class="d-flex justify-content-between"><strong style="color: red"><b>Joined Members:</b></strong> 
                                                                    <span class="ml-auto specific-input"> ${searchBySubjectCode.joinedMembers}/${searchBySubjectCode.capacity}</span>
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
                                <div class="container mt-5" style="    margin-top: -8% !important;">
                                    <div class="row justify-content-center mt-5 tableview">
                                        <c:if test="${requestScope.SEARCH_FREE_SLOT_BY_NULL !=null}">
                                            <c:if test="${not empty requestScope.SEARCH_FREE_SLOT_BY_NULL}">
                                                <c:forEach var="searchByNull" varStatus="counter" items="${requestScope.SEARCH_FREE_SLOT_BY_NULL}">
                                                    <div class="col-md-4">
                                                        <div class="card" style="    width: 100%;
                                                             height: auto;
                                                             border-radius: 5%;">
                                                            <div class="card-body">
                                                                <form action="MainController" method="POST">
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture ID:</b></strong> 
                                                                        <span class="ml-auto specific-input">${searchByNull.freeSlotID}</span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject:</b></strong> 
                                                                        <span class="ml-auto specific-input">${searchByNull.subjectCode.trim()}</span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecture name:</b></strong> 
                                                                        <span class="ml-auto specific-input">${searchByNull.lectureName}</span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> 
                                                                        <input type="text" class="ml-auto specific-input" name="startTime" value="${searchByNull.startTime}"  pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> 
                                                                        <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByNull.endTime}"   pattern="[0-3]{1}[0-9]{1}/[0-1]{1}[0-2]{1}/[0-9]{4} [0-2]{1}[0-9]{1}:(0[0-9]|60|[1-5][0-9])$"/>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Link Meet:</b></strong> 
                    <!--                                                    <input type="text" class="ml-auto specific-input" name="endTime" value="${searchByNull.meetLink}"/>-->
                                                                        <a class="ml-auto specific-input" href="https://${searchByNull.meetLink}" target="_blank" onclick="confirmCheckAttendanceLink(event, '${searchByNull.freeSlotID}')"> Link Meet</a>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Semester:</b></strong> 
                                                                        <span class="ml-auto specific-input">${searchByNull.semesterID}</span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between"><strong style="color: red"><b>Joined Members:</b></strong> 
                                                                        <span class="ml-auto specific-input"> ${searchByNull.joinedMembers}/${searchByNull.capacity}</span>
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
                                                                            <form action="MainController" method="POST">
                                                                                <input type="hidden" name="action" value="updateFS">
                                                                                <input type="hidden" name="freeSlotID" value="${searchByNull.freeSlotID}">
                                                                                <input type="hidden" name="subjectCode" value="${searchByNull.subjectCode.trim()}" required/>
                                                                                <input type="hidden" name="startTime" value="${searchByNull.startTime}">
                                                                                <input type="hidden" name="endTime" value="${searchByNull.endTime}">
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
                                </c:if>
                            </div>
                            <c:if test="${not empty requestScope.COUNT_PAGE}">
                                <nav aria-label="Page navigation"style="justify-content: center;
                                     display: flex;
                                     margin-top: 80px;">
                                    <ul class="pagination">
                                        <%
                                            ViewCreatedSlotDAO dao = new ViewCreatedSlotDAO();
                                            int listCountPage = dao.CountPage(us.getUserEmail());
                                            int currentPage = request.getParameter("CountPage") != null ? Integer.parseInt(request.getParameter("CountPage")) : 1;
                                        %>
                                        <li class="page-item <%= currentPage == 1 ? "disabled" : ""%>">
                                            <a class="page-link" href="MainController?action=countPageAction&CountPage=<%= currentPage - 1%>">Previous</a>
                                        </li>
                                        <%
                                            for (int i = 1; i <= listCountPage; i++) {
                                        %>
                                        <li class="page-item <%= i == currentPage ? "active" : ""%>">
                                            <a class="page-link" href="MainController?action=countPageAction&CountPage=<%= i%>"><%= i%></a>
                                        </li>
                                        <%
                                            }
                                        %>
                                        <li class="page-item <%= currentPage == listCountPage ? "disabled" : ""%>">
                                            <a class="page-link" href="MainController?action=countPageAction&CountPage=<%= currentPage + 1%>">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>



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
