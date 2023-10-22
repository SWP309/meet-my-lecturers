<%-- 
    Document   : create-freeSlot
    Created on : Oct 12, 2023, 12:14:21 AM
    Author     : W10(hiep-tm)
--%>

<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Free Slot</title>
        <%
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (us != null) {

            }else{
                response.sendRedirect("MainController");
            }
        %>
    </head>
    <body>
        <form action="MainController" method="POST">

            <input type="hidden" value="createFreeSlotAction" name="action"/>

            <table>
                <tr>
                    <td>Subject code:</td>
                    <td><input type="text" name="txtSubjectCode" placeholder="ex:SWP391...etc" required="" pattern="^(PRJ|PRM|SEP|SWD|SWP|SWR|SWT)\d{3}$"></td>
                </tr>
                <tr>
                    <td>Start time:</td>
                    <td><input type="datetime-local" name="txtStartTime" required=""></td>
                </tr>
                <tr>
                    <td>End time:</td>
                    <td><input type="datetime-local" name="txtEndTime" required=""></td>
                </tr>
                <tr>
                    <td>Capacity:</td>
                    <td><input type="number" name="txtCapacity" placeholder="need more than 2 student" required=""></td>
                </tr>
                <!--                <tr>
                                    <td>Repeated Times:</td>
                                    <td><input type="number" name="repeatedTimes"></td>
                                </tr>-->
                <tr>
                    <td>Password: (if necessary)</td>
                    <td><input type="password" name="txtPassword"></td>
                </tr>
                <tr>
                    <td>Meet link:</td>
                    <td><input type="text" name="txtMeetLink" placeholder="ex:meet.google.com/...etc" required=""></td>
                </tr>
                <tr>
                    <td>Count:</td>
                    <td><input type="number" name="txtCount"></td>
                </tr>
                <tr>
                    <td>Setting by:</td>
                    <td><input type="text" name="txtLecturerID" placeholder="ex:GVxxxx (your lecturer id)" required=""></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Create"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
