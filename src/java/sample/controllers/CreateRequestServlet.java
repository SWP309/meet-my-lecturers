package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;
import sample.requests.RequestError;
import sample.timetables.TimetableDAO;
import sample.users.UserDTO;
import services.Service;

public class CreateRequestServlet extends HttpServlet {

    private static final String ERROR = "request.jsp";
    private static final String SUCCESS = "ViewRequestStatus.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String lecturer = request.getParameter("txtLecturer");
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String description = request.getParameter("txtDescription");
            String semesterID = request.getParameter("txtSemester");
            RequestDAO requestDAO = new RequestDAO();
            RequestDTO requestDTO = new RequestDTO(semesterID, 2, subjectCode, startTime, endTime, description, us.getUserID(), lecturer, semesterID);
            RequestError requestError = new RequestError();
            boolean checkValidate = true;
            //****Check input time with current time
            //tranfer String to Date
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date starts = format.parse(startTime);
            Date ends = format.parse(endTime);
            //get current date
            Date currentTime = new Date();
            // Calculate current time plus 2 hours
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentTime);
            calendar.add(Calendar.HOUR, 2);
            Date timeInFuture = calendar.getTime();
            //compare input time to current time
            if (starts.before(timeInFuture) || ends.before(timeInFuture)) {
                checkValidate = false;
                requestError.setCurrentDateError("- The start and end times must be in the future"
                        + " and at least 2 hours greater than the current time!!!");
            }
            //****check end time greater than start time
            if (ends.before(starts) || ends.equals(starts)) {
                checkValidate = false;
                requestError.setEndTimeError("- The end times must be greater than start times!!!");
            }
            //****check duration from start time to end time
            // Calculate duration between startTime and endTime
            long timeDifference = ends.getTime() - starts.getTime();
            int minutesDifference = (int) (timeDifference / (1000 * 60));
            if (minutesDifference > 90 || minutesDifference < 15) {
                checkValidate = false;
                requestError.setDurationError("- Duration of a slot must be from 15 to 90 minutes!!!");
            }
            //****check duplicate with created request
            boolean checkStartDuplicate = requestDAO.checkTimeDuplicateInRequest(lecturer, starts);
            boolean checkEndDuplicate = requestDAO.checkTimeDuplicateInRequest(lecturer, ends);
            if (checkStartDuplicate == false || checkEndDuplicate == false) {
                checkValidate = false;
                requestError.setDuplicateRequestError("- The time you entered overlaps with "
                        + "the time of another REQUEST from that instructor!!!");
            }
            //****check duplicate with freeslot
            boolean checkStartDuplicateFS = requestDAO.checkTimeDuplicateInFreeSlot(lecturer, starts);
            boolean checkEndDuplicateFS = requestDAO.checkTimeDuplicateInFreeSlot(lecturer, ends);
            if (checkStartDuplicateFS == false || checkEndDuplicateFS == false) {
                checkValidate = false;
                requestError.setDuplicateFreeSlotError("- Please check again FREESLOT. "
                        + "The time you entered overlaps with the time of FREESLOT!!!");
            }
//            //*****check duplicate timetable*****
//            boolean checkStartTimetableDuplicate = requestDAO.checkTimetableDuplicate(starts, semesterID, lecturer);
//            boolean checkEndTimetableDuplicate = requestDAO.checkTimetableDuplicate(ends, semesterID, lecturer);
//            System.out.println(checkStartTimetableDuplicate);
//            if (checkStartTimetableDuplicate == false || checkEndTimetableDuplicate == false) {
//                checkValidate = false;
//                requestError.setDuplicateTimetableError("- The time you entered overlaps with lecturer's timetable. "
//                        + "Please click View Timetable to check again!!!");
//            }
//            System.out.println("Check Timetable valid: " + checkValidate);
            Service service = new Service();
            boolean checkTimetableDuplicate = service.duplicateSlot(requestDTO);
            if (checkTimetableDuplicate == false ) {
                checkValidate = false;
                requestError.setDuplicateTimetableError("- The time you entered overlaps with lecturer's timetable. "
                        + "Please click View Timetable to check again!!!");
            }
            request.setAttribute("REQUEST_ERROR", requestError);
            if (checkValidate) {
                boolean checkCreated = requestDAO.createARequest(requestDTO);
                if (checkCreated) {
                    url = SUCCESS;
                }else {
                    request.setAttribute("REQUEST_ERROR", "Can not send request because of Error of code !!!");
                }
                
            }
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            log("Error at CreateRequestServlet" + ex.toString());
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
