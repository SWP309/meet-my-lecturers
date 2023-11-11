package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.freeslots.FreeSlotError;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.requests.RequestDAO;
import sample.users.UserDTO;

public class AcceptRequestServlet extends HttpServlet {

    private final String SUCCESS = "ViewRequestServlet";
    private final String ERROR = "ViewRequestServlet";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean checkCreateFS = true;
            HttpSession session = request.getSession();
            UserDTO lecturer = (UserDTO) session.getAttribute("loginedUser");
            String lecturerID = lecturer.getUserID();
            String requestID = request.getParameter("txtRequestID");
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
//            //tranfer String to Date
//            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
//            Date starts = format.parse(startTime);
//            Date ends = format.parse(endTime);
//            //get current date
//            Date currentTime = new Date();
//            // Calculate current time plus 2 hours
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(currentTime);
//            calendar.add(Calendar.HOUR, 2);
//            Date timeInFuture = calendar.getTime();
//            //compare input time to current time
//            FreeSlotError freeSlotError = new FreeSlotError();
//            if (ends.before(timeInFuture)) {
//                checkCreateFS = false;
//                freeSlotError.setPastTimeError("- The start and end times must be in the future"
//                        + " and at least 2 hours greater than the current time!!!");
//            }

            String studentID = request.getParameter("txtStudentID");
            String semesterID = request.getParameter("txtSemesterID");
            String meetLink = request.getParameter("txtLinkMeet");
            RequestDAO requestDAO = new RequestDAO();

            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            FreeSlotError freeSlotError = new FreeSlotError();
            boolean flag = true;
            //****Check input link meet
            if (meetLink == null || meetLink.isEmpty()) {
                flag = false;
                freeSlotError.setMeetLinkError("- Must input link meet before accept.");
            }

            //****Check input time with current time
            //tranfer String to Date
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date starts = format.parse(startTime);
            Date ends = format.parse(endTime);
            //get current date
            Date currentTime = new Date();
            // Calculate current time plus 10 minutes
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentTime);
            calendar.add(Calendar.MINUTE, 10);
            Date timeInFuture = calendar.getTime();
            //compare input time to current time
            if (starts.before(timeInFuture) || ends.before(timeInFuture)) {
                flag = false;
                freeSlotError.setPastTimeError("- The start and end times must be in the future"
                        + " and at least 10 minutes greater than the current time!!!");
            }
            //****check end time greater than start time
            if (ends.before(starts) || ends.equals(starts)) {
                flag = false;
                freeSlotError.setEndTimeError("- The end times must be greater than start times!!!");
            }
            //****check duration from start time to end time
            // Calculate duration between startTime and endTime
            long timeDifference = ends.getTime() - starts.getTime();
            int minutesDifference = (int) (timeDifference / (1000 * 60));
            if (minutesDifference > 90 || minutesDifference < 15) {
                flag = false;
                freeSlotError.setDurationError("- Duration of a slot must be from 15 to 90 minutes!!!");
            }
            //****check not allowed create slot <= 5AM or >= 11PM
            calendar.setTime(starts);
            calendar.setTime(ends);
            int startHour = calendar.get(Calendar.HOUR_OF_DAY);
            int endHour = calendar.get(Calendar.HOUR_OF_DAY);
            if (startHour <= 5 || startHour >= 23 || endHour <= 5 || endHour >= 23) {
                flag = false;
                freeSlotError.setDurationError("- Not allowed create slot <= 5AM or >= 11PM!!!");
            }
            //****check duplicate time with created freeslot
            boolean checkStartTimeDuplicateFS = freeSlotsDAO.checkTimeDuplicateInFreeSlot(lecturerID, starts);
            boolean checkEndTimeDuplicateFS = freeSlotsDAO.checkTimeDuplicateInFreeSlot(lecturerID, ends);
            if (checkStartTimeDuplicateFS == false || checkEndTimeDuplicateFS == false) {
                flag = false;
                freeSlotError.setDuplicateTimeError("- The time you entered overlaps with time of created FREESLOT!!! ");
            }

            String password = request.getParameter("txtPassword").trim();
            if (password.isEmpty()) {
                password = null; // Chuyển chuỗi trống thành giá trị null
            }

            int capacity = Integer.parseInt(request.getParameter("txtCapacity"));
            if (capacity < 2 || capacity > 100) {
                flag = false;
                freeSlotError.setCapacityError("The number of student can join this slot must be between 2-100");
            }
            FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(subjectCode, startTime, endTime, null, 1, meetLink, 1, lecturerID, 1, semesterID, "");
            //update status -> accept
            boolean checkAccept = requestDAO.acceptARequest(requestID);
            //create FSlot
            checkCreateFS = freeSlotsDAO.createFreeSlot(freeSlotsDTO);

            BookingDTO bookingDTO = new BookingDTO();
            bookingDTO.setStudentID(studentID);
            bookingDTO.setFreeSlotID(freeSlotsDAO.searchFSAccept(startTime, lecturerID));
            BookingDAO bookingDAO = new BookingDAO();
            boolean checkBooking = bookingDAO.BookFSlot(bookingDTO);
            if (checkAccept && checkCreateFS && checkBooking) {
                url = SUCCESS;
            }
        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at AcceptRequestServlet: " + ex);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
