
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {
    private static final String LOGIN_PAGE = "login.html";
    
    private static final String REQUEST_PAGE = "request.jsp";
    private static final String REQUEST = "Request";
    private static final String BACK_TO_REQUEST = "BackToRequest";
    
    private static final String CREATE_REQUEST = "Create request";
    private static final String REQUEST_ACTION = "CreateRequestServlet";

    private static final String LOGIN_STUDENT_PAGE = "StudentHome.html";
    
    private static final String VIEWBOOKING = "ViewBooking";
    private static final String VIEW_BOOKING_CONTROLLER = "BookingController";
    
    private static final String VIEWTIMETABLE = "View Timetable";
    private static final String VIEW_TIMETABLE_CONTROLLER = "ViewTimetableServlet";
    
    private static final String VIEW_LECTURER = "ViewAllLecturers";
    private static final String VIEW_LECTURER_CONTROLLER = "ViewLecturerServlet";
    
    private static final String SEARCH_USERS = "SearchUsers";
    private static final String SEARCH_USERS_CONTROLLER = "SearchUserServlet";
    
    private static final String UPDATE_USERS = "UpdateUsers";
    private static final String UPDATE_USERS_CONTROLLER = "UpdateUserServlet";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "ViewUsers.jsp";
        try {
            String action = request.getParameter("action");
            if(action == null){
                url = "ViewUsers.jsp";
            } else if (REQUEST.equals(action)) {
                url = REQUEST_PAGE;
            } else if (CREATE_REQUEST.equals(action)) {
                url = REQUEST_ACTION;
            } else if (VIEWBOOKING.equals(action)) {
                url = VIEW_BOOKING_CONTROLLER;
            } else if (VIEWTIMETABLE.equals(action)) {
                url = VIEW_TIMETABLE_CONTROLLER;
            } else if (BACK_TO_REQUEST.equals(action)) {
                url = REQUEST_ACTION;
            } else if (VIEW_LECTURER.equals(action)) {
                url = VIEW_LECTURER_CONTROLLER;
            } else if (SEARCH_USERS.equals(action)) {
                url = SEARCH_USERS_CONTROLLER;
            } else if (UPDATE_USERS.equals(action)) {
                url = UPDATE_USERS_CONTROLLER;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
