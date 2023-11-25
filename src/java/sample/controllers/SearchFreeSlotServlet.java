/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.major.MajorDAO;
import sample.users.Top3StudentDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

public class SearchFreeSlotServlet extends HttpServlet {

    private final String SUCCESS = "StudentHome_1.jsp";
    private final String ERROR = "StudentHome_1.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO dao = new UserDAO();
            List<Top3StudentDTO> listTop3 = dao.GetlistTop3();
            if (listTop3 != null) {
                request.setAttribute("LIST_TOP3", listTop3);
            }
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String subjectCode = request.getParameter("txtSubjectCode");
            String lecturerID = request.getParameter("txtLecturerID");
            String lecturerName = request.getParameter("txtLecturerName");
            int mode = Integer.parseInt(request.getParameter("txtMode"));
            System.out.println(subjectCode);
            System.out.println(lecturerName);
            System.out.println(lecturerID);
            System.out.println(mode);
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            Date date = new Date();
            freeSlotsDAO.updateStatusOutDate(date);

            freeSlotsDAO.getFreeSlotBySubjectAndLecID(subjectCode, lecturerID, us.getUserID());
            freeSlotsDAO.getFreeSlotByLecName(lecturerName, subjectCode, us.getUserID());

            List<FreeSlotsDTO> freeSlotBySubjectAndLecID = freeSlotsDAO.getFreeSlotBySubjectAndLecID();
            List<FreeSlotsDTO> freeSlotByLecturerName = freeSlotsDAO.getFreeSlotByLecName();
            MajorDAO majorDAO = new MajorDAO();

            if (freeSlotBySubjectAndLecID != null) {
                for (FreeSlotsDTO freeSlotsDTO : freeSlotBySubjectAndLecID) {
                    if (!majorDAO.select(freeSlotsDTO.getLecturerID()).isEmpty()) {
                        freeSlotsDTO.setListMajor(majorDAO.select(freeSlotsDTO.getLecturerID()));
                    }
                }
            }
            if (freeSlotByLecturerName != null) {
                for (FreeSlotsDTO freeSlotsDTO : freeSlotByLecturerName) {
                    if (!majorDAO.select(freeSlotsDTO.getLecturerID()).isEmpty()) {
                        freeSlotsDTO.setListMajor(majorDAO.select(freeSlotsDTO.getLecturerID()));
                    }
                }
            }

            if (subjectCode == null && lecturerID == null && lecturerName == null && (mode == 2 || mode == 1)) {
                freeSlotsDAO.getFreeSlotByMode(mode, us.getUserID());
                List<FreeSlotsDTO> freeSlotByMode = freeSlotsDAO.getFreeSlotByMode();
                if (freeSlotByMode != null) {
                    for (FreeSlotsDTO freeSlotsDTO : freeSlotByMode) {
                        if (!majorDAO.select(freeSlotsDTO.getLecturerID()).isEmpty()) {
                            request.setAttribute("FREESLOT_BY_MODE", freeSlotByMode);
                            freeSlotsDTO.setListMajor(majorDAO.select(freeSlotsDTO.getLecturerID()));
                        }
                    }
                } else {
                    request.setAttribute("ERROR", "Dont have any slots in this time !!!");
                }
            } else {
                if (freeSlotBySubjectAndLecID != null || freeSlotByLecturerName != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT_AND_LECID", freeSlotBySubjectAndLecID);
                    request.setAttribute("FREESLOT_BY_LECTURER_NAME", freeSlotByLecturerName);
                    url = SUCCESS;
                } else {
                    request.setAttribute("ERROR", "Dont have any slots in this time !!!");
                }
            }

        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            log("Error at ViewAllRequestStatus: " + ex.toString());
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
