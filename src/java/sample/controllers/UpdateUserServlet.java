
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.users.UserDAO;
import sample.users.UserDTO;

public class UpdateUserServlet extends HttpServlet {
    
    private final String SUCCESS = "SearchUserServlet";
    private final String ERROR = "SearchUserServlet";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userName = request.getParameter("txtUserName");
            String userEmail = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String userStatus = request.getParameter("txtStatus");
            System.out.println(userStatus);
            boolean check = Boolean.parseBoolean(userStatus);
            System.out.println("Check: " + check);
            String userID = request.getParameter("txtUserID");
            UserDAO userDAO = new UserDAO();
            UserDTO userDTO = new UserDTO(userID, userName, userEmail, check, "", password);
            boolean checkUpdate;
                checkUpdate = userDAO.updateAUser(userDTO);
            if(checkUpdate) {
                url = SUCCESS;
            }
        } catch (ClassNotFoundException | SQLException ex) {
                log("Error at UpdateUserServlet: " + ex.toString());
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
