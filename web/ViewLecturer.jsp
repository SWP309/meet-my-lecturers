<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="./ViewLecturer.css" />
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
        <div class="table-timetable">
            <c:if test="${not empty requestScope.LIST_LECTURERS}">
                
                <table border="1" class="table-timetable-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>LecturerID</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.LIST_LECTURERS}" 
                                   var="lecturer" varStatus="status">
                            <tr>
                                        <td>${status.count}</td>
                                        <td>${lecturer.userID}</td>
                                        <td>${lecturer.userName}</td>
                                        <td>${lecturer.userEmail}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
        <c:if test="${empty requestScope.LIST_LECTURERS}">
            <h3 style="color: red">${requestScope.MESSAGE}</h3>
        </c:if>
            
        </div>
      <div class="backbutton" onclick="submitFormBack()">
          <form action="MainController" method="POST" style="display: none;">
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
