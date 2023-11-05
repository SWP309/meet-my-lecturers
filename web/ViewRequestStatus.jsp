
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Thêm liên kết đến Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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
            th {
                text-align: center;
            }
            td {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-light">
            <a class="navbar-brand" href="#">
                <img src="https://cdn.haitrieu.com/wp-content/uploads/2021/10/Logo-Dai-hoc-FPT.png" width="100" class="d-inline-block align-top" alt="Logo">
            </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="cus nav-link" href="#">
                            <i class="fas fa-calendar-alt"></i> View Booking
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="cus nav-link" href="#">
                            <i class="fas fa-file" style="margin-right: 5px;"></i>Create Request
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="cus nav-link" href="#" >
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                    <li class="nav-item" id="user-icon">
                        <a class="nav-link text-black" href="#">
                            <i class="fas fa-user"></i> User
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container mt-5">
            <form action="MainController" method="POST">
                <div class="row align-items-center">
                    <div class="form-group">
                        <input type="text" class="form-control " name="txtSubjectCode" value="${param.txtSubjectCode}" placeholder="SubjectCode" pattern="^[A-Z]{3}[0-9]{3}$">
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="txtRequestStatus">
                            <option value="All">All Requests</option>
                            <option value="Accepted">Accepted</option>
                            <option value="Declined">Declined</option>
                            <option value="InProgress">In progress</option>
                            <option value="Overdue">Overdue</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="txtSemesterID">
                            <option value="FA23">FA23</option>
                            <option value="SU23">SU23</option>
                            <option value="SP23">SP23</option>
                            <option value="FA22">FA22</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary form-control" type="submit" name="action" value="SearchRequestStatus">Search</button>
                    </div>
                </div>
            </form>

            <div class="row justify-content-center mt-5">
                <c:if test="${empty param.txtSubjectCode and not empty requestScope.LIST_REQUEST}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.LIST_REQUEST}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.LIST_USER}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>

                                            <c:if test="${request.status == 3}">
                                                <b style="color: gray">Overdue</b>
                                            </c:if></c:if>
                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if>
                                    </td>
                                    <c:if test="${empty request.note || request.note == null}">
                                        <td>
                                            <b>None</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty request.note || request.note != null}">
                                        <td>
                                            <b>${request.note}</b>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_STATUS}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.REQUEST_BY_STATUS}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.USER_BY_STATUS}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if>
                                    </td>
                                    <c:if test="${empty request.note || request.note == null}">
                                        <td>
                                            <b>None</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty request.note || request.note != null}">
                                        <td>
                                            <b>${request.note}</b>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${not empty param.txtSubjectCode and not empty requestScope.REQUEST_BY_SUBCODE_AND_STATUS}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.REQUEST_BY_SUBCODE_AND_STATUS}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.USER_BY_SUBCODE_AND_STATUS}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if>
                                    </td>
                                    <c:if test="${empty request.note || request.note == null}">
                                        <td>
                                            <b>None</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty request.note || request.note != null}">
                                        <td>
                                            <b>${request.note}</b>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>Lecturer ID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.ALL_REQUEST}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.ALL_USER}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if>
                                    </td>
                                    <c:if test="${empty request.note || request.note == null}">
                                        <td>
                                            <b>None</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty request.note || request.note != null}">
                                        <td>
                                            <b>${request.note}</b>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${not empty param.txtSubjectCode and not empty requestScope.ALL_REQUEST_BY_SUBCODE}">
                    <table border="1" class="table table-hover table-primary table-rounded table-timetable-table">
                        <thead>
                            <tr class="table-danger">
                                <th>No.</th>
                                <th>Semester</th>
                                <th>Subject Code</th>
                                <th>LecturerID</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.ALL_REQUEST_BY_SUBCODE}" 
                                       var="request" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${request.semesterID}</td>
                                    <td>${request.subjectCode}</td>
                                    <td>${request.lecturerID}</td>
                                    <td>
                                        <c:set var="breakLoop" value="false" />
                                        <c:forEach var="user" items="${requestScope.ALL_USER_BY_SUBCODE}">
                                            <c:if test="${!breakLoop and user.userID eq request.lecturerID}">
                                                ${user.userName}
                                                <c:set var="breakLoop" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${request.startTime}</td>
                                    <td>${request.endTime}</td>
                                    <td>
                                        <c:if test="${request.status == 1}">
                                            <b style="color: green">Accepted</b>
                                        </c:if>
                                        <c:if test="${request.status == 2}">
                                            <b style="color: #cccc00">In progress</b>
                                        </c:if>
                                        <c:if test="${request.status == 0}">
                                            <b style="color: red">Declined</b>
                                        </c:if>
                                        <c:if test="${request.status == 3}">
                                            <b style="color: gray">Overdue</b>
                                        </c:if>
                                    </td>
                                    <c:if test="${empty request.note || request.note == null}">
                                        <td>
                                            <b>None</b>
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty request.note || request.note != null}">
                                        <td>
                                            <b>${request.note}</b>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>        
        <!-- Thêm liên kết đến Bootstrap JS và jQuery -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>