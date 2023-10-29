/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;

public class SearchFreeSlotServlet extends HttpServlet {
    private final String SUCCESS = "StudentHome_1.jsp";
    private final String ERROR = "StudentHome_1.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String subjectCode = request.getParameter("txtSubjectCode");
            String lecturerID = request.getParameter("txtUserID");
            String name = request.getParameter("txtUserName");
            String semester = request.getParameter("txtSemesterID");
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            if (!subjectCode.isEmpty() && lecturerID.isEmpty() && name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubjectCode(subjectCode);
                List<FreeSlotsDTO> freeSlotBySubject = freeSlotsDAO.getFreeSlotBySubjectCode();
                if (freeSlotBySubject != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT", freeSlotBySubject);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && !lecturerID.isEmpty() && name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotByLecturerID(lecturerID);
                List<FreeSlotsDTO> freeSlotByLecturerID = freeSlotsDAO.getFreeSlotByLecturerID();
                if (freeSlotByLecturerID != null) {
                    request.setAttribute("FREESLOT_BY_LECTURERID", freeSlotByLecturerID);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && lecturerID.isEmpty() && !name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotByLecName(name);
                List<FreeSlotsDTO> freeSlotByLecName = freeSlotsDAO.getFreeSlotByLecName();
                if (freeSlotByLecName != null) {
                    request.setAttribute("FREESLOT_BY_LECNAME", freeSlotByLecName);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && lecturerID.isEmpty() && name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySemesterID(semester);
                List<FreeSlotsDTO> freeSlotBySemesterID = freeSlotsDAO.getFreeSlotBySemesterID();
                if (freeSlotBySemesterID != null) {
                    request.setAttribute("FREESLOT_BY_SEMESTERID", freeSlotBySemesterID);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && !lecturerID.isEmpty() && name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubjectAndLecID(subjectCode, lecturerID);
                List<FreeSlotsDTO> freeSlotBySubjectAndLecID = freeSlotsDAO.getFreeSlotBySubjectAndLecID();
                if (freeSlotBySubjectAndLecID != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT_AND_LECID", freeSlotBySubjectAndLecID);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && lecturerID.isEmpty() && !name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubjectAndLecName(subjectCode, name);
                List<FreeSlotsDTO> freeSlotBySubjectAndLecName = freeSlotsDAO.getFreeSlotBySubjectAndLecName();
                if (freeSlotBySubjectAndLecName != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT_AND_LECNAME", freeSlotBySubjectAndLecName);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && lecturerID.isEmpty() && name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubjectAndSemester(subjectCode, semester);
                List<FreeSlotsDTO> freeSlotBySubjectAndSemester = freeSlotsDAO.getFreeSlotBySubjectAndSemester();
                if (freeSlotBySubjectAndSemester != null) {
                    request.setAttribute("FREESLOT_BY_SUBJECT_AND_SEMESTER", freeSlotBySubjectAndSemester);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && !lecturerID.isEmpty() && name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotByLecIDAndSemester(lecturerID, semester);
                List<FreeSlotsDTO> freeSlotByLecIDAndSemester = freeSlotsDAO.getFreeSlotByLecIDAndSemester();
                if (freeSlotByLecIDAndSemester != null) {
                    request.setAttribute("FREESLOT_BY_LECID_AND_SEMESTER", freeSlotByLecIDAndSemester);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && lecturerID.isEmpty() && !name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotByLecNameAndSemester(name, semester);
                List<FreeSlotsDTO> freeSlotByLecNameAndSemester = freeSlotsDAO.getFreeSlotByLecNameAndSemester();
                if (freeSlotByLecNameAndSemester != null) {
                    request.setAttribute("FREESLOT_BY_LECNAME_AND_SEMESTER", freeSlotByLecNameAndSemester);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && !lecturerID.isEmpty() && name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubCodeAndLecIDAndSemester(subjectCode, lecturerID, semester);
                List<FreeSlotsDTO> freeSlotBySubCodeAndLecIDAndSemester = freeSlotsDAO.getFreeSlotBySubCodeAndLecIDAndSemester();
                if (freeSlotBySubCodeAndLecIDAndSemester != null) {
                    request.setAttribute("FREESLOT_BY_SUBCODE_AND_LECID_AND_SEMESTER", freeSlotBySubCodeAndLecIDAndSemester);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && lecturerID.isEmpty() && !name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotBySubCodeAndLecNameAndSemester(subjectCode, name, semester);
                List<FreeSlotsDTO> freeSlotBySubCodeAndLecNameAndSemester = freeSlotsDAO.getFreeSlotBySubCodeAndLecNameAndSemester();
                if (freeSlotBySubCodeAndLecNameAndSemester != null) {
                    request.setAttribute("FREESLOT_BY_SUBCODE_AND_LECNAME_AND_SEMESTER", freeSlotBySubCodeAndLecNameAndSemester);
                    url = SUCCESS;
                }
            } else if (!subjectCode.isEmpty() && !lecturerID.isEmpty() && !name.isEmpty() && !semester.isEmpty()) {
                freeSlotsDAO.getFreeSlotByAll(subjectCode, lecturerID, name, semester);
                List<FreeSlotsDTO> freeSlotByAll = freeSlotsDAO.getFreeSlotByAll();
                if (freeSlotByAll != null) {
                    request.setAttribute("FREESLOT_BY_ALL", freeSlotByAll);
                    url = SUCCESS;
                }
            } else if (subjectCode.isEmpty() && lecturerID.isEmpty() && name.isEmpty() && semester.isEmpty()) {
                freeSlotsDAO.getFreeSlot();
                List<FreeSlotsDTO> freeSlot = freeSlotsDAO.getFreeSlotList();
                if (freeSlot != null) {
                    request.setAttribute("FREESLOT", freeSlot);
                    url = SUCCESS;
                } else {
                    request.setAttribute("SEARCH_FREESLOT_MESSAGE", "The system has no freeslot that meet your requirement!!!");
                }
            } 
        } catch (ClassNotFoundException | SQLException ex) {
            log("Error at SearchFreeSlotServlet: " + ex.toString());
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
