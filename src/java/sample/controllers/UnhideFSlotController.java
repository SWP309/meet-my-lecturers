/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.users.UserDTO;
import sample.viewCreatedSlot.ViewCreatedSlotDAO;
import sample.viewCreatedSlot.ViewCreatedSlotDTO;

/**
 *
 * @author PC
 */
@WebServlet(name = "UnhideFSlotController", urlPatterns = {"/UnhideFSlotController"})
public class UnhideFSlotController extends HttpServlet {

    private static final String ERROR = "CreatedSlotView.jsp";
    private static final String SUCCESS = "CreatedSlotView.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String freeSlotID = request.getParameter("freeSlotID"); // Lấy bookingID từ yêu cầu
//            BookingDTO listslot = (BookingDTO) request.getAttribute("LIST_BOOKING");
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            System.out.println(freeSlotID);
            if (freeSlotID != null) {
                ViewCreatedSlotDAO dao = new ViewCreatedSlotDAO();
                boolean CheckUnhide = dao.UnHide(freeSlotID);
                System.out.println(CheckUnhide);
                if (CheckUnhide) {
                   List<ViewCreatedSlotDTO> listCreatedSlot = dao.GetlistCreatedSlot(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                    request.setAttribute("LIST_CREATED_SLOT", listCreatedSlot);
                    url = SUCCESS;
                    if (listCreatedSlot == null || listCreatedSlot.isEmpty()) {
                        request.setAttribute("ERROR", "LIST_CREATED_SLOT is null. Do not have any things to show");
                    }
                } else{
                    request.setAttribute("ERROR", "Can UnHide this Slot because the function is error at Code !!!");
                }
            } else {
                request.setAttribute("ERROR", "LIST_CREATED_SLOT is null. Do not have any things to show");
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
