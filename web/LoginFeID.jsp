<%-- 
    Document   : loginFeID
    Created on : Oct 7, 2023, 9:52:35 PM
    Author     : Minh Khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./LoginFeID.css" />
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
        <div class="login-feid">
            <div class="formlogin1">
                <div class="surround">
                    <div class="surround-child"></div>
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/meet-my-lecturers/LoginGoogleHandler&response_type=code&client_id=79561996257-0ctstd2ursldvmmufi3vpq6k6rp4ftrg.apps.googleusercontent.com&approval_prompt=force">
                        <img class="google-icon1" alt="" src="./public/LoginHome/google1.svg" />
                    </a>
                    <div class="or">Or</div>
                    <div class="error-appear-here1">
                        <%
                            String msg = (String) request.getAttribute("Error");
                            if (msg != null) {
                        %>
                        <h2 id="123" style="color:red"><%=    msg%></h2>
                        <%
                            }
                        %></div>
                    <form action="MainController" method="post">
                        <input type="hidden" value="loginFeIDAction" name="action"/>
                        <div class="password">
                            <div class="password1">Password</div>
                            <div class="password-child">
                                <div class="password-child-input"><input name="txtpassword" type="password" style="background-color: #ebebeb; border: none; height: 4.19rem; border-radius: 40px; width: 22.38rem; font-size: 1.5rem; padding: 20px; box-sizing: border-box" ></div>
                            </div>           
                        </div>

                        <div class="account">
                            <label class="account1">Account</label>
                            <div class="account-child">
                                <div class="account-child-input"><input name="txtemail" type="text" style="background-color: #ebebeb; border: none; height: 4.19rem; border-radius: 40px; width: 22.38rem; font-size: 1.5rem; padding: 20px; box-sizing: border-box" ></div>
                            </div>

                        </div>
                        <div class="loginbutton">
                            <div class="loginbutton-child">
                                <div class="login1"><input id="button" type="submit" value="Login" style=" border: none; font-size: 1rem;   width: 6.25rem; height: 2.56rem; border-radius: 40px; cursor: pointer; border: 0.5px #f27125 solid"></div>
                            </div>
                        </div>
                    </form>
                    <div class="sign-in1">
                        <div class="method">
                            <div class="sign-in2">Sign in</div>
                        </div>
                        <div class="welcome1">Welcome !</div>
                    </div>
                </div>
            </div>
            <div class="logo1">
                <img
                    class="fptu-long-1-11"
                    alt=""
                    src="./public/LoginHome/2021fptulong-1-11@2x.png"
                    />

                <div class="appointment-scheduling-applica1">
                    Appointment Scheduling Application
                </div>
            </div>
            <div class="footer1">
                <div class="powered-by-fpt-container1">
                    © Powered by
                    <a class="fpt-university2" href="http://fpt.edu.vn/" target="_blank">
                        <span class="fpt-university3">FPT University</span>
                    </a>
                    |
                    <a
                        class="fpt-university2"
                        href="http://library.fpt.edu.vn/"
                        target="_blank"
                        >
                        <span class="fpt-university3">library</span>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>
