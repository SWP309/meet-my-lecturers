
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;

public class CreateRequestServlet extends HttpServlet {

    private static final String ERROR = "request.jsp";
    private static final String SUCCESS = "StudentHome.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try{
            String lecturer = request.getParameter("txtLecturer");
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            String description = request.getParameter("txtDescription");
            System.out.println(lecturer);
            System.out.println(subjectCode);
            System.out.println(startTime);
            System.out.println(endTime);
            System.out.println(description);
            RequestDAO requestDAO = new RequestDAO();
            RequestDTO requestDTO = new RequestDTO(false, subjectCode,   
                    startTime, endTime, description, "SE173289", lecturer); 
            System.out.println(requestDTO.getStudentID() + requestDTO.getSubjectCode());
            boolean checkCreated = requestDAO.createARequest(requestDTO);
            System.out.println("Check: " + checkCreated);
            if (checkCreated) {
                url = SUCCESS;
            }
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            log("Error at CreateRequestServlet" + ex.toString());
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
