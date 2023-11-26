/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.blocklist.BlockListDAO;
import sample.blocklist.BlockListDTO;
import sample.users.UserDTO;

/**
 *
 * @author W10(hiep-tm)
 */
public class SearchBlockListServlet extends HttpServlet {

    private final String SUCCESS = "ViewBlockList.jsp";
    private final String ERROR = "ViewBlockList.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String lecturerID = us.getUserID();
            String studentID = request.getParameter("txtStudentID");
            String status = request.getParameter("txtStatus");

            BlockListDAO blockListDAO = new BlockListDAO();
            if (studentID.isEmpty() && status.equals("A")) {
                List<BlockListDTO> searchAllBlocklist = blockListDAO.getAllBlockList(lecturerID);
                if (searchAllBlocklist != null) {
                    request.setAttribute("BLOCK_LIST", searchAllBlocklist);
                    url = SUCCESS;
                }
            }
            if (studentID.isEmpty() && status.equals("B")) {
                List<BlockListDTO> searchBlockedInList = blockListDAO.getBlockedInList(lecturerID);
                if (searchBlockedInList != null) {
                    request.setAttribute("BLOCKED_IN_LIST", searchBlockedInList);
                    url = SUCCESS;
                }
            }
            if (studentID.isEmpty() && status.equals("UB")) {
                List<BlockListDTO> searchUnBlockedInList = blockListDAO.getUnBlockedInList(lecturerID);
                if (searchUnBlockedInList != null) {
                    request.setAttribute("UNBLOCKED_IN_LIST", searchUnBlockedInList);
                    url = SUCCESS;
                }
            }
            if (!studentID.isEmpty()) {
                List<BlockListDTO> searchStudentIDInList = blockListDAO.getStudentIDInList(lecturerID, studentID);
                System.out.println(searchStudentIDInList);
                if (searchStudentIDInList != null) {
                    request.setAttribute("STUDENTID_IN_LIST", searchStudentIDInList);
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
