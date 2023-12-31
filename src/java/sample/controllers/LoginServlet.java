/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import sample.users.UserGoogleDto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class LoginServlet extends HttpServlet {

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
            UserGoogleDto dto = new UserGoogleDto();
            dto = (UserGoogleDto) request.getAttribute("UserGG");
            String email = dto.getEmail();
            UserDTO us = UserDAO.getUserByMail(email);
            boolean flag = false;
            if (us != null) {
                if (us.getUserStatus() != 0) {
                    flag = true;
                    HttpSession session = request.getSession();
                    session.setAttribute("loginedUser", us);
                    if (us.getRoleID().equals("3")) {
                        response.sendRedirect("MainController?action=StudentPage");
                    } else if ((us.getRoleID().equals("2"))) {
                        response.sendRedirect("MainController?action=LecturerPage");
                    } else if ((us.getRoleID().equals("1"))) {
                        response.sendRedirect("MainController?action=AdminPage");
                    }
                } else {
                    String msg = "Your account has been banned";
                    request.setAttribute("Error", msg);
                    request.getRequestDispatcher("MainController?action=").forward(request, response);
                }
            } else {
                String msg = "Your email is not granted access to the system";
                request.setAttribute("Error", msg);
                request.getRequestDispatcher("MainController?action=").forward(request, response);
            }
//                request.getRequestDispatcher("MainController?action=").forward(request, response);
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
