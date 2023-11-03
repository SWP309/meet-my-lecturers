/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
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
public class SearchCreateSlotServlet extends HttpServlet {

    private final String SUCCESS = "CreatedSlotView.jsp";
    private final String ERROR = "CreatedSlotView.jsp";

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
            String semesterID = request.getParameter("txtSemesterID");
            String userEmail = us.getUserEmail();
            ViewCreatedSlotDAO searchFSlot = new ViewCreatedSlotDAO();
            if (!startTime.isEmpty() && !endTime.isEmpty() && subjectCode.isEmpty()) {
                List<ViewCreatedSlotDTO> searchByStEt = searchFSlot.searchFSlotViewByStEt(startTime, endTime, userEmail);
                if (searchByStEt != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_ST_ET", searchByStEt);
                    url = SUCCESS;
                }
            } else if (!startTime.isEmpty() && !endTime.isEmpty() && !subjectCode.isEmpty() && !semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchByAll = searchFSlot.searchFSlotViewByAll(subjectCode, startTime, endTime, userEmail, semesterID);
                if (searchByAll != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_ALL", searchByAll);
                    url = SUCCESS;
                }

            } else if (startTime.isEmpty() && endTime.isEmpty() && !subjectCode.isEmpty() && semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchBySubjectCode = searchFSlot.searchFSlotViewBySubjectCode(subjectCode, userEmail);
                if (searchBySubjectCode != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_SUBJECT", searchBySubjectCode);
                    System.out.println(subjectCode);
                    url = SUCCESS;
                }

            } else if (startTime.isEmpty() && endTime.isEmpty() && subjectCode.isEmpty() && semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchByNull = searchFSlot.GetlistCreatedSlot(us.getUserEmail());
                System.out.println(us.getUserEmail());
                if (searchByNull != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_NULL", searchByNull);
                    url = SUCCESS;
                }

            } else if (!startTime.isEmpty() && !endTime.isEmpty() && !subjectCode.isEmpty() && semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchByStEtSubject = searchFSlot.searchFSlotViewByStEtSubjectCode(subjectCode, startTime, endTime, userEmail);
                System.out.println(us.getUserEmail());
                if (searchByStEtSubject != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_ST_ET_SUBJECTCODE", searchByStEtSubject);
                    url = SUCCESS;
                }

            } else if (!startTime.isEmpty() && !endTime.isEmpty() && subjectCode.isEmpty() && !semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchByStEtSemesterID = searchFSlot.searchFSlotViewByStEtSemesterID(semesterID, startTime, endTime, userEmail);
                System.out.println(us.getUserEmail());
                if (searchByStEtSemesterID != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_ST_ET_SEMESTER", searchByStEtSemesterID);
                    url = SUCCESS;
                }

            }else if (startTime.isEmpty() && endTime.isEmpty() && subjectCode.isEmpty() && !semesterID.isEmpty()) {
                List<ViewCreatedSlotDTO> searchBySemesterID = searchFSlot.searchFSlotViewBySemesterID(semesterID, userEmail);
                System.out.println(us.getUserEmail());
                if (searchBySemesterID != null) {
                    request.setAttribute("SEARCH_FREE_SLOT_BY_SEMESTER", searchBySemesterID);
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
