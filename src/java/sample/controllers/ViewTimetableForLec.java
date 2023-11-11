
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.slots.SlotDTO;
import sample.subjects.SubjectDTO;
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;
import sample.users.UserDTO;

public class ViewTimetableForLec extends HttpServlet {

    public final String ERROR = "CreatedSlotView.jsp";
    public final String SUCCESS = "ViewTimetableForLec.jsp"; 
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("loginedUser");
            String lecturerID = userDTO.getUserID();
            TimetableDAO timetableDAO = new TimetableDAO();
            timetableDAO.getListTimetables(lecturerID);
            List<TimetableDTO> timetables = timetableDAO.getTimetables();
            for (TimetableDTO timetable : timetables) {
                System.out.println("Timetable List: ");
                System.out.println(timetable.getLecturerID());
            }
            List<SubjectDTO> subjects = timetableDAO.getSubjects();
            for (SubjectDTO subject : subjects) {
                System.out.println("");
            }
            List<SlotDTO> slots = timetableDAO.getSlots();
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
            log("Error at ViewTimetableForLec: " + ex.toString());
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
