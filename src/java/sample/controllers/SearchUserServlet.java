package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.roles.RoleDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

public class SearchUserServlet extends HttpServlet {

    private final String SUCCESS = "ViewUsers.jsp";
    private final String ERROR = "ViewUsers.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String name = request.getParameter("txtName").trim();
            String roleID = request.getParameter("txtRoleID").trim();
            UserDAO userDAO = new UserDAO();
            if (name.isEmpty() && !roleID.isEmpty()) {
                userDAO.getUsersByRoleID(roleID);
                List<UserDTO> usersByRole = userDAO.getUsersByRoleID();
                List<RoleDTO> rolesByID = userDAO.getRolesByRoleID();
                if (usersByRole != null) {
                    request.setAttribute("USERS_BY_ROLEID", usersByRole);
                    request.setAttribute("ROLES_BY_ID", rolesByID);
                    url = SUCCESS;
                }
            } else if (!name.isEmpty() && roleID.isEmpty()) {
                userDAO.getUsersByName(name);
                List<UserDTO> usersByName = userDAO.getUsersByName();
                List<RoleDTO> rolesByName = userDAO.getRolesByName();
                if (usersByName != null) {
                    request.setAttribute("USERS_BY_NAME", usersByName);
                    request.setAttribute("ROLES_BY_NAME", rolesByName);
                    url = SUCCESS;
                }
            } else if (!name.isEmpty() && !roleID.isEmpty()) {
                userDAO.getUsersByNameAndRoleID(name, roleID);
                List<UserDTO> usersByNameAndRole = userDAO.getUsersByNameAndRoleID();
                List<RoleDTO> rolesByNameAndRole = userDAO.getRolesByNameAndRoleID();
                if (usersByNameAndRole != null) {
                    request.setAttribute("USERS_BY_NAME_AND_ID", usersByNameAndRole);
                    request.setAttribute("ROLES_BY_NAME_AND_ID", rolesByNameAndRole);
                    url = SUCCESS;
                }
            } else {
                userDAO.getUsersFunc();
                List<UserDTO> users = userDAO.getUsers();
                List<RoleDTO> roles = userDAO.getRoles();
                if (users != null) {
                    request.setAttribute("USERS", users);
                    request.setAttribute("ROLES", roles);
                    url = SUCCESS;
                } else {
                    request.setAttribute("VIEW_USERS_MESSAGE", "The system has no users!!!");
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at SearchUserServlet: " + ex.toString());
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
        request.setCharacterEncoding("UTF-8"); 
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
