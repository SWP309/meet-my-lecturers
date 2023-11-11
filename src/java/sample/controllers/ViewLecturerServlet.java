
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.semester.SemesterDAO;
import sample.semester.SemesterDTO;
import sample.subjects.SubjectDAO;
import sample.subjects.SubjectDTO;

import sample.users.UserDAO;
import sample.users.UserDTO;

public class ViewLecturerServlet extends HttpServlet {

    private final String ERROR = "request.jsp";
    private final String SUCCESS = "request.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO userDAO = new UserDAO();
            userDAO.getListLecturers();
            List<UserDTO> lecturers = userDAO.getLecturers();
            SemesterDAO semesterDAO = new SemesterDAO();
            semesterDAO.getListSemesters();
            List<SemesterDTO> semesters = semesterDAO.getSemesters();
            SubjectDAO subjectDAO = new SubjectDAO();
            subjectDAO.getListSubjects();
            List<SubjectDTO> subjects = subjectDAO.getSubjects();
            if (lecturers != null) {
                request.setAttribute("LIST_LECTURERS", lecturers); 
                request.setAttribute("LIST_SEMESTERS", semesters);
                request.setAttribute("LIST_SUBJECTS", subjects);
                url = SUCCESS;
            } else {
                request.setAttribute("MESSAGE", "System has no Lecturer!!!");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at ViewLecturerServlet: " + ex.toString());
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
