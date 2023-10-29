<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./TimetableView.css" />
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
            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.logout form');
                form.submit();
            }
        </script>
    </head>
    <body>
        <div class="student-lectures-schedule-edi">
            <div class="infor-lec">
                <div class="lecturer-lamnn15">Lecturer: ${requestScope.TB_TIMETABLES.get(0).lecturerID}</div>
                <div class="infor-lec-child"></div>
                <div class="semester-fall23-692023">
                    Semester: ${requestScope.TB_TIMETABLES.get(0).semesterID}
                </div>


            </div>
            <div class="table-timetable" style="margin-top: 19%;">
                <c:if test="${not empty requestScope.TB_TIMETABLES}">
                    <table border="1" class="table table-hover table-rounded">
                        <thead>
                            <tr  class="table table-warning">
                                <th>No.</th>
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
                            <c:forEach items="${requestScope.TB_TIMETABLES}" 
                                       var="timetable" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
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
                <c:if test="${empty requestScope.TB_TIMETABLES}">
                    <h3 style="color: red">${requestScope.TB_MESSAGE}</h3>
                </c:if>

            </div>
            <div class="backbutton"  onclick="submitFormBack()">
                <form action="MainController" method="POST" style="display: none;">
                    <input type="hidden" name="txtLecturer" value="${requestScope.TB_TIMETABLES.get(0).lecturerID}" />
                    <input type="hidden" name="txtSemester" value="${requestScope.TB_TIMETABLES.get(0).semesterID}" />
                    <input type="hidden" name="action" value="BackToRequest" />
                </form>
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="./public/request/back.svg" />
            </div>
            <div class="header1">
                <img
                    class="fptu-eng-1-icon1"
                    alt=""
                    src="./public/TimetableView/2021fptueng-11@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-container">
                            <div class="bookedslot-wrapper">
                                <img
                                    class="bookedslot-icon1"
                                    alt=""
                                    src="./public/TimetableView/bookedslot1.svg"
                                    />
                            </div>
                            <div class="view-booking">View Booking</div>
                        </div>
                        <div class="frame-div logout" onclick="submitFormLogout()" style="cursor: pointer">
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
                    <img class="frame-child" alt="" src="./public/TimetableView/group-33.svg" />
                </div>
            </div>
        </div>
    </body>
</html>
