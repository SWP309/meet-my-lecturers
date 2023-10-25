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
        </style>
        <script>
            function submitFormViewLecturer() {
                var form = document.querySelector('.frame-container form');
                form.submit();
            }
            function submitFormSendRequest() {
                var form = document.querySelector('.create-request form');
                form.submit();
            }
            function submitFormHomePage() {
                var form = document.querySelector('.returnHome form');
                form.submit();
            }

            function goBack() {
                window.history.back();
            }
            function functionFormTimeTableView() {
                var form = document.querySelector('.request form');
                form.submit();
            }

        </script>

    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePage" />
                </form>
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />
            </div>

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div bookingview" onclick="submitForm()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewBooking" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                            <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                        </div>
                        <div class="view-booking" >View Booking</div>
                    </div>
                    <div class="frame-div request" onclick="submitFormRequest()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="Request" />
                        </form>

                        <i class="material-icons">mail_outline</i> Request
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
                    <img class="frame-item" alt="" src="./public/StudentHome/group-33.svg" 
                         onclick="showUserInfo()" />
                    <div id="user-info" style="display: none;">
                        <p id="user-id"> </p>
                        <p id="user-name"></p>
                        <p id="user-email"></p>
                    </div>
                </div>

            </div>
        </div>
        <div class="container mt-5 create-request" style="margin-top: 12% !important;">
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="CreateRequest">

                <div class="form-group row">
                    <label for="txtSemester" class="col-md-2 col-form-label"><strong>Semester:</strong></label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="txtSemester" name="txtSemester" value="${param.txtSemester}" placeholder="(ex:FA23)" required="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtLecturer" class="col-md-2 col-form-label"><strong>Lecturer:</strong></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control"  id="txtLecturer"  name="txtLecturer" value="${param.txtLecturer}" placeholder="GVxxxx" required="">
                    </div>
                    <a class="btn btn-primary col-sm-2" onclick="functionFormTimeTableView" href="MainController?action=ViewTimetable&txtSemester=${param.txtSemester}&txtLecturer=${param.txtLecturer}">View Timetable</a>                   
                </div>
                <div class="form-group row">
                    <label for="txtSubjectCode" class="col-md-2 col-form-label"><strong>Subject code:</strong></label>
                    <div class="col-md-10">
                        <input class="form-control" type="text" id="txtSubjectCode" name="txtSubjectCode" value="" required=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtStartTime" class="col-md-2 col-form-label"><strong>Start time:</strong></label>
                    <div class="col-md-10">
                        <input type="datetime-local" class="form-control" id="txtStartTime" name="txtStartTime" value="" required="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtEndTime" class="col-md-2 col-form-label"><strong>End time:</strong></label>
                    <div class="col-md-10">
                        <input type="datetime-local" class="form-control" id="txtEndTime" name="txtEndTime" value="" required="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtDescription" class="col-md-2 col-form-label"><strong>Description:</strong></label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="txtDescription" name="txtDescription" value="" required="">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-10 offset-md-2">
                        <div class="btn btn-success btn-lg rounded-pill"  onclick="submitFormSendRequest()">Send Request</div>
                    </div>
                </div>
            </form>
        </div>       




        <div class="backbutton"  onclick="goBack()">
            <div class="back">Back</div>
            <img class="back-icon" alt="" src="./public/request/back.svg" />
        </div>



        <!-- Thêm liên k?t ??n Bootstrap JS và jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-KyZXEAg3QhqLMpG8r+J9pAEz6/LnYV5TOqDGIbpbzFq8qz5S7fF46kSEBzav6U7xj"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI"
            crossorigin="anonymous"
        ></script>


    </body>
</html>
