<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="./TimetableView.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
    />
    <script>
            function submitFormBack() {
                var form = document.querySelector('.backbutton form');
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
        <div class="table-timetable">
            <c:if test="${not empty requestScope.TB_TIMETABLES}">
                <table border="1" class="table-timetable-table">
                    <thead>
                        <tr>
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
      <div class="backbutton" onclick="submitFormBack()">
          <form action="MainController" method="POST" style="display: none;">
              <input type="hidden" name="txtLecturer" value="${requestScope.TB_TIMETABLES.get(0).lecturerID}" />
              <input type="hidden" name="txtSemester" value="${requestScope.TB_TIMETABLES.get(0).semesterID}" />
                <input type="hidden" name="action" value="BackToRequest" />
          </form>
        <div class="back">
          <div class="back1">Back</div>
          <img class="vector-icon" alt="" src="./public/TimetableView/vector.svg" />

          <img class="vector-icon1" alt="" src="./public/TimetableView/vector1.svg" />

          <img class="vector-icon2" alt="" src="./public/TimetableView/vector2.svg" />
        </div>
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
            <div class="frame-div">
              <div class="logout-wrapper">
                <img class="logout-icon1" alt="" src="./public/TimetableView/logout1.svg" />
              </div>
              <div class="logout1">
                <p class="logout2">Logout</p>
              </div>
            </div>
          </div>
          <img class="frame-child" alt="" src="./public/TimetableView/group-33.svg" />
        </div>
      </div>
    </div>
  </body>
</html>
