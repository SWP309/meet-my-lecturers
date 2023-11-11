/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.dashboard.UserMaxSlotDTO;
import sample.dashboard.UserMaxRequestDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

public class DashBoardServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
//            String semester = request.getParameter("txtsemester");
            String semester = "FA23";
            if (semester != null) {
                Date date = new Date();
                BookingDAO bookingDAO = new BookingDAO();
                //Top 5 Lec created max slot and number
                List<UserDTO> lecMaxFSNum = UserDAO.getLecturerMaxFSNumber(date);
                List<UserDTO> lecMaxReqNum = UserDAO.getLecturerMaxRequestNumber(date);
                List<BookingDTO> stuMaxAbsentNum = bookingDAO.bookingAbsenceNumber();
                List<BookingDTO> stuMaxCancelNum = bookingDAO.bookingCancelNumber();
                boolean flag = false;

                //da doi ten so voi ban dau LecturerMaxSlot
                
                if (lecMaxFSNum.isEmpty()) {
                    request.setAttribute("MAX_FS_MESSAGE", "No data about Top 5 Lecturer that created max FreeSlot!!!");
                } else {
                    request.setAttribute("Top5LecCreatedMaxSlot", lecMaxFSNum);
                }
                if (lecMaxFSNum.isEmpty()) {
                    request.setAttribute("MAX_REQUEST_MESSAGE", "No data about Top 5 Lecturer that received max Request!!!");
                } else {
                    request.setAttribute("Top5LecReceivedMaxRequest", lecMaxReqNum);
                }
                if (stuMaxAbsentNum.isEmpty()) {
                    request.setAttribute("MAX_ABSENT_MESSAGE", "No data about Top 5 Max Absent Student!!!");
                } else {
                    request.setAttribute("Top5StuMaxAbsentNum", stuMaxAbsentNum);
                }
                if (stuMaxCancelNum.isEmpty()) {
                    request.setAttribute("MAX_CANCEL_MESSAGE", "No data about Top 5 Max Cancel Student!!!");
                } else {
                    request.setAttribute("Top5StuMaxCancelNum", stuMaxCancelNum);
                }
                
                request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
            } else {
                System.out.println("Semester == null");
                request.setAttribute("MSG", "Null semester");
                request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
