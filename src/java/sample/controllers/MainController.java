package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String HOME_ACTION_LECTURER = "returnHomePageLecturer";
    private static final String HOME_PAGE_LECTURER = "CreatedSlotController";
    private static final String HOME_ACTION_STUDENT = "returnHomePageStudent";
    private static final String HOME_PAGE_STUDENT = "StudentHome.jsp";
    private static final String HOME_ACTION_ADMIN = "returnHomePageAdmin";
    private static final String HOME_PAGE_ADMIN = "CreatedSlotController";

    private static final String LOGIN_BY_GOOGLE = "login";
    private static final String LOGIN_BY_GOOGLE_ACTION = "LoginServlet";

    private static final String LOGIN_BY_FEID = "loginFeID";
    private static final String LOGIN_BY_FEID_ACTION = "LoginFeID.jsp";
    private static final String LOGIN_BY_FEID_SERVLET = "LoginByFeID";
    private static final String LOGIN_BY_FEID_ACTION_CHECK = "loginFeIDAction";

    private static final String STUDENT_PAGE = "StudentPage";
    private static final String STUDENT_PAGE_ACTION = "StudentHome_1.jsp";

    private static final String LECTURER_PAGE = "LecturerPage";
    private static final String CREATE_FREE_SLOT_ACTION = "createFreeSlotAction";
    private static final String CREATE_FREE_SLOT_PAGE = "create-freeSlot.jsp";
    private static final String CREATE_FREE_SLOT = "CreateFS";
    private static final String CREATE_FREE_SLOT_SERVLET = "newfreeslot";

    private static final String HIDE_FREE_SLOT = "hideFS";
    private static final String HIDE_CREATED_CONTROLLER = "CancelSlotController";

    private static final String UNHIDE_FREE_SLOT = "UnhideFS";
    private static final String UNHIDE_CREATED_CONTROLLER = "UnhideFSlotController";

    private static final String DELETE_FREE_SLOT = "deleteFS";
    private static final String DELETE_CREATED_CONTROLLER = "DeleteFSlotController";

    private static final String VIEW_FREE_SLOT = "viewFS";
    private static final String VIEW_CREATED_CONTROLLER = "ViewStudentSlotController";

    private static final String UPDATE_FREE_SLOT = "updateFS";
    private static final String UPDATE_CREATED_CONTROLLER = "UpdateFSlotController";

    private static final String VIEW_REQUEST_LECTURER_ACTION = "ViewRequest";
    private static final String REQUEST_VIEW_CONTROLLER = "ViewRequestServlet";

    private static final String ADMIN_PAGE = "AdminPage";
    private static final String ADMIN_PAGE_ACTION = "AdminPage.jsp";
//    private static final String ADMIN_PAGE_CONTROLLER = "ViewSemesterServlet";
    private static final String ADMIN_PAGE_CONTROLLER = "DashBoardServlet";
