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
public class loginByFeID extends HttpServlet {

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
            String password = request.getParameter("txtpassword");
            UserDTO us = UserDAO.getUser(email);
            boolean flag = false;
            
            if (us != null) {
                if (us.getPassword().equals(password)) {
                    flag = true;
                    HttpSession session = request.getSession();
                    session.setAttribute("loginedUser", us);
                    if (us.getRoleID().equals("3")) {
                        response.sendRedirect("MainController?action=studentPage");
                    } else if((us.getRoleID().equals("2"))) {
                        response.sendRedirect("MainController?action=lecturerPage");
                    } else if((us.getRoleID().equals("1"))) {
                        response.sendRedirect("MainController?action=adminPage");
                    }
                } else {
//                    response.sendRedirect("errorpage.html");
                    flag = false;
                    
                }
            } else {
//                response.sendRedirect("errorpage.html");
                flag = false;
                
            }
            if(!flag){
                String msg = "invalid userid or password";
                // luu vao o nho request de dem qua loginpage.jsp
                request.setAttribute("Error", msg);
                request.getRequestDispatcher("MainServlet?action=1").forward(request, response);
            }
        } catch(Exception e){
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