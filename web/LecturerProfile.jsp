

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecturer Profile</title>
    </head>
    <body>
        <div>
            <h3>Lecturer ID: ${USER.userID}</h3>
            <h3>Name: ${USER.userName}</h3>
            <h3>Email: ${USER.userEmail}</h3>
        </div>
        <div>
            <form action="MainController" method="POST">
                <select class="form-control" name="txtSubjectCode">
                    <c:forEach items="${LIST_ADD_MAJORS}" var="subject">
                        <option value="${subject.subjectCode}">${subject.subjectCode}</option>
                    </c:forEach>
                </select>
                <button type="submit" name="action" value="AddMajor">Add Major</button>
            </form>
        </div>
        <div>
            <c:if test="${not empty requestScope.LIST_MAJORS}">
                <div class="table-container">
                    <table class="custom-table table-hover table-primary table-rounded">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Lecturer ID</th>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.LIST_MAJORS}" 
                                       var="major" varStatus="status">
                                <tr>
                            <form action="MainController" method="POST">
                                <td>${status.count}</td>
                                <td>${major.lecturerID}</td>
                                <td>${major.subjectCode}</td>
                                <td>${major.subjectName}</td>
                                <td>
                                    <input type="hidden" name="txtSubjectCode" 
                                           value="${major.subjectCode}" readonly="">
                                    <button type="submit" name="action"
                                            value="DeleteMajor">Delete</button>
                                </td>
                            </form>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
        <div>
            <c:if test="${not empty requestScope.LIST_TIMETABLES}">
                <table border="1" class="table table-hover table-rounded">
                    <thead style="font-size: 20px;">
                        <tr  class="table table-warning">
                            <th>No.</th>
                            <th>Semester ID</th>
                            <th>Slot ID</th>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Day 1</th>
                            <th>Day 2</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.LIST_TIMETABLES}" 
                                   var="timetable" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${timetable.semesterID}</td>
                                <td>${timetable.slotID}</td>
                                <td>${timetable.subjectCode}</td>
                                <td>
                                    <c:forEach var="subject" items="${requestScope.TB_SUBJECTS}">
                                        <c:if test="${subject.subjectCode eq timetable.subjectCode}">
                                            ${subject.subjectName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.day1}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.day2}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.startTime}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="slot" items="${requestScope.TB_SLOTS}">
                                        <c:if test="${slot.slotID eq timetable.slotID}">
                                            ${slot.endTime}
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty requestScope.LIST_TIMETABLES}">
                <h3 style="color: red">${requestScope.TIMETABLE_MESSAGE}</h3>
            </c:if>
        </div>

    </body>
</html>
