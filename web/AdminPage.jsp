<%-- 
    Document   : AdminPage
    Created on : Oct 24, 2023, 1:50:25 AM
    Author     : Minh Khang
--%>

<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <title>Dashboard</title>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <img
                class="fptu-eng-1-icon"
                alt=""
                src="public/BookingView/2021fptueng-1@2x.png"
                />

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
        <div class="container mt-4">
            <h1 class="text-center">Dashboard</h1>
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <form action="MainController" method="POST">
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Sinh viên ĐẶT nhiều SLOT nhất</h5>
                                    <input type="text" class="form-control" name="txtsemester" placeholder="E.g: FU23">
                                </div>
                                
                                <button type="submit" name="action" value="FindBMS" class="btn btn-primary float-right mt-2">Submit</button>
                                <p class="text-danger text-center mt-2">${requestScope.MSGBMS}</p>
                                <p class="mt-2">Số lượt đặt: <b style="color: red">${requestScope.UserMaxSlot.number}</b>  Mã số sinh viên: <b style="color: red">${requestScope.UserMaxSlot.userID}</b> </p>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <form action="MainController" method="POST">
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Sinh viên GỬI nhiều REQUEST nhất</h5>
                                    <input type="text" class="form-control" name="txtsemester" placeholder="E.g: FU23">
                                </div>
                                
                                <button type="submit" name="action" value="FindSMR" class="btn btn-primary float-right mt-2">Submit</button>
                                <p class="text-danger text-center mt-2">${requestScope.MSGSMR}</p>
                                <p class="mt-2">Số lượt đặt: <b style="color: red">${requestScope.UserMaxRequest.number}</b>  Mã số sinh viên: <b style="color: red">${requestScope.UserMaxRequest.userID}</b> </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <form action="MainController" method="POST">
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Giảng viên TẠO nhiều SLOT nhất</h5>
                                    <input type="text" class="form-control" name="txtsemester" placeholder="E.g: FU23">
                                </div>
                                <button type="submit" name="action" value="FindCMS" class="btn btn-primary float-right mt-2">Submit</button>
                            </form>
                                <p class="text-danger text-center mt-2">${requestScope.MSGCMS}</p>
                                <p class="mt-2">Số lượt đặt: <b style="color: red"></b>  Mã số sinh viên: <b style="color: red"></b> </p>
                        
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <form action="MainController" method="POST">
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Giảng viên NHẬN nhiều REQUEST nhất</h5>
                                    <input type="text" class="form-control" name="txtsemester" placeholder="E.g: FU23">
                                </div>
                                <button type="submit" name="action" value="FindRMR" class="btn btn-primary float-right mt-2">Submit</button>
                            </form>
                                <p class="text-danger text-center mt-2">${requestScope.MSGRMR}</p>
                                <p class="mt-2">Số lượt đặt: <b style="color: red"></b>  Mã số sinh viên: <b style="color: red"></b> </p>
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>-->
<script>
    function submitFormHomePage() {
        var form = document.querySelector('.returnHome form');
        form.submit();
    }
    function submitFormViewUsers() {
        var form = document.querySelector('.ViewUsers form');
        form.submit();
    }
    function submitFormLogout() {
        var form = document.querySelector('.logout form');
        form.submit();
    }
</script>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <title>Dashboard</title>
    </head>
    <body>
        <div class="fptu-eng-1-parent">
            <div class="returnHome" style="cursor: pointer;" onclick="submitFormHomePage()"> 
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="returnHomePageAdmin" />
                </form>
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />
            </div>

            <div class="frame-parent">
                <div class="frame-group">
                    <div class="frame-div ViewUsers" onclick="submitFormViewUsers()">
                        <form action="MainController" method="POST" style="display: none;">
                            <input type="hidden" name="action" value="ViewUsers" />
                        </form>
                        <div class="bookedslot-wrapper">
                            <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                            <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                        </div>
                        <div class="view-booking" >Search Users</div>
                    </div>
                    <div class="frame-div request" onclick="submitFormRequest()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="Request" />
                        </form>
                        Import Schedule
                        
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

        <div class="container mt-4">
            <h1 class="text-center">Dashboard</h1>
            <form action="MainController" method="POST">
                <div class="d-flex justify-content-between mt-2">
                    <input type="hidden" value="Find" name="action"/>
                    <input type="text" name="txtsemester" class="form-control mx-auto" placeholder="E.g FA23">
                    <button type="submit" value="Find" class="btn btn-primary float-right">Find</button>
                </div>
            </form>
            <p class="text-danger text-center mt-2">${requestScope.MSG}</p>
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên <span style="color: red" >ĐẶT NHIỀU SLOT NHẤT</span></h5>                              
                            </div>                            
                            <p class="mt-2">Số lượt đặt: <b style="color: red">${requestScope.UserMaxSlot.number}</b></p>
                            <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxSlot.userID}</b></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên GỬI <span style="color: red" >NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.UserMaxRequest.number}</b></p>
                            <p class="mt-2">MSSV: <b style="color: red">${requestScope.UserMaxRequest.userID}</b></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên <span style="color: red" >TẠO NHIỀU SLOT NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt tạo slot: <b style="color: red">${requestScope.LecturerMaxSlot.number}</b></p>
                            <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxSlot.userID}</b></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên <span style="color: red" >NHẬN ĐƯỢC NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: <b style="color: red">${requestScope.LecturerMaxRequest.number}</b></p>
                            <p class="mt-2">MSGV: <b style="color: red">${requestScope.LecturerMaxRequest.userID}</b></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
