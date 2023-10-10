<%-- 
    Document   : StudentHome
    Created on : Oct 10, 2023, 9:25:31 PM
    Author     : Minh Khang
--%>

<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./StudentHome.css" />
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
        <script>
            function submitForm() {
                var form = document.querySelector('.frame-container form');
                form.submit();
            }
            function submitFormRequest() {
                var form = document.querySelector('.frame-parent1 form');
                form.submit();
            }
            function submitFormLogout() {
                var form = document.querySelector('.frame-div form')
                form.submit();
            }
        </script>

    </head>
    <body>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {
            } else {
                response.sendRedirect("MainController");
            }
        %>
        <div class="student-home">
            <div class="fptu-eng-1-parent">
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="./public/StudentHome/2021fptueng-1@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-container" onclick="submitForm()">
                            <form action="MainController" method="POST" style="display: none;">
                                <input type="hidden" name="action" value="ViewBooking" />
                            </form>
                            <div class="bookedslot-wrapper">
                                <img class="bookedslot-icon" alt="" src="./public/StudentHome/bookedslot.svg" />
                                <a href="../../copycuabao/meet-my-lecturers-copy/web/StudentHome.html"></a>
                            </div>
                            <div class="view-booking" >View Booking</div>
                        </div>
                        <div class="frame-parent1" onclick="submitFormRequest()">
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="Request" />
                            </form>
                            <div class="bookedslot-wrapper">
                                <div class="request">+</div>
                            </div>
                            <div class="request">Request</div>
                        </div>
                        <div class="frame-div" onclick="submitFormLogout()">
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
                    <img class="frame-item" alt="" src="./public/StudentHome/user.png" />
                </div>
            </div>
            <div class="searchfunction">
                <img class="bysub-icon" alt="" src="./public/StudentHome/bysub.svg" />

                <img class="bysemester-icon" alt="" src="./public/StudentHome/bysemester.svg" />

                <div class="search">
                    <div class="search-child"></div>
                    <div class="search1">Search</div>
                </div>
                <img class="searchbylec-icon" alt="" src="./public/StudentHome/searchbylec.svg" />

                <div class="lecture-4">
                    <div class="lamnn15">LamNN15</div>
                    <div class="swe391">SWE391</div>
                    <div class="fall23">Fall23</div>
                </div>
            </div>
            <div class="rectangle-group">
                <div class="group-child"></div>
                <div class="lecture">
                    <div class="lecture-1">
                        <div class="lamnn151">LamNN15</div>
                        <div class="div1">1.</div>
                        <div class="swp391">SWP391</div>
                        <div class="fall231">Fall23</div>
                    </div>
                    <div class="lecture-2">
                        <div class="lamnn151">LamNN15</div>
                        <div class="div1">2.</div>
                        <div class="swp391">SWP391</div>
                        <div class="fall231">Fall23</div>
                    </div>
                    <div class="lecture-3">
                        <div class="lamnn151">LamNN15</div>
                        <div class="div1">3.</div>
                        <div class="swp391">SWP391</div>
                        <div class="fall231">Fall23</div>
                    </div>
                    <div class="lecture-41">
                        <div class="lamnn151">LamNN15</div>
                        <div class="div1">4.</div>
                        <div class="swp391">SWP391</div>
                        <div class="fall231">Fall23</div>
                    </div>
                    <div class="lecture-5">
                        <div class="lamnn151">LamNN15</div>
                        <div class="div1">5.</div>
                        <div class="swp391">SWP391</div>
                        <div class="fall231">Fall23</div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
