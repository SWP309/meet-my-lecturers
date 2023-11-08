/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDTO;
import sample.viewCreatedSlot.ViewCreatedSlotDAO;
import sample.viewCreatedSlot.ViewCreatedSlotDTO;

/**
 *
 * @author PC
 */
public class UpdateFSlotController extends HttpServlet {

    private static final String ERROR = "CreatedSlotView.jsp";
    private static final String SUCCESS = "CreatedSlotView.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        boolean flag = true;
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            ViewCreatedSlotDAO dao = new ViewCreatedSlotDAO();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            String subjectCode = request.getParameter("subjectCode");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String freeSlotID = request.getParameter("freeSlotID");
            String semesterID = request.getParameter("semesterID");

            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            Date startDate = simpleDateFormat.parse(startTime);
            Date endDate = simpleDateFormat.parse(endTime);
            System.out.println(startDate);
            System.out.println(endDate);
            boolean checkStartTimeDuplicateFS = dao.checkTimeDuplicateInFreeSlot(us.getUserEmail(), startDate);
            boolean checkEndTimeDuplicateFS = dao.checkTimeDuplicateInFreeSlot(us.getUserEmail(), endDate);
            System.out.println(checkEndTimeDuplicateFS);
            if (checkStartTimeDuplicateFS == false || checkEndTimeDuplicateFS == false) {
                flag = false;
                request.setAttribute("ERROR","- The time you entered overlaps with time of created FREESLOT!!! ");
            }
            if (flag) {
                if (endDate.after(startDate) && (endDate.getTime() - startDate.getTime()) >= 15 * 60 * 1000) {
                    ViewCreatedSlotDTO dto = new ViewCreatedSlotDTO();
                    dto.setStartTime(startTime);
                    dto.setEndTime(endTime);
                    dto.setSubjectCode(subjectCode);
                    dto.setFreeSlotID(freeSlotID);
                    dto.setSemesterID(semesterID);
                    if (freeSlotID != null) {
                        boolean checkUpdate = dao.update(dto);
                        List<ViewCreatedSlotDTO> listbooking = dao.GetlistCreatedSlot(us.getUserEmail()); // Thay thế bằng cách lấy danh sách cập nhật từ cơ sở dữ liệu hoặc nguồn dữ liệu khác
                        request.setAttribute("LIST_CREATED_SLOT", listbooking);
                        if (checkUpdate) {
                            System.out.println(checkUpdate);
                            url = SUCCESS;
                            if (listbooking == null || listbooking.isEmpty()) {
//                        System.out.println("list booking is null");
                                request.setAttribute("ERROR", "LIST_CREATED_SLOT is null. Do not have any things to show");
                            }
                        }
                    }
                } else {
                    request.setAttribute("ERROR", "Start Time must be less than End Time and The total study duration should be at least 15 minutes.");

                }
            }

        } catch (Exception e) {
            log("Error at UpdateController: " + e.toString());
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
