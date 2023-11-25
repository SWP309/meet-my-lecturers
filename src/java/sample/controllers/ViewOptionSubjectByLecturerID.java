/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
 * @author PC
 */
@WebServlet(name = "ViewOptionSubjectByLecturerID", urlPatterns = {"/searchbyLecturerID"})
public class ViewOptionSubjectByLecturerID extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        System.out.println(txtSearch);
        HttpSession session = request.getSession();
        UserDTO us = (UserDTO) session.getAttribute("loginedUser");
        FreeSlotsDAO searchDao = new FreeSlotsDAO();
        Date date = new Date();
        List<FreeSlotsDTO> ListSubjectByLecturer = searchDao.GetListSubjectCodeByLecturer(date, txtSearch);
        PrintWriter out = response.getWriter();
        for (FreeSlotsDTO list : ListSubjectByLecturer) {
            out.println("<a style=\"  display: flex;\n"
                    + "    gap: 10px; padding: 10px; color:black;\" href=\"MainController?action=SearchFSlot&txtSubjectCode=" + list.getSubjectCode() + "&txtLecturerID=" + txtSearch  + "&txtLecturerName=" + txtSearch + "\" ><i class=\"material-icons\">book</i> " + list.getSubjectCode() +" / "+ list.getLecturerName() + " </a>");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewOptionSubjectByLecturerID.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewOptionSubjectByLecturerID.class.getName()).log(Level.SEVERE, null, ex);
        }
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
