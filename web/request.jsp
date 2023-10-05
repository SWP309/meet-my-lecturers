<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="./global.css" />
    <link rel="stylesheet" href="./student-request.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
    />
  </head>
  <body>
    <div class="student-request">
      <div class="header1">
        <div class="header-child1"></div>
        <img
          class="fptu-eng-1-icon1"
          alt=""
          src="./public/2021fptueng-11@2x.png"
        />

        <div class="header-child2"></div>
        <div class="header-child3"></div>
        <img class="account-icon1" alt="" src="./public/account1.svg" />

        <div class="requestbutton1">
          <div class="requestbutton-item"></div>
          <div class="request1">Request</div>
          <img class="icon1" alt="" src="./public/1.svg" />
        </div>
        <div class="viewbookedslotbutton1">
          <div class="viewbookedslotbutton-item"></div>
          <div class="view-booked-slot1">View booked slot</div>
          <img class="bookedslot-icon1" alt="" src="./public/bookedslot1.svg" />
        </div>
        <div class="logoutbutton1">
          <div class="requestbutton-item"></div>
          <div class="request1">Logout</div>
          <img class="logout-icon1" alt="" src="./public/logout1.svg" />
        </div>
      </div>
      <div class="backbutton">
        <img class="back-icon" alt="" src="./public/back.svg" />

        <div class="back">Back</div>
      </div>
      <div class="infor">
        <div class="infor-child"></div>
        <div class="infor-item"></div>
        <div class="infor-inner"></div>
        <div class="rectangle-div"></div>
        <div class="infor-child1"></div>
        <div class="infor-child2"></div>
        <div class="infor-child3"></div>
        <form action="MainController" method="POST">
            <div class="lecture">
                Lecturer:<input type="text" name="txtLecturer" value="" />
            </div>
            <div class="subject-code">
                Subject code:<input type="text" name="txtSubjectCode" value="" />
            </div>
            <div class="semester">
                Semester:<input type="text" name="txtSemester" value="" />
            </div>
            <div class="start-time">
                Start time(YYYY-MM-DD HH: MI: SS):<input type="datetime-local" name="txtStartTime" value="" />
            </div>
            <div class="end-time">
                End time(YYYY-MM-DD HH: MI: SS):<input type="datetime-local" name="txtEndTime" value="" />
            </div>
            <div class="description">
                Description:<input type="text" name="txtDescription" value="" />
            </div>
            <div class="sendrequestbutton">
              <div class="sendrequestbutton-child"></div>
              <div class="send-request">
                  <input type="submit" value="Send request" name="action">  
              </div>
            
        </form>
        </div>
      </div>
      <div class="schedule">
        <img class="vector-icon" alt="" src="./public/vector.svg" />

        <img class="vector-icon1" alt="" src="./public/vector.svg" />

        <img class="vector-icon2" alt="" src="./public/vector1.svg" />

        <img class="vector-icon3" alt="" src="./public/vector2.svg" />
      </div>
    </div>
  </body>
</html>
