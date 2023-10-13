package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String LOGIN_BY_GOOGLE = "login";
    private static final String LOGIN_BY_GOOGLE_ACTION = "LoginServlet";

    private static final String LOGIN_BY_FEID = "loginFeID";
    private static final String LOGIN_BY_FEID_ACTION = "LoginFeID.jsp";
    private static final String LOGIN_BY_FEID_SERVLET = "LoginByFeID";
    private static final String LOGIN_BY_FEID_ACTION_CHECK = "loginFeIDAction";

    private static final String STUDENT_PAGE = "StudentPage";
    private static final String STUDENT_PAGE_ACTION = "StudentHome.jsp";

    private static final String LECTURER_PAGE = "LecturerPage";
    private static final String LECTURER_PAGE_ACTION = "LecturerPage.jsp";

    private static final String ADMIN_PAGE = "AdminPage.jsp";
    private static final String ADMIN_PAGE_ACTION = "AdminPage.jsp";

    private static final String REQUEST_PAGE = "request.jsp";
    private static final String REQUEST = "Request";

    private static final String CREATE_REQUEST = "Create request";
    private static final String REQUEST_ACTION = "CreateRequestServlet";

    private static final String VIEWBOOKING = "ViewBooking";
    private static final String VIEW_BOOKING_CONTROLLER = "BookingController";

    private static final String CANCEL = "cancel";
    private static final String CANCEL_CONTROLLER = "CancelController";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_ACTION = "LoginFeID.jsp";

    private static final String CREATED_PAGE = "CreatedView.jsp";


    private static final String BACK = "back";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_BY_FEID_ACTION;
        try {
            String action = request.getParameter("action");
            if (action == null || action.isEmpty()) {
                url = LOGIN_BY_FEID_ACTION;
            } else if (action.equals(LOGIN_BY_GOOGLE)) {
                url = LOGIN_BY_GOOGLE_ACTION;
            } else if (action.equals(LOGIN_BY_FEID)) {
                url = LOGIN_BY_FEID_ACTION;
            } else if (action.equals(LOGIN_BY_FEID_ACTION_CHECK)) {
                url = LOGIN_BY_FEID_SERVLET;
            } else if (action.equals(STUDENT_PAGE)) {
                url = STUDENT_PAGE_ACTION;
            } else if (action.equals(LECTURER_PAGE)) {
                url = LECTURER_PAGE_ACTION;
            } else if (action.equals(ADMIN_PAGE)) {
                url = ADMIN_PAGE_ACTION;
            } else if (CREATE_REQUEST.equals(action)) {
                url = REQUEST_ACTION;
            } else if (VIEWBOOKING.equals(action)) {
                url = VIEW_BOOKING_CONTROLLER;
            } else if (REQUEST.equals(action)) {
                url = REQUEST_PAGE;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_ACTION;
            } else if (CANCEL.equals(action)) {
                url = CANCEL_CONTROLLER;
            } else if (BACK.equals(action)) {
                url = STUDENT_PAGE_ACTION;
            } else if (LOGOUT.equals(action)) {
                url = LOGIN_BY_FEID_ACTION;
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
