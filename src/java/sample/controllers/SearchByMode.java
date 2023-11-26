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

/**
 *
 * @author PC
 */
public class SearchByMode extends HttpServlet {

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
            int mode = Integer.parseInt(request.getParameter("txtMode"));
            System.out.println(mode);
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            MajorDAO majorDAO = new MajorDAO();
            Date date = new Date();
            freeSlotsDAO.updateStatusOutDate(date);
            if (mode == 0) {
                request.setAttribute("ERROR", "Can not search if have not chosen the mode before !!!");
            } else if (mode == 1) {
                freeSlotsDAO.getFreeSlotByMode1(mode, us.getUserID());
                List<FreeSlotsDTO> freeSlotByMode1 = freeSlotsDAO.getFreeSlotByMode1();
                request.setAttribute("FREESLOT_BY_MODE1", freeSlotByMode1);
                if (freeSlotByMode1 != null) {
                    for (FreeSlotsDTO freeSlotsDTO : freeSlotByMode1) {
                        if (!majorDAO.select(freeSlotsDTO.getLecturerID()).isEmpty()) {
                            freeSlotsDTO.setListMajor(majorDAO.select(freeSlotsDTO.getLecturerID()));
                            url = SUCCESS;
                        }
                    }
                } else {
                    request.setAttribute("ERROR", "Dont have any slots in this time !!!");
                }
            } else if (mode == 2) {
                freeSlotsDAO.getFreeSlotByMode2(mode, us.getUserID());
                List<FreeSlotsDTO> freeSlotByMode2 = freeSlotsDAO.getFreeSlotByMode2();
                request.setAttribute("FREESLOT_BY_MODE2", freeSlotByMode2);
                if (freeSlotByMode2 != null) {
                    for (FreeSlotsDTO freeSlotsDTO : freeSlotByMode2) {
                        if (!majorDAO.select(freeSlotsDTO.getLecturerID()).isEmpty()) {
                            freeSlotsDTO.setListMajor(majorDAO.select(freeSlotsDTO.getLecturerID()));
                            url = SUCCESS;
                        }
                    }
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
