/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.subjects;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.majors.MajorsDAO;
import sample.majors.MajorsDTO;

/**
 *
 * @author Minh Khang
 */
public class UpdateSubject extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int rs = 0;
            String url = "MainController?action=ManageServlet";
            String subjectCode = request.getParameter("txtsubject");
            String Description = request.getParameter("txtdescription");
            System.out.println("Subject code: " + subjectCode);
            System.out.println("Des: " + Description);
            SubjectDTO subject = new SubjectDTO(subjectCode, Description);
            ArrayList<MajorsDTO> list = MajorsDAO.getAllMajors();
            MajorsDTO major = null;
            for (MajorsDTO ob : list) {
                if (subjectCode.equalsIgnoreCase(ob.getSubjectCode())) {
                    major = ob;
                }
            }
            System.out.println("Major out for: " + major);
            if (major == null) {
                rs = SubjectDAO.updateSubject(subject);
                System.out.println(subjectCode);
                System.out.println(Description);
                if (rs > 0) {
                    request.setAttribute("RemoveStatus", "Update successfully!");
                } else {
                    request.setAttribute("RemoveStatus", "Update failed!");
                }

            } else{
                request.setAttribute("RemoveStatus", "Update fail due to the existed of subject in lecturer's major");
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
