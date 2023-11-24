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
import sample.mail.EmailDAO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class AddUserServlet extends HttpServlet {

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
            int rs = 0;
            String url = "MainController?action=ManageServlet";
            String subject = "Meet My Lecturer";
            System.out.println("Vao dc add servlet");
            String id = request.getParameter("txtuserid").trim();
            String name = request.getParameter("txtusername").trim();
            String email = request.getParameter("txtuseremail").trim();
            int status = 2;
            String role = request.getParameter("txtuserrole").trim();
            int passWord = (int) (Math.random() * 1000000) % 1000 + 10000;
            String password = String.valueOf(passWord);
            System.out.println("Hello" + id);

            UserDTO user = new UserDTO(id, name, email, status, role, password);
            UserDTO check = UserDAO.getUserByID(id);
            if (check == null) {
                rs = UserDAO.insertUser(user);
                String content = String.format("<!DOCTYPE html>%n"
                                                + "<html>%n"
                                                + "<head>%n"
                                                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">%n"
                                                + "</head>%n"
                                                + "<body style=\"background-color: #f2f2f2;\">%n"
                                                + "    <div style=\"background-color: #0078d4; color: white; padding: 10px;\">%n"
                                                + "        <h1>%s</h1>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"padding: 10px;\">%n"
                                                + "        <p>Hello,</p>%n"
                                                + "        <p>%s</p>%n"
                                                + "        <p>Cảm ơn bạn đã đọc email này.</p>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"background-color: #f2f2f2; padding: 10px;\">%n"
                                                + "        <p>Đây là phần chân trang của email.</p>%n"
                                                + "        <p>Liên hệ: example@example.com</p>%n"
                                                + "    </div>%n"
                                                + "</body>%n"
                                                + "</html>",
                                                email, password);
                                        EmailDAO.sendMail(email, subject, content);
                if (rs > 0) {
                    request.setAttribute("AddUserStatus", "Add successfully!");
                    url = "MainController?action=ManageServlet";
                } else {
                    request.setAttribute("AddUserStatus", "Add fail!");
                    url = "MainController?action=ManageServlet";
                }
            } else {
                request.setAttribute("AddUserStatus", "User existed");
                url = "MainController?action=ManageServlet";
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
