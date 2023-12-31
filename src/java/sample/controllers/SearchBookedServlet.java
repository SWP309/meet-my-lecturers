/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
public class SearchBookedServlet extends HttpServlet {

    private final String SUCCESS = "BookingView.jsp";
    private final String ERROR = "BookingView.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String subjectCode = request.getParameter("txtSubjectCode");

            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String userEmail = us.getUserEmail();
            BookingDAO searchBSlot = new BookingDAO();
            System.out.println(subjectCode);
            System.out.println(startTime);
            System.out.println(endTime);
            System.out.println(userEmail);
           

            if (!subjectCode.isEmpty() && !startTime.isEmpty() && !endTime.isEmpty()) {
//                List<BookingDTO> listBooking = searchBSlot.getListBooking(us.getUserEmail());
                List<BookingDTO> searchByStEtSubject = searchBSlot.searchBSlotViewByStEtSubjectCode(subjectCode, startTime, endTime, userEmail);
                if (searchByStEtSubject != null) {
                    for (BookingDTO bookingDTO : searchByStEtSubject) {
                        System.out.println(bookingDTO.getSubjectCode());
                    }
                    request.setAttribute("SEARCH_BOOKED_SLOT_BY_ST_ET_SUBJECTCODE", searchByStEtSubject);
//                    request.setAttribute("LIST_BOOKING", listBooking);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && startTime.isEmpty() && endTime.isEmpty()) {
                List<BookingDTO> searchBySubjectCode = searchBSlot.searchBSlotViewBySubjectCode(subjectCode, us.getUserEmail());
                if (searchBySubjectCode != null) {
                    request.setAttribute("SEARCH_BOOKED_SLOT_BY_SUBJECT", searchBySubjectCode);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && !startTime.isEmpty() && !endTime.isEmpty()) {
                List<BookingDTO> searchByStEt = searchBSlot.searchBSlotViewByStEt(startTime,endTime, us.getUserEmail());
                if (searchByStEt != null) {
                    request.setAttribute("SEARCH_BOOKED_SLOT_BY_ST_ET", searchByStEt);
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("SEARCH_FREESLOT_MESSAGE", "The system has no freeslot that meet your requirement!!!");
            }

        } catch (SQLException ex) {
            log("Error at SearchFSlotServlet: " + ex.toString());
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
