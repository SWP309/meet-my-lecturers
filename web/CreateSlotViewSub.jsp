<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.viewCreatedSlot.ViewCreatedSlotDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                        
        %>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./CreateSlotViewSub.css" />
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
            function submitForm() {
                var form = document.querySelector('.viewCreateSlot form');
                form.submit();
            }
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormCreate() {
                var form = document.querySelector('.CreateFSlot form');
                form.submit();
            }
            function submitFormViewRequest() {
                var form = document.querySelector('.request-div form');
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
                    window.location.href = "MainController?action=delete&freeSlotID=2";
//                   window.location.href = "MainController?action=delete&freeSlotID=" + document.querySelector('[name="freeSlotID"]').value;
                } else {
                    // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
                    // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
                    event.preventDefault();
                }
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
                    <div class="frame-div hideView" style="background-color: #b7b7b7;">
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

                    <div style="cursor: pointer">
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
        <div class="frame-Create CreateFSlot" style="cursor: pointer; color: white" onclick="submitFormCreate()">
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="CreateFS" />
            </form>

            <i class="material-icons">add</i>
        </div>

        <div class="student-viewbookedslot">
            <div class="container mt-5" style="    margin-top: 9% !important;">
                <div class="row justify-content-center mt-5">
                    <c:if test="${requestScope.LIST_CREATED_SLOT_SUB !=null}">
                        <c:if test="${not empty requestScope.LIST_CREATED_SLOT_SUB}">
                            <c:forEach var="listCreatedSlotSub" varStatus="counter" items="${requestScope.LIST_CREATED_SLOT_SUB}">
                                <div class="col-md-4">
                                    <div class="card" style="width: 340px; height: 192px; border-radius: 5%;">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Subject Code:</b></strong> <span class="ml-auto">${listCreatedSlotSub.subjectCode.trim()}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Lecturer's Name:</b></strong> <span class="ml-auto">${listCreatedSlotSub.lectureName}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>Start time:</b></strong> <span class="ml-auto">${listCreatedSlotSub.startTime}</span></div>
                                            <div class="d-flex justify-content-between"><strong style="color: red"><b>End time:</b></strong> <span class="ml-auto">${listCreatedSlotSub.endTime}</span></div>
                                            <div class="d-flex justify-content-between btn-book">
                                                <!--                                             Added d-flex justify-content-between to create a flex container -->
                                                <div>
                                                    <a  class="d-flex justify-content-between" style="text-decoration: none;" onclick="return confirm('Are you sure to Unhide this Free Slot')"
                                                        href="MainController?action=UnhideFS&freeSlotID=${listCreatedSlotSub.freeSlotID}">
                                                        <i class="material-icons">cancel</i>Unhide</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>          

                </div>
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
            <% 
                } else {
                    response.sendRedirect("Maincontroller?action=");
                }
            %>
    </body>
</html>
