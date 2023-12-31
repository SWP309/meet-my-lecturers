<%-- 
    Document   : login
    Created on : Oct 10, 2023, 9:04:07 PM
    Author     : Minh Khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./index.css" />
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
        <div class="login">
            <div class="formlogin-parent">
                <div class="formlogin">
                    <div class="rectangle-parent">
                        <div class="frame-child"></div>
                        <div class="sign-in-parent">
                            <div class="sign-in">Sign in</div>
                            <div class="welcome">Welcome !</div>
                        </div>
                    </div>
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/meet-my-lecturers/LoginGoogleHandler&response_type=code
                       &client_id=79561996257-0ctstd2ursldvmmufi3vpq6k6rp4ftrg.apps.googleusercontent.com&approval_prompt=force">
                        <img class="google-icon" alt="" src="./public/LoginHome/Google_1.png" /></a>
                    <a href="MainController?action=loginFeID">
                        <div class="iconid">
                            <div class="iconid-child"></div>
                            <div class="feid">FeID</div>                
                            <img class="vector-icon" alt="" src="./public/LoginHome/vector.svg" />

                            <img class="vector-icon1" alt="" src="./public/LoginHome/vector1.svg" />
                        </div>
                    </a>
                </div>

                <div class="error-appear-here">
                    <%
                        String msg = (String) request.getAttribute("Error");
                        if (msg != null) {
                    %>
                    <h2 id="123" style="color:red"><%=    msg%></h2>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="logo">
                <img
                    class="fptu-long-1-1"
                    alt=""
                    src="./public/LoginHome/2021fptulong-1-1@2x.png"
                    />

                <div class="appointment-scheduling-applica">
                    Appointment Scheduling Application
                </div>
            </div>
            <div class="footer">
                <div class="powered-by-fpt-container">
                    © Powered by
                    <a class="fpt-university" href="http://fpt.edu.vn/" target="_blank">
                        <span class="fpt-university1">FPT University</span>
                    </a>
                    |
                    <a
                        class="fpt-university"
                        href="http://library.fpt.edu.vn/"
                        target="_blank"
                        >
                        <span class="fpt-university1">library</span>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>
