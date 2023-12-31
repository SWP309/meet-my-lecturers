package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;
import sample.semester.SemesterDAO;
import sample.semester.SemesterDTO;
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
            String txtSemesterID = request.getParameter("txtSemesterID");
            RequestDAO requestDAO = new RequestDAO();
            int status = 4;
            if (txtRequestStatus.equals("Accepted")) {
                status = 1;
            } else if (txtRequestStatus.equals("Declined")) {
                status = 0;
            } else if (txtRequestStatus.equals("InProgress")) {
                status = 2;
            } else if (txtRequestStatus.equals("Overdue")) {
                status = 3;
            }

            if (status != 4) {
                if (subjectCode.isEmpty()) {
                    requestDAO.getRequestByStatus(us.getUserID(), status, txtSemesterID);
                    List<RequestDTO> requestByStatus = requestDAO.getRequestByStatus();
                    if (requestByStatus != null) {
                        request.setAttribute("REQUEST_BY_STATUS", requestByStatus);
                        url = SUCCESS;
                    } else {
                        request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                    }
                } else if (!subjectCode.isEmpty()) {
                    requestDAO.getRequestBySubCodeAndStatus(us.getUserID(), subjectCode, status, txtSemesterID);
                    List<RequestDTO> requestBySubCodeAndStatus = requestDAO.getRequestBySubCodeAndStatus();
                    if (requestBySubCodeAndStatus != null) {
                        request.setAttribute("REQUEST_BY_SUBCODE_AND_STATUS", requestBySubCodeAndStatus);
                        url = SUCCESS;
                    } else {
                        request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                    }
                } else {
                    request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                }
            } else {
                if (subjectCode.isEmpty()) {
                    requestDAO.getAllRequest(us.getUserID(), txtSemesterID);
                    List<RequestDTO> requestList = requestDAO.getAllRequest();
                    if (requestList != null) {
                        request.setAttribute("ALL_REQUEST", requestList);
                        url = SUCCESS;
                    } else {
                        request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                    }
                } else if (!subjectCode.isEmpty()) {
                    requestDAO.getAllRequestBySubCode(us.getUserID(), subjectCode, txtSemesterID);
                    List<RequestDTO> requestBySubCode = requestDAO.getAllRequestBySubCode();
                    if (requestBySubCode != null) {
                        request.setAttribute("ALL_REQUEST_BY_SUBCODE", requestBySubCode);
                        url = SUCCESS;
                    } else {
                        request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                    }
                } else {
                    request.setAttribute("ERROR", "Do not have the requests that you have searched !!");
                }
            }
            SemesterDAO list = new SemesterDAO();
            List<SemesterDTO> listSemes = list.select();
            request.setAttribute("ListSemes", listSemes);
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at SearchRequestStatusServlet: " + ex.toString());
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
