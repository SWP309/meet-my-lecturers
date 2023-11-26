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
            boolean checkMeetlink = true;
            HttpSession session = request.getSession();
            UserDTO lecturer = (UserDTO) session.getAttribute("loginedUser");
            String requestID = request.getParameter("txtRequestID");
            String freeSlotID = request.getParameter("txtFreeSlotID");
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            String subjectCode = request.getParameter("txtSubjectCode");
            String studentID = request.getParameter("txtStudentID");
            RequestDAO requestDAO = new RequestDAO();
            boolean checkAccept = requestDAO.acceptARequest(requestID,freeSlotID);
            freeSlotsDAO.updateSubject(subjectCode, freeSlotID);
//                requestDAO.updateStatusDuplicateAcceptedRequest(studentID);
            BookingDTO bookingDTO = new BookingDTO();
            bookingDTO.setStudentID(studentID);
            bookingDTO.setFreeSlotID(freeSlotID);
            BookingDAO bookingDAO = new BookingDAO();
            boolean checkBooking = bookingDAO.BookFSlot(bookingDTO);
            if (checkAccept && checkBooking) {
                url = SUCCESS;
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                request.setAttribute("VIEW_REQUEST_MESSAGE", "Can not Accept this request !!! ");
                request.getRequestDispatcher(url).forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at ViewAllRequestStatus: " + ex.toString());
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
