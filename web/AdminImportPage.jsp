<%-- 
    Document   : index
    Created on : Oct 28, 2023, 1:20:11 AM
    Author     : Minh Khang
--%>
<%@page import="sample.dashboard.UserMaxSlotDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
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
            function submitFormImport() {
                var form = document.querySelector('.import form');
                form.submit();
            }
        </script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="./AdminHome.css">
        <title>File Upload</title>
        <style>
            .custom-submit-button {
                background-color: #f27125; /* Màu xanh */
                color: #fff; /* Màu chữ trắng */
                /* Các thuộc tính CSS khác tùy ý */
            }
            .custom-submit-button:hover{
                background-color: #b05b18;
            }
        </style>
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
                    <div class="frame-div request import" onclick="submitFormImport()">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="importPage" />
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
                    <img class="frame-item" alt="" src="public/BookingView/group-33.svg" 
                         onclick="showUserInfo()" />
                    <div id="user-info" style="display: none; position: absolute;">
                        <p id="user-id"> </p>
                        <p id="user-name"></p>
                        <p id="user-email"></p>
                    </div>
                </div>


            </div>
        </div>
        <div class="container mt-5">
            <h1 class="text-center">Import form excel</h1>
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="padding-right: 100px; display: inline-block">
                    Import List Student
                </div>
                <%
                    String EXCSERVLET = (String) request.getAttribute("EXCSERVLET");

                    if (EXCSERVLET != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= EXCSERVLET%>
                </span>
                <%
                    }
                %>
                <div class="form-group input-group">
                    <div class="custom-file">
                        <input type="file" name="txtexcel" class="custom-file-input" id="imageUpload"  onchange="updateFileName('imageUpload')" required>
                        <label class="custom-file-label" for="imageUpload">Choose file</label>
                    </div>
                    <div class="input-group-append">
                        <input type="hidden" name="action" value="importST">
                        <button type="submit" value="importST" name="action" class="btn btn-primary custom-submit-button">Submit</button>
                    </div>
                </div>
            </form>
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <div style="padding-right: 100px; display: inline-block">
                    Import Timetables
                </div>
                <%
                    String TIMESERVLET = (String) request.getAttribute("TIMESERVLET");
                    String DUPLICATEDATA = (String) request.getAttribute("DUPLICATEDATA");

                    if (TIMESERVLET != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= TIMESERVLET%>
                </span>
                <%
                    }
                    if (DUPLICATEDATA != null) {
                %>
                <span style="color: red; font-size: 1rem;">
                    <%= DUPLICATEDATA%>
                </span>
                <%
                    }
                %>
                <div class="form-group input-group">
                    <div class="custom-file">
                        <input type="hidden" value="importTB" name="action">
                        <input type="file" name="txtexcel" class="custom-file-input" id="DSSV"  onchange="updateFileName('DSSV')" required>
                        <label class="custom-file-label">Choose file</label>
                    </div>                    
                    <input type="text" class="form-control" name="lecID" placeholder="E.g: GV0001" required>
                    <input type="text" class="form-control" name="semesID" placeholder="E.g: FA23" required>
                    <div class="input-group-append">
                        <button type="submit" value="importTB" name="action" class="btn btn-primary custom-submit-button">Submit</button>
                    </div>
                </div>
            </form>
        </div>
        <script>
            function updateFileName(inputId) {
                const input = document.getElementById(inputId);
                const fileName = input.value.split('\\').pop();
                input.nextElementSibling.innerHTML = fileName;
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>