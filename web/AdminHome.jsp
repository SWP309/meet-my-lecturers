<%-- 
    Document   : AdminHome
    Created on : Oct 22, 2023, 10:36:08 PM
    Author     : Minh Khang
--%>

<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css" />
       
        <title>Dashboard</title>
    </head>
    <body>
        <div class="AdminHome">
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
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Sinh viên đặt nhiều slot nhất</h5>
                                    <select class="form-control">
</select>
</div>
<p class="mt-2">Số lượt đặt: 10</p>
</div>
</div>
</div>

<div class="col-md-6">
<div class="card">
<div class="card-body">
<div class="d-flex justify-content-between">
<h5 class="card-title">Sinh viên gửi nhiều request nhất</h5>
<select class="form-control">
<option value="Option 1">Option 1</option>
<option value="Option 2">Option 2</option>
<option value="Option 3">Option 3</option>
</select>
</div>
<p class="mt-2">Số lượt request: 15</p>
</div>
</div>
</div>
</div>

<div class="row mt-4">
<div class="col-md-6">
<div class="card">
<div class="card-body">
<div class="d-flex justify-content-between">
<h5 class="card-title">Giảng viên tạo nhiều slot nhất</h5>
<select class="form-control">
<option value="Option 1">Option 1</option>
<option value="Option 2">Option 2</option>
<option value="Option 3">Option 3</option>
</select>
</div>
<p class="mt-2">Số lượt tạo slot: 20</p>
</div>
</div>
</div>

<div class="col-md-6">
<div class="card">
<div class="card-body">
<div class="d-flex justify-content-between">
<h5 class="card-title">Giảng viên nhận được nhiều request nhất</h5>
<select class="form-control">
<option value="Option 1">Option 1</option>
<option value="Option 2">Option 2</option>
<option value="Option 3">Option 3</option>
</select>
</div>
<p class="mt-2">Số lượt request: 18</p>
</div>
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
                                <input type="hidden" value="Find" name="action"/>
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">Sinh viên đặt nhiều slot nhất</h5>
                                    <input type="text" class="form-control" name="txtsemester" placeholder="E.g: FU23">
                                </div>
                                
                                <button type="submit" value="Find" class="btn btn-primary float-right mt-2"></button>
                                <p class="mt-2">Số lượt đặt:   Mã số sinh viên: </p>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên gửi nhiều request nhất</h5>
                                <select class="form-control">
                                    <option value="Option 1">Option 1</option>
                                    <option value="Option 2">Option 2</option>
                                    <option value="Option 3">Option 3</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary float-right mt-2">Submit</button>
                            <p class="mt-2">Số lượt request: 15</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên tạo nhiều slot nhất</h5>
                                <select class="form-control">
                                    <option value="Option 1">Option 1</option>
                                    <option value="Option 2">Option 2</option>
                                    <option value="Option 3">Option 3</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary float-right mt-2">Submit</button>
                            <p class="mt-2">Số lượt tạo slot: 20</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên nhận được nhiều request nhất</h5>
                                <select class="form-control">
                                    <option value="Option 1">Option 1</option>
                                    <option value="Option 2">Option 2</option>
                                    <option value="Option 3">Option 3</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary float-right mt-2">Submit</button>
                            <p class="mt-2">Số lượt request: 18</p>
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
            <form action="MainController" method="POST">
            <div class="d-flex justify-content-between mt-2">
                <input type="hidden" value="FindBMS" name="action"/>
                <input type="text" class="form-control mx-auto" placeholder="E.g FA23">
                <button type="submit" value="FindBMS" class="btn btn-primary float-right">Find</button>
            </div>
            </form>
            <p class="text-danger text-center mt-2">${requestScope.MSGBMS}</p>
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên <span style="color: red" >ĐẶT NHIỀU SLOT NHẤT</span></h5>                              
                            </div>                            
                            <p class="mt-2">Số lượt đặt: ${requestScope.UserMaxBook.number}</p>
                            <p class="mt-2">MSSV: ${requestScope.UserMaxBook.userID}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Sinh viên GỬI <span style="color: red" >NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: 15</p>
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

                            <p class="mt-2">Số lượt tạo slot: 20</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Giảng viên <span style="color: red" >NHẬN ĐƯỢC NHIỀU REQUEST NHẤT</span></h5>

                            </div>

                            <p class="mt-2">Số lượt request: 18</p>
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