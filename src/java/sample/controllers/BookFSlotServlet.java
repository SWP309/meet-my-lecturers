package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.blocklist.BlockListDAO;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.bookings.BookingError;
import sample.freeslots.FreeSlotsDAO;
import sample.users.UserDTO;

public class BookFSlotServlet extends HttpServlet {

    private static final String ERROR = "StudentHome_1.jsp";
    private static final String SUCCESS = "StudentHome_1.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.

        String url = ERROR;

        try {
            boolean checkValidation = true;
            HttpSession session = request.getSession();
            BookingDAO dao = new BookingDAO();
            FreeSlotsDAO FsDao = new FreeSlotsDAO();
            BlockListDAO blockListDAO = new BlockListDAO();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String studentID = us.getUserID();
            
            String freeSlotID = request.getParameter("txtFSlotID");
            String LecturerID = request.getParameter("txtLecturerID");
            
            String startTime = request.getParameter("txtStartTime");
            
            String endTime = request.getParameter("txtEndTime");
            
            String txtPassword = request.getParameter("txtPassword");
            String password = request.getParameter("password");
            BookingDTO dto = new BookingDTO();
            dto.setStudentID(studentID);
            dto.setFreeSlotID(freeSlotID);
            BookingError bookingError = new BookingError();
            boolean existsInBlockListFS = FsDao.checkBlockList(studentID);
            boolean existsInBlockList = blockListDAO.checkStudentInBlockListOfLecturer(studentID, LecturerID);
            if (existsInBlockListFS || existsInBlockList) {
                checkValidation = false;
                bookingError.setInBlockList("You have been BLOCKED form by ALL THE SLOTS by " + LecturerID + ", please contact your lecturer ONE BY ONE to know reasons !!!!!!!");
                dto.setStatus(-1);
            }
            //tranfer String to Date
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date start = format.parse(startTime);
            Date ends = format.parse(endTime);
            //check password
            if (!password.isEmpty()) {
                if (!txtPassword.equals(password)) {
                    checkValidation = false;
                    bookingError.setCheckPassword("Wrong password!!!");
                    System.out.println("sai dong 78");
                }
            }
            //*****check duplicateBookedFSlot
            boolean checkStartDuplicateBookedFS = dao.checkTimeDuplicateInBookedFreeSlot(studentID, start);
            boolean checkEndDuplicateBookedFS = dao.checkTimeDuplicateInBookedFreeSlot(studentID, ends);
            
            if (checkStartDuplicateBookedFS == false || checkEndDuplicateBookedFS == false) {
                checkValidation = false;
                bookingError.setDuplicateBookedSlot("This slot was duplicated with another booked slot!!!");
                System.out.println("Bi duplicate");
            }
            
            boolean checkTimeDuplicateInBookedCancel = dao.checkTimeDuplicateInBookedCancel(studentID, start);
            request.setAttribute("BOOKING_ERROR", bookingError);

            if (checkValidation) {
                if (checkTimeDuplicateInBookedCancel == false || checkTimeDuplicateInBookedCancel == false) {
                    dao.DeleteStatusBookedCancel(freeSlotID);
                }
                boolean checkUpdate = dao.BookFSlot(dto);
                List<BookingDTO> listbooking = dao.getListBooking(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                request.setAttribute("LIST_CREATED_SLOT", listbooking);
                if (checkUpdate) {
                    url = SUCCESS;
                    if (listbooking == null || listbooking.isEmpty()) {
                        request.setAttribute("ERROR", "LIST_CREATED_SLOT is null. Do not have any things to show");
                    }
                } else {
                    request.setAttribute("ERROR", "Can not book the slot cause of Error in code");
                }
            }
        } catch (SQLException | ParseException | ClassNotFoundException ex) {
            log("Error at BookFSlotServlet: " + ex.toString());
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
