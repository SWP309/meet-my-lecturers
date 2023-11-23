
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.major.MajorDAO;
import sample.major.MajorDTO;
import sample.semester.SemesterDAO;
import sample.users.UserDTO;

/**
 *
 * @author CHIBAO
 */
public class AddMajorServlet extends HttpServlet {
    private final String SUCCESS = "ViewLecturerProfile";
    private final String ERROR = "ViewLecturerProfile";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession httpSession = request.getSession();
            UserDTO us = (UserDTO) httpSession.getAttribute("loginedUser");
            String lecturerID = us.getUserID();
            System.out.println("LecID: " + lecturerID);
            String subjectCode = request.getParameter("txtSubjectCode");
            System.out.println("SubCode: " + subjectCode);
            SemesterDAO sdao = new SemesterDAO();
            System.out.println("Bao dep zai");
            String semesterID = sdao.getCurrentSemester();
            System.out.println("SemesterID: " + semesterID);
            MajorDAO majorDAO = new MajorDAO();
            MajorDTO majorDTO = new MajorDTO(semesterID, lecturerID, subjectCode);
            boolean checkAddMajor = majorDAO.createMajor(majorDTO);
            System.out.println("CheckAdd: " + checkAddMajor);
            if (checkAddMajor) {
                request.setAttribute("ADD_MAJOR_MESSAGE", "Added successfully!!!");
                url = SUCCESS;
            }
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            log("Error at AddMajorServlet: " + ex.toString());
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
