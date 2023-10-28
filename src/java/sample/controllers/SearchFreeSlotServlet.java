/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;

public class SearchFreeSlotServlet extends HttpServlet {
    private final String SUCCESS = "StudentHome_1.jsp";
    private final String ERROR = "StudentHome_1.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String subjectCode = request.getParameter("txtSubjectCode");
            String lecturerID = request.getParameter("txtUserID");
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            if (!subjectCode.isEmpty() && lecturerID.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubjectCode(subjectCode);
                List<FreeSlotsDTO> freeSlotBySubject = freeSlotsDAO.getFreeSlotBySubjectCode();
                if (freeSlotBySubject != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT", freeSlotBySubject);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && !lecturerID.isEmpty()) {
                
            } else if (!subjectCode.isEmpty() && !lecturerID.isEmpty()) {
                
            } else {
                request.setAttribute("SEARCH_FREESLOT_MESSAGE", "The system has no freeslot that meet your requirement!!!");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at SearchFreeSlotServlet: " + ex.toString());
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
