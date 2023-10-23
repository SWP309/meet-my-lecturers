<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./ViewRequest.css" />
        <script>
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
            function submitFormBackToLecturerHome() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }
        </script>
    </head>
    <body>
        <div class="admin-viewusersedited">
            <div class="admin-viewusers">
                <div class="fptu-eng-1-parent">
                    <img
                        class="fptu-eng-1-icon1"
                        alt=""
                        src="./public/UsersView/2021fptueng-11@2x.png"
                        />

                    <div class="frame-parent logout" onclick="submitFormLogout()">
                        <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="Logout" />
                        </form>
                        <div class="frame-group">
                            <div class="frame-div">
                                <div class="logout-wrapper">
                                    <img class="logout-icon1" alt="" src="./public/UsersView/logout1.svg" />
                                </div>
                                <div class="div">
                                    <p class="logout2">Logout</p>
                                </div>
                            </div>
                        </div>
                        <img class="frame-child" alt="" src="./public/UsersView/group-33.svg" />
                    </div>
                </div>
                <div class="view-user-table">
                    
                    <c:if test="${not empty requestScope.LIST_REQUESTS}">
                        <div>
                            <table border="1">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>RequestID</th>
                                        <th>StudentID</th>
                                        <th>Student's Name</th>
                                        <th>Subject Code</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Description</th>
                                        <th>Accept</th>
                                        <th>Decline</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.LIST_REQUESTS}" 
                                               var="request" varStatus="counter">
                                        <tr>
                                    <form action="MainController" method="POST">
                                        <td>${counter.count}</td>
                                        <td>${request.requestID}</td>
                                        <td>${request.studentID}</td>
                                        <td>
                                        <c:set var="breakLoop" value="false" />
                                            <c:forEach var="user" items="${requestScope.LIST_REQUESTS_USERS}">
                                                <c:if test="${!breakLoop and request.studentID eq user.userID}">
                                                    ${user.userName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${request.subjectCode}</td>
                                        <td>${request.startTime}</td>
                                        <td>${request.endTime}</td>
                                        <td>${request.description}</td>
                                        <td>
                                            <input type="hidden" name="txtRequestID" 
                                                   value="${request.requestID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="AcceptRequest">Accept</button>
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtRequestID" 
                                                   value="${request.requestID}" readonly="">
                                            <button type="submit" name="action"
                                                    value="DeleteRequest">Decline</button>
                                        </td>
                                    </form>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>  
                    <c:if test="${empty requestScope.LIST_REQUESTS}">
                        <h3 style="color: red">${requestScope.VIEW_REQUEST_MESSAGE}</h3>
                    </c:if>  
                </div>
            </div>

            <div class="backbutton" onclick="submitFormBackToLecturerHome()">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="BackToLecturerHome">
                </form>
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="./public/UsersView/back.svg" />
            </div>
        </div>
    </body>
</html>
