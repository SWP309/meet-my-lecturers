<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="sample.bookings.BookingDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />

        <link rel="stylesheet" href="./BookingView.css" />
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <script>
            function confirmCancel(bookingID) {
                if (confirm('Are you sure to cancel this booking')) {
                    // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
                    window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
                }
            }
        </script>
    </head>
    <body>
        <div class="student-viewbookedslot">
            <div class="fptu-eng-1-parent">
                <img
                    class="fptu-eng-1-icon"
                    alt=""
                    src="public/BookingView/2021fptueng-1@2x.png"
                    />

                <div class="frame-parent">
                    <div class="frame-group">
                        <div class="frame-div">
                            <div class="bookedslot-wrapper">
                                <div class="div">+</div>
                            </div>
                            <div class="div">Request</div>
                        </div>
                        <div class="frame-parent1">
                            <div class="logout-wrapper">
                                <img class="logout-icon" alt="" src="public/BookingView/logout.svg" />
                            </div>
                            <div class="div">
                                <p class="logout1">Logout</p>
                            </div>
                        </div>
                    </div>
                    <img class="frame-item" alt="" src="public/BookingView/group-33.svg" />
                </div>
            </div>


            <div class="boxoftable">
                <c:if test="${requestScope.LIST_BOOKING !=null}">
                    <c:if test="${not empty requestScope.LIST_BOOKING}">
                        <table class="table table-hover table-primary table-rounded">
                            <thead>
                                <tr class="table-danger">
                                    <th>No</th>
                                    <th>Subject Code</th>
                                    <th>Lecturer's Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Cancel</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="MainController" method="POST">
                                <c:forEach var="bookings" varStatus="counter" items="${requestScope.LIST_BOOKING}">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            <span>${bookings.subjectCode}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.lectureName}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.startTime}</span>
                                        </td>
                                        <td>
                                            <span>${bookings.endTime}</span>
                                        </td>
                                        <td>
                                            <input type="hidden" name="bookingID" value="${bookings.bookingID}">
                                            <button type="submit" name="action" value="cancel"class="btn btn-danger">Cancel</button>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>

                            </tbody>
                        </table>

                    </c:if>
                </c:if>
            </div>
            <div class="backbutton">
                <div class="back">Back</div>
                <img class="back-icon" alt="" src="public/BookingView/back.svg" />
            </div>
        </div>
        <h3>
            ${requestScope.ERROR}
        </h3> 
    </body>
</html>
