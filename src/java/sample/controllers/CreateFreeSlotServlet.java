/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.users.UserDTO;

/**
 *
 * @author W10(hiep-tm)
 */
@WebServlet(name = "CreateFreeSlotServlet", urlPatterns = {"/newfreeslot"})
public class CreateFreeSlotServlet extends HttpServlet {

    private static final String ERROR = "create-freeSlot.jsp";
    private static final String SUCCESS = "CreatedSlotController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            System.out.println(url);
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String password = request.getParameter("txtPassword");
            System.out.println(subjectCode);
            if (password == null) {
                System.out.println("hello ");
                password = null; // Chuyển chuỗi trống thành giá trị null
            }
            System.out.println("hello pass");
            System.out.println(request.getParameter("txtCapacity"));
            int capacity = Integer.parseInt(request.getParameter("txtCapacity"));;
            String meetLink = request.getParameter("txtMeetLink");
            System.out.println("hello count");
            int count = Integer.parseInt(request.getParameter("txtCount"));
            if (count == 0) {
                count = 1; // Chuyển chuỗi trống thành giá trị null
            }
            String lecturerID = request.getParameter("txtLecturerID");
            boolean status = true;
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(subjectCode, startTime, endTime, password, capacity, meetLink, count, lecturerID, status);
            boolean checkCreated = freeSlotsDAO.createFreeSlot(freeSlotsDTO);
            System.out.println(checkCreated);
            if (checkCreated) {
                url = SUCCESS;
            }
        } catch (SQLException ex) {
            log("Error at CreateFreeSlotServlet" + ex.toString());
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
