
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
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


public class SearchRequestForLec extends HttpServlet {
    private final String SUCCESS = "ViewRequest.jsp";
    private final String ERROR = "ViewRequest.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO lecturer = (UserDTO) session.getAttribute("loginedUser");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String subjectCode = request.getParameter("txtSubjectCode");
            String semesterID = request.getParameter("txtSemesterID");
            RequestDAO requestDAO = new RequestDAO();
            
            if (!startTime.isEmpty() && !endTime.isEmpty() && subjectCode.isEmpty()) {
                
                List<RequestDTO> searchByStEt = requestDAO.searchRequestViewByStEt(startTime, endTime, lecturer.getUserID(), semesterID);
                
                if (searchByStEt != null) {
                    request.setAttribute("SEARCH_REQUEST_BY_ST_ET", searchByStEt);
                    session.setAttribute("SEARCH_REQUEST_BY_ST_ET", searchByStEt);
                    url = SUCCESS;
                }
            } else if (!startTime.isEmpty() && !endTime.isEmpty() && !subjectCode.isEmpty()) {
                List<RequestDTO> searchByAll = requestDAO.searchRequestByAll(subjectCode, startTime, endTime, lecturer.getUserID(), semesterID);
                if (searchByAll != null) {
                    request.setAttribute("SEARCH_REQUEST_BY_ALL", searchByAll);
                    session.setAttribute("SEARCH_REQUEST_BY_ALL", searchByAll);
                    url = SUCCESS;
                }

            } else if (startTime.isEmpty() && endTime.isEmpty() && !subjectCode.isEmpty()) {
                
                List<RequestDTO> searchBySubjectCode = requestDAO.searchRequestBySubjectCode(subjectCode, lecturer.getUserID(), semesterID);
                if (searchBySubjectCode != null) {
                    request.setAttribute("SEARCH_REQUEST_BY_SUBJECT", searchBySubjectCode);
                    session.setAttribute("SEARCH_REQUEST_BY_SUBJECT", searchBySubjectCode);
                    System.out.println(subjectCode);
                        url = SUCCESS;
                }

            } else if (startTime.isEmpty() && endTime.isEmpty() && subjectCode.isEmpty()) {
                
                List<RequestDTO> searchByNull = requestDAO.searchRequestByNull(lecturer.getUserID(), semesterID);           
                if (searchByNull != null) {
                    request.setAttribute("SEARCH_REQUEST_BY_NULL", searchByNull);
                    session.setAttribute("SEARCH_REQUEST_BY_NULL", searchByNull);
                    url = SUCCESS;
                }
                
            } else {
                request.setAttribute("SEARCH_FREESLOT_MESSAGE", "The system has no request that meet your requirement!!!");
            }
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            log("Error at SearchRequestForLec: " + ex.toString());
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
