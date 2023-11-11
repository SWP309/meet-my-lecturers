/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
import javax.sound.midi.SoundbankResource;
import sample.slots.SlotDTO;
import sample.subjects.SubjectDTO;
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;

/**
 *
 * @author CHIBAO
 */
public class ViewTimetableServlet extends HttpServlet { 
    
    public final String ERROR = "request.jsp";
    public final String SUCCESS = "TimetableView.jsp"; 
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String lecturerID = request.getParameter("txtLecturer");
            String semesterID = request.getParameter("txtSemester");
            System.out.println(semesterID);
            TimetableDAO timetableDAO = new TimetableDAO();
            timetableDAO.getListTimetables(lecturerID);
            List<TimetableDTO> timetables = timetableDAO.getTimetables();
            List<SubjectDTO> subjects = timetableDAO.getSubjects();
            List<SlotDTO> slots = timetableDAO.getSlots();
            System.out.println(semesterID);
            if (timetables != null) {
                System.out.println(timetables.toString());
                request.setAttribute("TB_TIMETABLES", timetables); 
                request.setAttribute("TB_SUBJECTS", subjects);
                request.setAttribute("TB_SLOTS", slots);
                url = SUCCESS;
            } else {
                request.setAttribute("TB_MESSAGE", "No line matched!!Please try checking again LecturerID at View All Lecturer at the top!!");
            }
        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at ViewTimetableServlet: " + ex.toString());
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
