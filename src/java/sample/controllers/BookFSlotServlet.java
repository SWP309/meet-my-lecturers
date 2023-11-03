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
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.users.UserDTO;

/**
 *
 * @author PC
 */
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
            boolean flag = true;
            HttpSession session = request.getSession();
            BookingDAO dao = new BookingDAO();
            BookingDTO dto = new BookingDTO();
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            String freeSlotID = request.getParameter("txtFSlotID");
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String studentID = us.getUserID();
            boolean existsInBlockList = freeSlotsDAO.checkBlockList(studentID,freeSlotID);
            if (existsInBlockList) {
                request.setAttribute("ERROR", "You have been BLOCKED from this slot, please contact your lecturer ONE BY ONE to know reasons !!!!!!!");
                flag = false;
                dto.setStatus(0);
            }

            if (flag) {
                
                dto.setStudentID(studentID);
                dto.setFreeSlotID(freeSlotID);
                if (freeSlotID != null) {
                    boolean checkUpdate = dao.BookFSlot(dto);
                    List<BookingDTO> listbooking = dao.getListBooking(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                    request.setAttribute("LIST_CREATED_SLOT", listbooking);
                    if (checkUpdate) {
                        System.out.println(checkUpdate);
                        url = SUCCESS;
                        if (listbooking == null || listbooking.isEmpty()) {
//                        System.out.println("list booking is null");
                            request.setAttribute("ERROR", "LIST_CREATED_SLOT is null. Do not have any things to show");
                        }
                    } else {
                        request.setAttribute("ERROR", "Start Time must be less than End Time and The total study duration should be at least 15 minutes.");
                    }
                }
            }

        } catch (Exception e) {
            log("Error at UpdateController: " + e.toString());
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
