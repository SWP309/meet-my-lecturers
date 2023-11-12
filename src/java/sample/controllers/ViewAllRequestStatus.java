/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;
import sample.users.UserDTO;

public class ViewAllRequestStatus extends HttpServlet {

    private final String SUCCESS = "ViewRequestStatus.jsp";
    private final String ERROR = "ViewRequestStatus.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession httpSession = request.getSession();
            UserDTO us = (UserDTO) httpSession.getAttribute("loginedUser");
            String studentID = us.getUserID();
            RequestDAO requestDAO = new RequestDAO();
            Date date = new Date();
            requestDAO.updateStatusOutDate(date);
//            System.out.println("updateOutDate " + check);

            requestDAO.getListRequest(studentID);
            List<RequestDTO> listRequest = requestDAO.getListRequest();
            List<UserDTO> listUser = requestDAO.getListUser();
            if (listRequest != null) {
                request.setAttribute("LIST_REQUEST", listRequest);
                request.setAttribute("LIST_USER", listUser);
                url = SUCCESS;
            }else {
                request.setAttribute("ERROR", "Dont have any request !!!");
            }
        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at ViewAllRequestStatus: " + ex.toString());
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
