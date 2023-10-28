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
import sample.users.UserDTO;
import sample.viewCreatedSlot.ViewCreatedSlotDAO;
import sample.viewCreatedSlot.ViewCreatedSlotDTO;

/**
 *
 * @author PC
 */
public class CheckAttendanceCreateSlot extends HttpServlet {

    private static final String ERROR = "CreatedSlotController";
    private static final String SUCCESS = "CreatedSlotController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String freeSlotID = request.getParameter("freeSlotID"); 
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            if (freeSlotID != null) {
                ViewCreatedSlotDAO dao = new ViewCreatedSlotDAO();
                System.out.println(freeSlotID);
                boolean checkUpdate = dao.checkAttendance(freeSlotID);
                System.out.println(checkUpdate);
                if (checkUpdate) {
                    List<ViewCreatedSlotDTO> checkAttendance = dao.GetlistCreatedSlot(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                    request.setAttribute("LIST_CHECK_ATTENDACE_LECTURER", checkAttendance);
                    url = SUCCESS;
                    if (checkAttendance == null || checkAttendance.isEmpty()) {
                        request.setAttribute("ERROR", "Check Attendance false");
                    }
                }
            } else {
                request.setAttribute("ERROR", "List of create slot is null. Do not have any things to show");
            }
        } catch (Exception e) {
            log("Error at CheckAttendanceCreateSlot: " + e.toString());
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
