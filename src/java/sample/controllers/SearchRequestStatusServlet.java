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

public class SearchRequestStatusServlet extends HttpServlet {

    private final String SUCCESS = "ViewRequestStatus.jsp";
    private final String ERROR = "ViewRequestStatus.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String subjectCode = request.getParameter("txtSubjectCode");
            String txtRequestStatus = request.getParameter("txtRequestStatus");
            RequestDAO requestDAO = new RequestDAO();
            int status = 3;
            if (txtRequestStatus.equals("Accepted")) {
                status = 1;
            } else if (txtRequestStatus.equals("Declined")) {
                status = 0;
            } else if (txtRequestStatus.equals("InProgress")) {
                status = 2;
            }
            if (status == 0 || status == 1 || status == 2) {
                if (subjectCode.isEmpty()) {
                    requestDAO.getRequestByStatus(us.getUserID(), status);
                    List<RequestDTO> requestByStatus = requestDAO.getRequestByStatus();
                    List<UserDTO> userByStatus = requestDAO.getUserByStatus();
                    if (requestByStatus != null) {
                        request.setAttribute("REQUEST_BY_STATUS", requestByStatus);
                        request.setAttribute("USER_BY_STATUS", userByStatus);
                        url = SUCCESS;
                    }
                } else {
                    requestDAO.getRequestBySubCodeAndStatus(us.getUserID(), subjectCode, status);
                    List<RequestDTO> requestBySubCodeAndStatus = requestDAO.getRequestBySubCodeAndStatus();
                    List<UserDTO> userBySubCodeAndStatus = requestDAO.getUserBySubCodeAndStatus();
                    if (requestBySubCodeAndStatus != null) {
                        request.setAttribute("REQUEST_BY_SUBCODE_AND_STATUS", requestBySubCodeAndStatus);
                        request.setAttribute("USER_BY_SUBCODE_AND_STATUS", userBySubCodeAndStatus);
                        url = SUCCESS;
                    }
                }
            } else {
                if (subjectCode.isEmpty()) {
                    requestDAO.getAllRequest(us.getUserID());
                    List<RequestDTO> requestList = requestDAO.getAllRequest();
                    List<UserDTO> user = requestDAO.getAllUser();
                    if (requestList != null) {
                        request.setAttribute("ALL_REQUEST", requestList);
                        request.setAttribute("ALL_USER", user);
                        url = SUCCESS;
                    }
                } else {
                    requestDAO.getAllRequestBySubCode(us.getUserID(), subjectCode);
                    List<RequestDTO> requestBySubCode = requestDAO.getAllRequestBySubCode();
                    List<UserDTO> userBySubCode = requestDAO.getAllUserBySubCode();
                    if (requestBySubCode != null) {
                        request.setAttribute("ALL_REQUEST_BY_SUBCODE", requestBySubCode);
                        request.setAttribute("ALL_USER_BY_SUBCODE", userBySubCode);
                        url = SUCCESS;
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at SearchRequestStatusServlet: " + ex.toString());
        }  finally {
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
