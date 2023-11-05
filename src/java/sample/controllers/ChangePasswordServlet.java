/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

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
public class ChangePasswordServlet extends HttpServlet {

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
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            int rs;
            String URL = "MainController?action=";
            String userID = us.getUserID();
            String usPass = us.getPassword();
            String defaultPass = request.getParameter("txtdefault");
            String newPass = request.getParameter("txtnewpass");
            String confirmPass = request.getParameter("txtconfirmpass");
            System.out.println(defaultPass);
            System.out.println(newPass);
            System.out.println(confirmPass);
            if (usPass.equals(defaultPass)) {
                System.out.println("qua dc default pass");
                if (newPass.equals(confirmPass)) {
                    rs = UserDAO.changePassword(userID, confirmPass);
                    System.out.println("rs: " + rs);
                    if (rs > 0) {
                        request.setAttribute("CHANGEPASS", "Change password successfully");
                        URL = "MainController?action=changePass";
                    } else {
                        request.setAttribute("FAILPASS", "Change password fail");
                        URL = "MainController?action=changePass";
                    }
                } else {
                    request.setAttribute("CONFIRMPASS", "Confirm password not correct !");
                    URL = "MainController?action=changePass";
                }
            } else {
                request.setAttribute("DEFAULTPASS", "Incorrect default password");
                URL = "MainController?action=changePass";
            }
            request.getRequestDispatcher(URL).forward(request, response);
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
