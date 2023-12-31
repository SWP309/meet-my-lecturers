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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.dashboard.UserMaxSlotDTO;
import sample.dashboard.UserMaxRequestDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class DashBoardServlet extends HttpServlet {

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
            String semester = request.getParameter("txtsemester");
            if (semester != null) {
                BookingDAO bookingDAO = new BookingDAO();
                UserMaxSlotDTO stmb = UserDAO.getStudentMaxBook(semester);
                UserMaxRequestDTO stmr = UserDAO.getStudentMaxRequest(semester);
                UserMaxSlotDTO ltmb = UserDAO.getLecturerMaxSlot(semester);
                UserMaxRequestDTO lmr = UserDAO.getLecturerMaxRequest(semester);
                BookingDTO stuMaxAbsentNum = bookingDAO.bookingAbsenceNumberBySemester(semester);
                BookingDTO stuMaxCancelNum = bookingDAO.bookingCancelNumberBySemester(semester);
                boolean flag = false;
                request.setAttribute("Top5StuMaxAbsentNum", stuMaxAbsentNum);
                request.setAttribute("Top5StuMaxCancelNum", stuMaxCancelNum);
                request.setAttribute("UserMaxSlot", stmb);
                request.setAttribute("UserMaxRequest", stmr);
                request.setAttribute("LecturerMaxSlot", ltmb);
                request.setAttribute("LecturerMaxRequest", lmr);
                System.out.println(semester);
                if (semester.equals("")) {
                    request.setAttribute("MSG", "Null semester");
                }
                request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
            } else {
                System.out.println("Semester == null");
                request.setAttribute("MSG", "Null semester");
                request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
            }
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
