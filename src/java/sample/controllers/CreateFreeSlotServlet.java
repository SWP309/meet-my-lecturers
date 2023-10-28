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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.users.UserDTO;
import sample.utils.DBUtils;

/**
 *
 * @author W10(hiep-tm)
 */
@WebServlet(name = "CreateFreeSlotServlet", urlPatterns = {"/newfreeslot"})
public class CreateFreeSlotServlet extends HttpServlet {

    private static final String ERROR = "create-freeSlot.jsp";
    private static final String SUCCESS = "CreatedSlotController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = ERROR;
        boolean flag = true;
        try {
            HttpSession session = request.getSession();
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();

            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String semesterID=request.getParameter("txtSemesterID");
            String subjectCode = request.getParameter("txtSubjectCode");
            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");

            String password = request.getParameter("txtPassword").trim();
            if (password.isEmpty()) {
                password = null; // Chuyển chuỗi trống thành giá trị null
            }

            int capacity = Integer.parseInt(request.getParameter("txtCapacity"));
            if (capacity <= 0) {
                flag = false;
                out.println("<p style=\"color: red\">The number of student can join this slot must be greater than 0.</p>");
                out.close();
            }

            String meetLink = request.getParameter("txtMeetLink");
            boolean exists = freeSlotsDAO.checkDuplicateGGMeet(meetLink);
            System.out.println(exists);
            if (exists) {
                flag = false;
                out.println("<p style=\"color: red\">The gg meet link is duplicated.</p>");
                out.close();
            }

            String option = request.getParameter("txtOption");

            int count = Integer.parseInt(request.getParameter("txtCount"));
            String lecturerID = us.getUserID();
            boolean status = true;

            if (flag) {
                boolean checkCreated = false;
                for (int i = 1; i <= count + 1; i++) {
                    FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(subjectCode, startTime, endTime, password, capacity, meetLink, count, lecturerID, status,semesterID);
                    checkCreated = freeSlotsDAO.createFreeSlot(freeSlotsDTO);

                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date sTime = simpleDateFormat.parse(freeSlotsDTO.getStartTime());
                    Date eTime = simpleDateFormat.parse(freeSlotsDTO.getEndTime());
                    if (option.equals("DA")) {
                        Date sNextDay = DBUtils.getNextDate(sTime);
                        startTime = simpleDateFormat.format(sNextDay);
                        freeSlotsDTO.setStartTime(startTime);
                        Date eNextDay = DBUtils.getNextDate(eTime);
                        endTime = simpleDateFormat.format(eNextDay);
                        freeSlotsDTO.setEndTime(endTime);
                    }
                    if (option.equals("DW")) {
                        Date sNextWeek = DBUtils.getNextWeek(sTime);
                        startTime = simpleDateFormat.format(sNextWeek);
                        freeSlotsDTO.setStartTime(startTime);
                        Date eNextWeek = DBUtils.getNextWeek(eTime);
                        endTime = simpleDateFormat.format(eNextWeek);
                        freeSlotsDTO.setEndTime(endTime);
                    }
                }
                if (checkCreated) {
                    url = SUCCESS;
                }
            }
        } catch (SQLException ex) {
            log("Error at CreateFreeSlotServlet" + ex.toString());
        } catch (ParseException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
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
