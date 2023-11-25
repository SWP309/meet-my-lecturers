package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String HOME_ACTION_LECTURER = "returnHomePageLecturer";
    private static final String HOME_PAGE_LECTURER = "LecturerHome";
    private static final String HOME_ACTION_STUDENT = "returnHomePageStudent";
    private static final String HOME_PAGE_STUDENT = "StudentHome_1.jsp";
    private static final String HOME_ACTION_ADMIN = "returnHomePageAdmin";
    private static final String HOME_PAGE_ADMIN = "AdminPage.jsp";
    private static final String BAN_USER_ACTION = "BanUser";
    private static final String BAN_USER_SERVLET = "BanUserServlet";
    private static final String UNBAN_USER_ACTION = "UnbanUser";
    private static final String UNBAN_USER_SERVLET = "UnBanUserServlet";

    private static final String LOGIN_BY_GOOGLE = "login";
    private static final String LOGIN_BY_GOOGLE_ACTION = "LoginServlet";

    private static final String LOGIN_BY_FEID = "loginFeID";
    private static final String LOGIN_BY_FEID_ACTION = "LoginFeID.jsp";
    private static final String LOGIN_BY_FEID_SERVLET = "LoginByFeID";
    private static final String LOGIN_BY_FEID_ACTION_CHECK = "loginFeIDAction";

    private static final String STUDENT_PAGE = "StudentPage";
    private static final String STUDENT_PAGE_ACTION_RETURN = "CheckStatusUser";
    private static final String STUDENT_PAGE_ACTION = "CheckStatusServlet";
    private static final String BOOKING_FREE_SLOT = "BookFreeSlot";
    private static final String BOOKING_FREE_SLOT_SERVLET = "BookFSlotServlet";

    private static final String LECTURER_PAGE = "LecturerPage";
    private static final String LECTURER_HOME = "LecturerHome";
    private static final String CREATE_FREE_SLOT_ACTION = "createFreeSlotAction";
    private static final String CREATE_FREE_SLOT_PAGE = "ViewOptionCreateFS";
    private static final String CREATE_FREE_SLOT = "CreateFS";
    private static final String CREATE_FREE_SLOT_SERVLET = "newfreeslot";
    private static final String VIEW_LECTURER_PROFILE = "viewLecturerProfile";
    private static final String VIEW_LECTURER_PROFILE_ACTION = "ViewLecturerProfile";

    private static final String ADD_MAJOR = "AddMajor";
    private static final String ADD_MAJOR_CONTROLLER = "AddMajorServlet";

    private static final String DELETE_MAJOR = "DeleteMajor";
    private static final String DELETE_MAJOR_CONTROLLER = "DeleteMajorServlet";

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

    private static final String ACCEPT_ALL_REQUEST = "acceptAllRequest";
    private static final String ACCEPT_ALL_REQUEST_CONTROLLER = "AcceptAllRequest";

    private static final String DECLINE_ALL_REQUEST = "declineAllRequest";
    private static final String DECLINE_ALL_REQUEST_CONTROLLER = "DeclineAllRequest";

    private static final String ADMIN_PAGE = "AdminPage";
    private static final String ADMIN_PAGE_ACTION = "AdminPage.jsp";
    private static final String ADMIN_PAGE_CONTROLLER = "DashBoardServlet";
    private static final String ADMIN_FIND_STUDENTMAXBOOKING = "Find";//booking most slot
    private static final String ADMIN_FIND_STUDENTMAXREQUEST = "FindSMR";//send most request
    private static final String ADMIN_FIND_LECTURERMAXBOOKING = "FindCMS";//create most slot
    private static final String ADMIN_FIND_LECTURERMAXREQUEST = "FindRMR";//recieve most request
    private static final String ADMIN_IMPORT_PAGE = "importPage";
    private static final String ADMIN_IMPORT_PAGE_ACTION = "AdminImportPage.jsp";
    private static final String ADMIN_IMPORTSTUDENT = "importST";
    private static final String ADMIN_IMPORTSTUDENT_ACTION = "ImportStudents";
    private static final String ADMIN_IMPORTTIMETABLES = "importTB";
    private static final String ADMIN_IMPORTTIMETABLES_ACTION = "ImportTimetables";
    private static final String ADMIN_IMPORT_SUBJECT = "importSJ";
    private static final String ADMIN_IMPORT_SUBJECT_ACTION = "ImportSubjects";
    private static final String ADMIN_ADD_DATA = "AdminAddData";
    private static final String ADMIM_ADD_DATA_PAGE = "AdminAddData.jsp";
    private static final String ADMIN_MANAGE_SLOTS = "AdminViewSlot";
    private static final String ADIMIN_MANAGE_SLOTS_PAGE = "AdminViewSlot.jsp";

    private static final String REQUEST_PAGE = "request.jsp";
    private static final String REQUEST = "Request";
    private static final String BACK_TO_REQUEST = "BackToRequest";

    private static final String REQUEST_STATUS = "ViewRequestStatus";
    private static final String REQUEST_STATUS_PAGE = "ViewRequestStatus.jsp";
    private static final String ALL_REQUEST_STATUS_CONTROLLER = "ViewAllRequestStatus";

    private static final String SEARCH_REQUEST_STATUS = "SearchRequestStatus";
    private static final String SEARCH_REQUEST_STATUS_ACTION = "SearchRequestStatusServlet";

    private static final String CREATE_REQUEST = "CreateRequest";
    private static final String REQUEST_ACTION = "CreateRequestServlet";

    private static final String SEARCH_REQUEST_FOR_LEC = "searchRequestForLec";
    private static final String SEARCH_REQUEST_FOR_LEC_ACTION = "SearchRequestForLec";

    private static final String VIEW_BOOKING = "ViewBooking";

    private static final String VIEW_BOOKING_CONTROLLER = "BookingController";
    private static final String VIEW_BOOKING_HISTORY = "attendanceSemes";
    private static final String VIEW_BOOKING_HISTORY_CHECK_SEMES_ACTION = "AttendanceSemesServlet";
    private static final String VIEW_BOOKING_HISTORY_PAGE = "CheckAttend.jsp";
    private static final String VIEW_BOOKING_HISTORY_CHECK_SEMES = "attendanceservlet";
    private static final String VIEW_BOOKING_HISTORY_PAGE_ACTION = "AttendanceServlet";
    private static final String VIEW_BOOKING_HISTORY_SERVLET = "attendServlet";
    private static final String VIEW_BOOKING_HISTORY_SERVLET_ACTION = "CheckAttend.jsp";

    private static final String VIEW_FREESLOT_HISTORY = "historyLec";
    private static final String VIEW_FREESLOT_HISTORY_CHECK_SEMES_ACTION = "AttendanceSemesLecServlet";
    private static final String VIEW_FREESLOT_HISTORY_CHECK_SEMES = "attendLec";
    private static final String VIEW_FREESLOT_HISTORY_PAGE = "CheckAttendLec.jsp";
    private static final String VIEW_FREESLOT_HISTORY_SERVLET = "attendLecServlet";
    private static final String VIEW_FREESLOT_HISTORY_PAGE_ACTION = "AttendanceLecServlet";
    private static final String VIEW_FREESLOT_HISTORY_PAGE_SERVLET = "present";
    private static final String VIEW_FREESLOT_HISTORY_SERVLET_ACTION = "CheckAttendLec.jsp";

    private static final String VIEWTIMETABLE = "ViewTimetable";
    private static final String VIEW_TIMETABLE_CONTROLLER = "ViewTimetableServlet";

    private static final String VIEW_LECTURER = "ViewAllLecturers";
    private static final String VIEW_LECTURER_CONTROLLER = "ViewLecturerServlet";

    private static final String CANCEL = "cancel";
    private static final String CANCEL_CONTROLLER = "CancelController";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_ACTION = "LoginFeID.jsp";

    private static final String CREATED_VIEW_FREE_SLOT_ACTION = "viewFSlotLecturer";
    private static final String CREATED_VIEW_CONTROLLER = "CreatedSlotController";

    private static final String COUNT_PAGE = "countPageAction";
    private static final String COUNT_PAGE_SERVLET = "CountPageServlet";

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

    private static final String CHECK_ATTENDANCE_ACTION_STUDENT = "AttendanceLink";
    private static final String CHECK_ATTENDANCE_SERVLET_STUDENT = "CheckAttendanceBookingView";

    private static final String CHECK_ATTENDANCE_ACTION_LECTURER = "AttendanceLinkLecturer";
    private static final String CHECK_ATTENDANCE_SERVLET_LECTURER = "CheckAttendanceCreateSlot";

    private static final String SEARCH_CREATE_SLOT_ACTION = "searchCSlot";
    private static final String SEARCH_CREATE_SLOT_SERVLET = "SearchCreateSlotServlet";

    private static final String SEARCH_FREE_SLOT_ACTION = "SearchFSlot";
    private static final String SEARCH_FREE_SLOT_SERVLET = "SearchFreeSlotServlet";

    private static final String SEARCH_BOOKED_SLOT_ACTION = "searchBSlot";
    private static final String SEARCH_BOOKED_SLOT_SERVLET = "SearchBookedServlet";

    private static final String SEND_EMAIL_ACTION = "sendEMailAction";
    private static final String SEND_EMAIL_SERVLET = "SendEMailServlet";

    private static final String CHANGE_PASS = "changePass";
    private static final String CHANGE_PASS_ACTION = "ChangePassword.jsp";
    private static final String CHANGE_PASS_PAGE_ACTION = "changePassServlet";
    private static final String CHANGE_PASS_PAGE_SERVLET = "ChangePasswordServlet";

    private static final String SEND_EMAIL_REMIND_ACTION = "SendEmailForRemindStudent";
    private static final String SEND_EMAIL_REMIND_SERVLET = "send-email.jsp";

    private static final String ADD_SUBJECT = "AddSub";
    private static final String REMOVE_SUBJECT = "RemoveSub";
    private static final String UPDATE_SUBJECT = "UpdateSub";
