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
import sample.bookings.BookingDAO;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;
import sample.requests.RequestError;
import sample.users.UserDTO;
import services.Service;

public class CreateRequestServlet extends HttpServlet {

    private static final String ERROR = "StudentHome_1.jsp";//can change by Servlet with the info of StudentHome_1
    private static final String SUCCESS = "StudentHome_1.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO student = (UserDTO) session.getAttribute("loginedUser");
            String studentID = student.getUserID();
            String txtPassword = request.getParameter("txtPassword");
            String password = request.getParameter("password");
            
            String freeSlotID = request.getParameter("txtFSlotID");
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String description = request.getParameter("txtDescription");
            
            
            System.out.println("");
            RequestDAO requestDAO = new RequestDAO();
            RequestError requestError = new RequestError();
            boolean checkValidation = true;
            BookingDAO bookingDAO = new BookingDAO();
            
            //check password
            if (!password.isEmpty()) {
                if (!txtPassword.equals(password)) {
                    checkValidation = false;
                    requestError.setCheckPassword("Wrong password!!!");
                }
            }
            
            //tranfer String to Date
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date starts = format.parse(startTime);
            Date ends = format.parse(endTime);
            
            //*****check duplicateBookedFSlot
            boolean checkStartDuplicateBookedFS = bookingDAO.checkTimeDuplicateInBookedFreeSlot(studentID, starts);
            boolean checkEndDuplicateBookedFS = bookingDAO.checkTimeDuplicateInBookedFreeSlot(studentID, ends);
            
            if (checkStartDuplicateBookedFS == false || checkEndDuplicateBookedFS == false) {
                checkValidation = false;
                requestError.setDuplicateBookedSlot("This slot was duplicated with another booked slot!!!");
            }
            
            RequestDTO requestDTO = new RequestDTO(2, subjectCode, freeSlotID, description, studentID, "", "");
            request.setAttribute("REQUEST_ERROR", requestError);
            if (checkValidation) {
                boolean checkCreated = requestDAO.createARequest(requestDTO);
                if (checkCreated) {
                    url = SUCCESS;
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
