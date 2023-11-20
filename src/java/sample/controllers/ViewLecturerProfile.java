/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
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
import sample.major.MajorDAO;
import sample.major.MajorDTO;
import sample.slots.SlotDTO;
import sample.subjects.SubjectDTO;
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author CHIBAO
 */
public class ViewLecturerProfile extends HttpServlet {

    private final String SUCCESS = "LecturerProfile.jsp";
    private final String ERROR = "LecturerProfile.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO userDAO = new UserDAO();
            HttpSession session = request.getSession();
            UserDTO lecturer = (UserDTO) session.getAttribute("loginedUser");
            String lecturerID = lecturer.getUserID();
            request.setAttribute("USER", lecturer);
            MajorDAO majorDAO = new MajorDAO();
            
            
            List<MajorDTO> majorsByLecID = majorDAO.select(lecturerID);
            if (majorsByLecID != null) {
                request.setAttribute("LIST_MAJORS", majorsByLecID);
                url = SUCCESS;
            } else {
                request.setAttribute("MAJOR_ERROR", "You have no major in the system. Please add your major.");
            }

            TimetableDAO timetableDAO = new TimetableDAO();
            timetableDAO.getListTimetables(lecturerID);
            List<TimetableDTO> timetables = timetableDAO.getTimetables();
            List<SubjectDTO> subjects = timetableDAO.getSubjects();
            List<SlotDTO> slots = timetableDAO.getSlots();

            if (timetables != null) {
                request.setAttribute("LIST_TIMETABLES", timetables);
                request.setAttribute("TB_SUBJECTS", subjects);
                request.setAttribute("TB_SLOTS", slots);
                url = SUCCESS;
            } else {
                request.setAttribute("TIMETABLE_MESSAGE", "You have no timetable. Please import your Timetable.");
            }

        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at ViewLecturerProfile: " + ex.toString());
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ViewLecturerProfile.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ViewLecturerProfile.class.getName()).log(Level.SEVERE, null, ex);
        }
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
