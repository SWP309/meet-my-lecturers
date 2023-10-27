/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.users.UserDTO;

/**
 *
 * @author PC
 */
public class CheckAttendanceBookingView extends HttpServlet {

    private static final String ERROR = "BookingView.jsp";
    private static final String SUCCESS = "BookingView.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String bookingID = request.getParameter("bookingID"); // Lấy bookingID từ yêu cầu
//            BookingDTO listBooking = (BookingDTO) request.getAttribute("LIST_BOOKING");
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            System.out.println(bookingID);
            if (bookingID != null) {
                BookingDAO dao = new BookingDAO();
                boolean checkUpdate = dao.checkAttendance(bookingID);
                System.out.println(checkUpdate);
                if (checkUpdate) {
                    List<BookingDTO> updatedBookings = dao.getListBooking(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                    request.setAttribute("LIST_BOOKING", updatedBookings);
                    url = SUCCESS;
                    if (updatedBookings == null || updatedBookings.isEmpty()) {
                        request.setAttribute("ERROR", "List of Booking is null. Do not have any things to show");
                    }
                }
            } else {
                request.setAttribute("ERROR", "List of Booking is null. Do not have any things to show");
            }
        } catch (Exception e) {
            log("Error at UpdateController: " + e.toString());
            request.setAttribute("ERROR", "An error occurred.");
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
