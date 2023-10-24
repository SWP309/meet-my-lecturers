<%-- 
    Document   : create-freeSlot
    Created on : Oct 12, 2023, 12:14:21 AM
    Author     : W10(hiep-tm)
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Free Slot</title>
        <!-- Thêm liên kết đến Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Include Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <!-- Thêm liên kết đến Bootstrap JS và jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+J9pAEz6/LnYV5TOqDGIbpbzFq8qz5S7fF46kSEBzav6U7xj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-xV6VaRqI1z7MOJwz5Mz6f3GC6A5wA5CKh5uFfxn5g5crf7Sc6Pe4OdU8paHdFuI" crossorigin="anonymous"></script>
        <style>
            .card-body {
                display: flex;
                flex-direction: column;
                justify-content: space-around;
            }

            .d-flex > input {
                width: 60%;
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
            @media (min-width: 768px){
                .col-md-6 {
                    -ms-flex: 0 0 50%;
                    flex: 0 0 50%;
                    max-width: 39%;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.loginedUser != null && sessionScope.loginedUser.roleID == '2'}">
            <div class="container mt-5">
                <div class="d-flex justify-content-center">
                    <div class="card" style="border-radius: 5%; width: 800px; height: 500px;">

                        <div class="card-body">
                            <form action="MainController" method="POST">
                                <div class="d-flex justify-content-between"><strong>Subject code:</strong> <input type="text" class="form-control" name="txtSubjectCode" placeholder="ex:SWP391...etc" required="" pattern="^(PRJ|PRM|SEP|SWD|SWP|SWR|SWT)[0-9]{3}$"></div>
                                <div class="d-flex justify-content-between"><strong>Start time:</strong> <input type="datetime-local" class="form-control"  name="txtStartTime" required=""></div>
                                <div class="d-flex justify-content-between"><strong>End time:</strong> <input type="datetime-local" class="form-control" name="txtEndTime" required=""></div>
                                <div class="d-flex justify-content-between"><strong>Capacity:</strong> <input type="number" class="form-control" name="txtCapacity" placeholder="need more than 2 student" required=""></div>
                                <div class="d-flex justify-content-between"><strong>Password(optional):</strong> <input type="password" class="form-control" name="txtPassword"></div>
                                <div class="d-flex justify-content-between"><strong>Meet Link:</strong> <input type="text" class="form-control"  name="txtMeetLink" placeholder="ex:meet.google.com/...etc" required="" pattern="^https://meet.google.com/[a-z]{3}-[a-z]{4}-[a-z]{3}$"></div>
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <label for="role" class="col-form-label"><strong><b style="color: red">SET BY:</b></strong></label>
                                        <select class="form-control" name="txtOption">
                                            <option value="DA">Day after you created</option>
                                            <option value="DW">Day after week you created</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="role" class="col-form-label"><strong><b style="color: red">REPEATED TIMES:</b></strong></label>
                                        <input type="number" class="form-control" name="txtCount" required="">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center btn-book">
                                    <input type="hidden" value="createFreeSlotAction" name="action"/>
                                    <input type="submit" class="btn btn-primary" value="Create">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${sessionScope.loginedUser == null || sessionScope.loginedUser.roleID != '2' }">
            <c:redirect url="LoginFeID.jsp"> </c:redirect>
        </c:if>
    </body>
</html>
