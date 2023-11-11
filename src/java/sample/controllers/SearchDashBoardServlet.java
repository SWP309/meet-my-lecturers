
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;

public class SearchDashBoardServlet extends HttpServlet {
    private String SUCCESS = "";
    private final String ERROR = "DashBoardServlet";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String studentID = request.getParameter("txtStudentID");
            String lecturerID = request.getParameter("txtLecturerID");
            String check = request.getParameter("check");
            BookingDAO bookingDAO = new BookingDAO();
            List<BookingDTO> studentAbsentInfo = bookingDAO.getStudentMaxAbsentIn4(studentID);
            for (BookingDTO bookingDTO : studentAbsentInfo) {
                System.out.println(bookingDTO.getBookingID());
            }
            List<BookingDTO> studentCancelInfo = bookingDAO.getStudentMaxCancelIn4(studentID);
            for (BookingDTO bookingDTO : studentCancelInfo) {
                System.out.println(bookingDTO.getBookingID());
            }
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            
            List<FreeSlotsDTO> lecturerFSInfo = freeSlotsDAO.getLecturerMaxFSIn4(lecturerID);
            System.out.println("List FreeSlot: ");
            for (FreeSlotsDTO freeSlotsDTO : lecturerFSInfo) {
                System.out.println(freeSlotsDTO.getFreeSlotID());
            }
            
            RequestDAO requestDAO = new RequestDAO();
            System.out.println("List Request: ");
            List<RequestDTO> lecturerRequestInfo = requestDAO.getLecturerMaxRequestIn4(lecturerID);
            System.out.println("List Request: ");
            for (RequestDTO requestDTO : lecturerRequestInfo) {
                System.out.println(requestDTO.getRequestID());
            }
            if (studentAbsentInfo != null && check.equals("1")) {
                request.setAttribute("STUDENT_ABSENT_INFO", studentAbsentInfo);
                SUCCESS = "StuAbsentInFo.jsp";
                url = SUCCESS;
            }
            if (studentCancelInfo != null && check.equals("2")) {
                request.setAttribute("STUDENT_CANCEL_INFO", studentCancelInfo);
                SUCCESS = "StuCancelInFo.jsp";
                url = SUCCESS;
            }
            if (lecturerFSInfo != null && check.equals("3")) {
                request.setAttribute("LECTURER_FS_INFO", lecturerFSInfo);
                SUCCESS = "LecFS.jsp";
                url = SUCCESS;
            }
            if (lecturerRequestInfo != null && check.equals("4")) {
                request.setAttribute("LECTURER_REQUEST_INFO", lecturerRequestInfo);
                SUCCESS = "LecRequest.jsp";
                url = SUCCESS;
            }
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            log("Error at SearchDashBoardServlet: " + ex.toString());
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
