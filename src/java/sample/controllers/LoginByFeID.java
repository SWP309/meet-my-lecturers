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
public class LoginByFeID extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtemail");
            System.out.println(email);
            String password = request.getParameter("txtpassword");
            System.out.println(password);
            UserDTO us = UserDAO.getUser(email);
            boolean flag = true;

            if (us != null) {
                if (us.getPassword().equals(password)) {
                    if (us.getUserStatus() != 0) {
                        flag = true;
                        HttpSession session = request.getSession();
                        session.setAttribute("loginedUser", us);
                        System.out.println("Lay dc user: " + us);
                        if(us.getUserStatus() == 2){
                            System.out.println("Vao status = 2");
                            request.setAttribute("showConfirmation", "Do you want to change your password ?");
                        }
                        System.out.println("Role la: " + us.getRoleID());
                        if (us.getRoleID().equals("3")) {
//                            response.sendRedirect("MainController?action=StudentPage");
                            request.getRequestDispatcher("MainController?action=returnHomePageStudent").forward(request, response);
                        } else if ((us.getRoleID().equals("2"))) {
//                            response.sendRedirect("MainController?action=LecturerPage");
                            request.getRequestDispatcher("MainController?action=LecturerPage").forward(request, response);
                        } else if ((us.getRoleID().equals("1"))) {
                            System.out.println("Vao dc role = 1");
//                            response.sendRedirect("MainController?action=AdminPage");
                            request.getRequestDispatcher("MainController?action=returnHomePageAdmin").forward(request, response);
                        }
                    } else {
                        String msg = "Your account has been banned";
                        request.setAttribute("ban", msg);
                        flag = false;
                    }
                } else {
                    String msg = "Invalid userid or password";
                    request.setAttribute("Error", msg);
                    flag = false;
                }
            } else {
                String msg = "Invalid userid or password";
                request.setAttribute("Error", msg);
                flag = false;
            }
            if(!flag){
            request.getRequestDispatcher("MainController?action=").forward(request, response);
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