//    private static final String UPDATE_SUBJECT = "AddSub";
    private static final String ADD_SUBJECT_ACTION = "AddSubject";
    private static final String UPDATE_SUBJECT_ACTION = "UpdateSubject";
    private static final String MANAGE_SUBJECT_SERVLET = "ManageServlet";
    private static final String ADMIN_SUBJECT_PAGE = "AdminAddData.jsp";
    private static final String REMOVE_SUBJECT_ACTION = "RemoveSubject";
    private static final String SEARCH_SUBJECT = "searchsj";
    private static final String SEARCH_SUBJECT_ACTION = "SearchServlet";

    private static final String SEARCH_SLOT_ADMIN = "searchSlot";
    private static final String SEARCH_SLOT_ADMIN_ACTION = "SearchSlotAdmin";

    private static final String ADD_USER = "AddUser";
    private static final String ADD_USER_ACTION = "AddUserServlet";

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
                url = LECTURER_HOME;
            } else if (action.equals(ADMIN_PAGE)) {
                url = ADMIN_PAGE_ACTION;
            } else if (CREATE_REQUEST.equals(action)) {
                url = REQUEST_ACTION;
            } else if (VIEW_BOOKING.equals(action)) {
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
            } else if (action.equals(ADMIN_IMPORT_PAGE)) {
                url = ADMIN_IMPORT_PAGE_ACTION;
            } else if (action.equals(ADMIN_IMPORTSTUDENT)) {
                url = ADMIN_IMPORTSTUDENT_ACTION;
            } else if (action.equals(ADMIN_IMPORTTIMETABLES)) {
                url = ADMIN_IMPORTTIMETABLES_ACTION;
            } else if (action.equals(ADMIN_PAGE)) {
                url = ADMIN_PAGE_ACTION;
            } else if (ACCEPT_REQUEST.equals(action)) {
                url = ACCEPT_REQUEST_CONTROLLER;
            } else if (DELETE_REQUEST.equals(action)) {
                url = DELETE_REQUEST_CONTROLLER;
            } else if (SEARCH_CREATE_SLOT_ACTION.equals(action)) {
                url = SEARCH_CREATE_SLOT_SERVLET;
            } else if (SEARCH_FREE_SLOT_ACTION.equals(action)) {
                url = SEARCH_FREE_SLOT_SERVLET;
            } else if (VIEW_USERS.equals(action)) {
                url = VIEW_USERS_PAGE;
            } else if (SEARCH_USERS.equals(action)) {
                url = SEARCH_USERS_CONTROLLER;
            } else if (UPDATE_USERS.equals(action)) {
                url = UPDATE_USERS_CONTROLLER;
            } else if (REQUEST_STATUS.equals(action)) {
                url = ALL_REQUEST_STATUS_CONTROLLER;
            } else if (SEARCH_REQUEST_STATUS.equals(action)) {
                url = SEARCH_REQUEST_STATUS_ACTION;
            } else if (CHECK_ATTENDANCE_ACTION_STUDENT.equals(action)) {
                url = CHECK_ATTENDANCE_SERVLET_STUDENT;
            } else if (CHECK_ATTENDANCE_ACTION_LECTURER.equals(action)) {
                url = CHECK_ATTENDANCE_SERVLET_LECTURER;
            } else if (BOOKING_FREE_SLOT.equals(action)) {
                url = BOOKING_FREE_SLOT_SERVLET;
            } else if (SEARCH_BOOKED_SLOT_ACTION.equals(action)) {
                url = SEARCH_BOOKED_SLOT_SERVLET;
            } else if (SEARCH_REQUEST_FOR_LEC.equals(action)) {
                url = SEARCH_REQUEST_FOR_LEC_ACTION;
            } else if (CREATED_VIEW_FREE_SLOT_ACTION.equals(action)) {
                url = CREATED_VIEW_CONTROLLER;
            } else if (SEARCH_REQUEST_STATUS.equals(action)) {
                url = SEARCH_REQUEST_STATUS_ACTION;
            } else if (REQUEST_STATUS.equals(action)) {
                url = REQUEST_STATUS_PAGE;
            } else if (SEND_EMAIL_ACTION.equals(action)) {
                url = SEND_EMAIL_SERVLET;
            } else if (VIEW_BOOKING_HISTORY.equals(action)) {
                url = VIEW_BOOKING_HISTORY_CHECK_SEMES_ACTION;
            } else if (VIEW_BOOKING_HISTORY_CHECK_SEMES.equals(action)) {
                url = VIEW_BOOKING_HISTORY_PAGE_ACTION;
            } else if (VIEW_BOOKING_HISTORY_SERVLET.equals(action)) {
                url = VIEW_BOOKING_HISTORY_SERVLET_ACTION;
            } else if (CHANGE_PASS.equals(action)) {
                url = CHANGE_PASS_ACTION;
            } else if (CHANGE_PASS_PAGE_ACTION.equals(action)) {
                url = CHANGE_PASS_PAGE_SERVLET;
            } else if (HOME_ACTION_ADMIN.equals(action)) {
                url = HOME_PAGE_ADMIN;
            } else if (STUDENT_PAGE_ACTION_RETURN.equals(action)) {
                url = STUDENT_PAGE_ACTION;
            } else if (VIEW_FREESLOT_HISTORY.equals(action)) {
                url = VIEW_FREESLOT_HISTORY_CHECK_SEMES_ACTION;
            } else if (VIEW_FREESLOT_HISTORY_CHECK_SEMES.equals(action)) {
                url = VIEW_FREESLOT_HISTORY_PAGE;
            } else if (VIEW_FREESLOT_HISTORY_SERVLET.equals(action)) {
                url = VIEW_FREESLOT_HISTORY_PAGE_ACTION;
            } else if (VIEW_FREESLOT_HISTORY_PAGE_SERVLET.equals(action)) {
                url = VIEW_FREESLOT_HISTORY_SERVLET_ACTION;
            } else if (SEND_EMAIL_REMIND_ACTION.equals(action)) {
                url = SEND_EMAIL_REMIND_SERVLET;
            } else if (COUNT_PAGE.equals(action)) {
                url = COUNT_PAGE_SERVLET;
            } else if (BAN_USER_ACTION.equals(action)) {
                url = BAN_USER_SERVLET;
            } else if (UNBAN_USER_ACTION.equals(action)) {
                url = UNBAN_USER_SERVLET;
            } else if (ADD_SUBJECT.equals(action)) {
                url = ADD_SUBJECT_ACTION;
            } else if (REMOVE_SUBJECT.equals(action)) {
                url = REMOVE_SUBJECT_ACTION;
            } else if (MANAGE_SUBJECT_SERVLET.equals(action)) {
                url = ADMIN_SUBJECT_PAGE;
            } else if (SEARCH_SUBJECT.equals(action)) {
                url = SEARCH_SUBJECT_ACTION;
            } else if (UPDATE_SUBJECT.equals(action)) {
                url = UPDATE_SUBJECT_ACTION;
            } else if (ADD_USER.equals(action)) {
                url = ADD_USER_ACTION;
            } else if (ADMIN_IMPORT_SUBJECT.equals(action)) {
                url = ADMIN_IMPORT_SUBJECT_ACTION;
            } else if (SEARCH_SLOT_ADMIN.equals(action)) {
                url = SEARCH_SLOT_ADMIN_ACTION;
            } else if (ADMIN_ADD_DATA.equals(action)) {
                url = ADMIM_ADD_DATA_PAGE;
            } else if (ADMIN_MANAGE_SLOTS.equals(action)) {
                url = ADIMIN_MANAGE_SLOTS_PAGE;
            } else if (VIEW_LECTURER_PROFILE.equals(action)) {
                url = VIEW_LECTURER_PROFILE_ACTION;
            } else if (ADD_MAJOR.equals(action)) {
                url = ADD_MAJOR_CONTROLLER;
            } else if (DELETE_MAJOR.equals(action)) {
                url = DELETE_MAJOR_CONTROLLER;
            } else if (ACCEPT_ALL_REQUEST.equals(action)) {//acceptAllRequest
                url = ACCEPT_ALL_REQUEST_CONTROLLER;
            } else if (DECLINE_ALL_REQUEST.equals(action)) {//declineAllRequest
                url = DECLINE_ALL_REQUEST_CONTROLLER;
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
