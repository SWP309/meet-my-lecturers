
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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

public class ViewRequestServlet extends HttpServlet {
    private final String SUCCESS = "ViewRequest.jsp";
    private final String ERROR = "CreatedSlotView.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("loginedUser");
            System.out.println("LecturerID: " + userDTO.getUserID());
            RequestDAO requestDAO = new RequestDAO();
            requestDAO.getRequest(userDTO.getUserID());
            List<RequestDTO> requests = requestDAO.getListRequests();
            System.out.println(requests);
            for (RequestDTO request1 : requests) {
                System.out.println(request1.getStudentID() + request1.getDescription());
            }
            List<UserDTO> users = requestDAO.getListUsers();
            if (requests != null) {
                    request.setAttribute("LIST_REQUESTS", requests);
                    request.setAttribute("LIST_REQUESTS_USERS", users);
                    url = SUCCESS;
            } else {
                request.setAttribute("VIEW_REQUEST_MESSAGE", "No request!!!");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at ViewRequestServlet: " + ex.toString());
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
