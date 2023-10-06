<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./request.css" />
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
    </head>
    <body>
        <form action="MainController" method="POST">


            <div class="student-request">


                <div class="infor">

                    <div class="lectucrer">
                        <div class="lectucrer-child">"></</div>
                        <div class="lecturer">
                            Lecturer:<input type="text" name="txtLecturer" value="" />
                        </div>
                    </div>
                </div>
                <div class="subject-code">
                    <div class="lectucrer-child"></div>
                    <div class="subject-code1">
                        Subject code:<input type="text" name="txtSubjectCode" value="" />
                    </div>
                </div>
                <div class="semester">
                    <div class="semester-child"></div>
                    <div class="semester1">
                        Semester:<input type="text" name="txtSemester" value="" />
                    </div>
                </div>
                <div class="start-time">
                    <div class="semester-child"></div>
                    <div class="start-time1">
                        Start time(YYYY-MM-DD HH: MI: SS):<input type="datetime-local" name="txtStartTime" value="" />
                    </div>
                </div>
                <div class="end-time">
                    <div class="semester-child"></div>
                    <div class="end-time1"> 
                        End time(YYYY-MM-DD HH: MI: SS):<input type="datetime-local" name="txtEndTime" value="" />
                    </div>
                </div>
                <div class="description">
                    <div class="description-child"></div>
                    <div class="description1">
                        Description:<input type="text" name="txtDescription" value="" />
                    </div>
                </div>

            </div>

            <div class="sendrequestbutton">
                <div class="sendrequestbutton-child"></div>
                <div class="send-request">
                    <input type="submit" value="Send request" name="action">  
                </div>
            </div>
        </form>




        <div class="backbutton">
            <div class="back">Back</div>
            <img class="back-icon" alt="" src="./public/request/back.svg" />
        </div>
        <div class="header">
            <img
                class="fptu-eng-1-icon"
                alt=""
                src="./public/request/2021fptueng-1@2x.png"
                />

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-container">
                        <div class="bookedslot-wrapper">
                            <img
                                class="bookedslot-icon"
                                alt=""
                                src="./public/request/bookedslot.svg"
                                />
                        </div>
                        <div class="view-booking">View Booking</div>
                    </div>
                    <div class="frame-div">
                        <div class="bookedslot-wrapper">
                            <div class="div">+</div>
                        </div>
                        <div class="div">Request</div>
                    </div>
                    <div class="frame-parent1">
                        <div class="logout-wrapper">
                            <img class="logout-icon" alt="" src="./public/request/logout.svg" />
                        </div>
                        <div class="div">
                            <p class="logout1">Logout</p>
                        </div>
                    </div>
                </div>
                <img class="frame-item" alt="" src="./public/request/group-33.svg" />
            </div>
        </div>

    </div>


</body>
</html>
