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
        <!-- Thêm liên k?t ??n Bootstrap CSS -->
        <link
            rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            >
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            h6 {
                border: none;
                margin-top: 4px;
                margin-bottom: 0px;
                padding: 2px;
                color: red;
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

            function goBack() {
                window.history.back();
            }
        </script>
    </head>
    <body>
        <div class="container mt-5 create-request" style="margin-top: 12% !important;">
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="CreateRequest">

                <div class="form-group row">
                    <label for="txtSemester" class="col-md-2 col-form-label"><strong>Semester:</strong></label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="txtSemester" name="txtSemester" value="${param.txtSemester}" placeholder="(ex:FA23)"
                               pattern="^(SP|SU|FA|)[0-9]{2}$">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtLecturer" class="col-md-2 col-form-label"><strong>Lecturer:</strong></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control"  id="txtLecturer"  name="txtLecturer" value="${param.txtLecturer}" placeholder="GVxxxx"
                               pattern="^GV[0-9]{4}$">
                    </div>
                               
                    <a class="btn btn-primary col-sm-2" href="ViewTimetableServlet?txtLecturer=${param.txtLecturer}&txtSemester=${param.txtSemester}">View Timetable</a>
                </div>
                <div class="form-group row">
                    <label for="txtSubjectCode" class="col-md-2 col-form-label"><strong>Subject code:</strong></label>
                    <div class="col-md-10">
                        <input class="form-control" type="text" id="txtSubjectCode" name="txtSubjectCode" value="" required="" placeholder="(ex:SWP391)"
                               pattern="^[A-Z]{3}[0-9]{3}$"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtStartTime" class="col-md-2 col-form-label"><strong>Start time:</strong></label>
                    <div class="col-md-10">
                        <input type="datetime-local" class="form-control" id="txtStartTime" name="txtStartTime" value="" required="">
                    </div>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.currentDateError}">
                        <h6> ${requestScope.REQUEST_ERROR.currentDateError}</h6>
                    </c:if>
                </div>
                <div class="form-group row">
                    <label for="txtEndTime" class="col-md-2 col-form-label"><strong>End time:</strong></label>
                    <div class="col-md-10">
                        <input type="datetime-local" class="form-control" id="txtEndTime" name="txtEndTime" value="" required="">
                    </div>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.endTimeError}">
                        <h6> ${requestScope.REQUEST_ERROR.endTimeError}</h6>
                    </c:if>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.durationError}">
                        <h6> ${requestScope.REQUEST_ERROR.durationError}</h6>
                    </c:if>
                </div>
                <div class="form-group row">
                    <label for="txtDescription" class="col-md-2 col-form-label"><strong>Description:</strong></label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="txtDescription" name="txtDescription" value="" required="">
                    </div>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateRequestError}">
                        <h6> ${requestScope.REQUEST_ERROR.duplicateRequestError}</h6>
                    </c:if>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateFreeSlotError}">
                        <h6> ${requestScope.REQUEST_ERROR.duplicateFreeSlotError}</h6>
                    </c:if>
                    <c:if test="${not empty requestScope.REQUEST_ERROR.duplicateTimetableError}">
                        <h6> ${requestScope.REQUEST_ERROR.duplicateTimetableError}</h6>
                    </c:if>
                </div>
                <div class="form-group row">
                    <div class="col-md-10 offset-md-2">
                        <div class="btn btn-success btn-lg rounded-pill" onclick="submitFormSendRequest()">Send Request</div>
                    </div>
                </div>
            </form>
        </div>       




        <div class="backbutton"  onclick="goBack()">
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
                    <div class="frame-container" onclick="submitFormViewLecturer()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="ViewAllLecturers" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <img
                                class="bookedslot-icon"
                                alt=""
                                src="./public/request/bookedslot.svg"
                                />
                        </div>
                        <div class="view-all-lecturers">View All Lecturers</div>
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
