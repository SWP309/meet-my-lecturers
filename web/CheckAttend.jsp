<%-- 
    Document   : CheckAttend
    Created on : Nov 1, 2023, 11:34:56 PM
    Author     : Minh Khang
--%>
<%@page import="sample.users.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.semester.SemesterDAO"%>
<%@page import="sample.semester.SemesterDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
                <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
                
            %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./ViewRequest.css" />
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

        <style>
            .table-container {
                display: flex;
                justify-content: center;
                margin: auto;
                margin-top: 5%;
            }

            .custom-table {
                border-collapse: collapse;
                width: 100%;
            }

            .custom-table th,
            .custom-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            .custom-table th {
                background-color: #f2f2f2;
                color: #333;
            }

            .btn-accept {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-decline {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                font-size: 14px;
            }

            .error-message {
                color: red;
                text-align: center;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <form action="MainController" method="POST">
                <div class="row mt-3">
                    <div class="col-md-2">
                        <c:if test="${not empty requestScope.semester}">
                            <select class="form-select" name="txtsemes">
                                <c:forEach var="semesList" varStatus="counter" items="${requestScope.semester}">
                                    <option value="${semesList.semesterID}">${semesList.semesterName}</option>
                                </c:forEach>
                            </select>
                        </c:if>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" value="attendanceservlet" name="action" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="view-user-table">

            <div class="table-container">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Free Slot ID</th>
                            <th>Semester ID</th>
                            <th>Subject Code</th>                             
                            <th>Start Time</th>                             
                            <th>End Time</th>                             
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.attend}" var="slotAttend" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${slotAttend.freeSlotID}</td>
                                
                                <td>${slotAttend.semesterID}</td>
                                <td>${slotAttend.subjectCode}</td>
                                <td>${slotAttend.startTime}</td>
                                <td>${slotAttend.endTime}</td>
                                
                                <td style="color: green">Present</td>
<%--                                
                                <c:choose>
                                     <c:when test="${slotAttend.status == 2}">
                                <td>
                                    <button type="submit" name="action" value="AcceptRequest" class="btn-accept">Accept</button>
                                </td>
                                     </c:when>
                                     <c:otherwise>
                                <td>
                                    <button type="submit" name="action" value="DeleteRequest" class="btn-decline">Decline</button>
                                </td>
                                </c:otherwise>
                                </c:choose>
                                --%>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
        <% } else{
        response.sendRedirect("MainController?action=");
}
        %>
    </body>
</html>
