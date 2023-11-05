/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.attendance.AttendanceDAO;
import sample.attendance.AttendanceDTO;
import sample.semester.SemesterDTO;
import sample.semester.SemesterDAO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class AttendanceServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            SemesterDAO semesterDAO = new SemesterDAO();
            ArrayList<SemesterDTO> listSemes = (ArrayList<SemesterDTO>) semesterDAO.select();
            request.setAttribute("semester", listSemes);
            UserDTO userDTO = (UserDTO) session.getAttribute("loginedUser");
            System.out.println(userDTO);
            String semes = request.getParameter("txtsemes");
            System.out.println(semes);
            String studentID = userDTO.getUserID();
            System.out.println(studentID);
            System.out.println("AttendanceServletttttttt");
            String url = "MainController?action=attendServlet";
            ArrayList<AttendanceDTO> attendSlot = AttendanceDAO.getAttendanceSlot(studentID, semes);
            System.out.println(attendSlot);
            if (attendSlot != null) {
                request.setAttribute("attend", attendSlot);
            } else {
                out.print("list null");
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
