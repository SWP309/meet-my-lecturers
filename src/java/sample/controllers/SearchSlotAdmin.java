/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.adminView.ViewBookedSlotAdminDAO;
import sample.adminView.ViewBookedSlotAdminDTO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class SearchSlotAdmin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String url = "";
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String userID = request.getParameter("txtUser").toUpperCase();
            String role = request.getParameter("txtRole");
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date starts = format.parse(startTime);
            Date ends = format.parse(endTime);
            if (role.equals("2")) {
                if (userID.startsWith("GV")) {
                    ArrayList<ViewBookedSlotAdminDTO> list = ViewBookedSlotAdminDAO.getAllCreatedSlots(userID, starts, ends);
                    if (list != null) {

                        request.setAttribute("listSlot", list);
                        url = "AdminViewSlot.jsp";
                    } else {
                        request.setAttribute("Error", "List null");
                        url = "AdminViewSlot.jsp";
                    }
                } else {
                    request.setAttribute("Error", "Not found");
                    url = "AdminViewSlot.jsp";
                }
            } else {
                if (userID.startsWith("SE")) {
                    ArrayList<ViewBookedSlotAdminDTO> list = ViewBookedSlotAdminDAO.getAllBookedSlots(userID, starts, ends);
                    if (!list.isEmpty()) {

                        request.setAttribute("listSlot", list);
                        url = "AdminViewSlot.jsp";
                    } else {
                        request.setAttribute("Error", "List null");
                        url = "AdminViewSlot.jsp";
                    }
                } else {
                    request.setAttribute("Error", "Not found");
                    url = "AdminViewSlot.jsp";
                }
            }
            request.getRequestDispatcher(url).forward(request, response);
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