//    private static final String ADMIN_PAGE_CONTROLLER_ACTION = "DashBoard";
    private static final String ADMIN_FIND_STUDENTMAXBOOKING = "Find";//booking most slot
    private static final String ADMIN_FIND_STUDENTMAXREQUEST = "FindSMR";//send most request
    private static final String ADMIN_FIND_LECTURERMAXBOOKING = "FindCMS";//create most slot
    private static final String ADMIN_FIND_LECTURERMAXREQUEST = "FindRMR";//recieve most request

    private static final String REQUEST_PAGE = "request.jsp";
    private static final String REQUEST = "Request";
    private static final String BACK_TO_REQUEST = "BackToRequest";

    private static final String CREATE_REQUEST = "CreateRequest";
    private static final String REQUEST_ACTION = "CreateRequestServlet";

    private static final String VIEWBOOKING = "ViewBooking";
    private static final String VIEW_BOOKING_CONTROLLER = "BookingController";

    private static final String VIEWTIMETABLE = "ViewTimetable";
    private static final String VIEW_TIMETABLE_CONTROLLER = "ViewTimetableServlet";

    private static final String VIEW_LECTURER = "ViewAllLecturers";
    private static final String VIEW_LECTURER_CONTROLLER = "ViewLecturerServlet";

    private static final String CANCEL = "cancel";
    private static final String CANCEL_CONTROLLER = "CancelController";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_ACTION = "LoginFeID.jsp";

    private static final String CREATED_VIEW_CONTROLLER = "CreatedSlotController";

    private static final String CREATED_PAGE_HIDE = "HideView";
    private static final String CREATED_CONTROLLER_VIEW_SUB = "CreatedSlotViewSubController";

    private static final String VIEW_USERS = "ViewUsers";
    private static final String VIEW_USERS_PAGE = "ViewUsers.jsp";
    private static final String SEARCH_USERS = "SearchUsers";
    private static final String SEARCH_USERS_CONTROLLER = "SearchUserServlet";

    private static final String UPDATE_USERS = "UpdateUsers";
    private static final String UPDATE_USERS_CONTROLLER = "UpdateUserServlet";

    private static final String DELETE_REQUEST = "DeleteRequest";
    private static final String DELETE_REQUEST_CONTROLLER = "DeleteRequestServlet";

    private static final String ACCEPT_REQUEST = "AcceptRequest";
    private static final String ACCEPT_REQUEST_CONTROLLER = "AcceptRequestServlet";
    
    private static final String SEARCH_FREE_SLOT_ACTION = "SearchFSlot";
    private static final String SEARCH_FREE_SLOT_SERVLET = "SearchFreeSlotServlet";

    private static final String BACK = "back";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_BY_FEID_ACTION;

        try {
            String action = request.getParameter("action");
            System.out.println(action);
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
                url = CREATED_VIEW_CONTROLLER;
            } else if (action.equals(ADMIN_PAGE)) {
                url = ADMIN_PAGE_ACTION;
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
            } else if (HIDE_FREE_SLOT.equals(action)) {
                url = HIDE_CREATED_CONTROLLER;
            } else if (DELETE_FREE_SLOT.equals(action)) {
                url = DELETE_CREATED_CONTROLLER;
            } else if (VIEW_FREE_SLOT.equals(action)) {
                url = VIEW_CREATED_CONTROLLER;
            } else if (UPDATE_FREE_SLOT.equals(action)) {
                url = UPDATE_CREATED_CONTROLLER;
            } else if (CREATED_PAGE_HIDE.equals(action)) {
                url = CREATED_CONTROLLER_VIEW_SUB;
            } else if (UNHIDE_FREE_SLOT.equals(action)) {
                url = UNHIDE_CREATED_CONTROLLER;
            } else if (CREATE_FREE_SLOT_ACTION.equals(action)) {
                url = CREATE_FREE_SLOT_SERVLET;
            } else if (CREATE_FREE_SLOT.equals(action)) {
                url = CREATE_FREE_SLOT_PAGE;
            } else if (VIEW_REQUEST_LECTURER_ACTION.equals(action)) {
                url = REQUEST_VIEW_CONTROLLER;
            } else if (HOME_ACTION_LECTURER.equals(action)) {
                url = HOME_PAGE_LECTURER;
            } else if (HOME_ACTION_STUDENT.equals(action)) {
                url = HOME_PAGE_STUDENT;
            } else if (action.equals(ADMIN_PAGE)) {
                url = CREATED_VIEW_CONTROLLER;
            } else if (action.equals(ADMIN_FIND_STUDENTMAXBOOKING)) {
                url = ADMIN_PAGE_CONTROLLER;
            } else if (action.equals(ADMIN_FIND_STUDENTMAXREQUEST)) {
                url = ADMIN_PAGE_CONTROLLER;
            } else if (action.equals(ADMIN_FIND_LECTURERMAXBOOKING)) {
                url = ADMIN_PAGE_CONTROLLER;
            } else if (action.equals(ADMIN_FIND_LECTURERMAXREQUEST)) {
                url = ADMIN_PAGE_CONTROLLER;
            } else if (action.equals(ADMIN_PAGE)) {
                url = ADMIN_PAGE_ACTION;
            } else if (ACCEPT_REQUEST.equals(action)) {
                url = ACCEPT_REQUEST_CONTROLLER;
            } else if (DELETE_REQUEST.equals(action)) {
                url = DELETE_REQUEST_CONTROLLER;
            } else if (SEARCH_FREE_SLOT_ACTION.equals(action)) {
                url = SEARCH_FREE_SLOT_SERVLET;
            } else if (VIEW_USERS.equals(action)) {
                url = VIEW_USERS_PAGE;
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
