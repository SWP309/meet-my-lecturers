<%-- 
    Document   : StudentBookingPresence
    Created on : Nov 2, 2023, 9:26:56 AM
    Author     : CHIBAO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Student Booking Presence</title>
        <script>
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }
            function submitFormViewUsers() {
                var form = document.querySelector('.ViewUsers form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormImport() {
                var form = document.querySelector('.import form');
                form.submit();
            }
        </script>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageAdmin" />
                </form>
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />
            </div>

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewUsers" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                            <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div request import" onclick="submitFormImport()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="importPage" />
                        </form>
                        Import Schedule

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

        <div class="container">
            <div class="row">
                <c:if test="${not empty requestScope.LIST_BOOKING_PRESENCE_INFO} ">
                    <div class="col-md-10">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tiêu đề</th>
                                    <th>Nội dung</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Dòng 1</td>
                                    <td>Nội dung dòng 1</td>
                                </tr>
                                <tr>
                                    <td>Dòng 2</td>
                                    <td>Nội dung dòng 2</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-2">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tiêu đề</th>
                                    <th>Nội dung</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Dòng 1</td>
                                    <td>Nội dung dòng 1</td>
                                </tr>
                                <tr>
                                    <td>Dòng 2</td>
                                    <td>Nội dung dòng 2</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </c:if>
            </div>
        </div>

    </body>
</html>
