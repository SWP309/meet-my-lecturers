/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.bookings.BookingDAO;
import sample.bookings.BookingDTO;
import sample.freeslots.FreeSlotsDAO;
import sample.requests.RequestDAO;
import sample.requests.RequestDTO;
import sample.users.UserDTO;

/**
 *
 * @author CHIBAO
 */
public class AcceptAllRequest extends HttpServlet {

    private final String SUCCESS = "ViewRequest.jsp";
    private final String ERROR = "ViewRequest.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            RequestDAO requestDAO = new RequestDAO();
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            BookingDAO bookingDAO = new BookingDAO();

            List<RequestDTO> listRequest = null;

            if (session.getAttribute("LIST_REQUESTS") != null) {
                listRequest = (List<RequestDTO>) session.getAttribute("LIST_REQUESTS");
            } else if (session.getAttribute("SEARCH_REQUEST_BY_ST_ET") != null) {
                listRequest = (List<RequestDTO>) session.getAttribute("SEARCH_REQUEST_BY_ST_ET");
            } else if (session.getAttribute("SEARCH_REQUEST_BY_ALL") != null) {
                listRequest = (List<RequestDTO>) session.getAttribute("SEARCH_REQUEST_BY_ALL");
            } else if (session.getAttribute("SEARCH_REQUEST_BY_SUBJECT") != null) {
                listRequest = (List<RequestDTO>) session.getAttribute("SEARCH_REQUEST_BY_SUBJECT");
            } else if (session.getAttribute("SEARCH_REQUEST_BY_NULL") != null) {
                listRequest = (List<RequestDTO>) session.getAttribute("SEARCH_REQUEST_BY_NULL");
            }
            for (RequestDTO requestDTO : listRequest) {
                System.out.println("");
            }

            String subject = "";
            if (listRequest != null) {
                for (RequestDTO requestDTO : listRequest) {
                    if (freeSlotsDAO.checkSubjectFS(requestDTO.getFreeSlotID()) != null) {

                        subject = (freeSlotsDAO.checkSubjectFS(requestDTO.getFreeSlotID())).trim();
                        if (requestDTO.getSubjectCode().trim().equals(subject)) {
//                            requestDAO.acceptARequest(requestDTO.getRequestID());
//                            requestDAO.updateStatusDuplicateAcceptedRequest(requestDTO.getStudentID());                            
                            bookingDAO.BookFSlot(new BookingDTO(requestDTO.getFreeSlotID(), requestDTO.getStudentID()));
                            url = SUCCESS;
                        } else {
                            requestDAO.deleteARequest(requestDTO.getRequestID());
                            url = SUCCESS;
                        }

                    } else {
                        requestDAO.acceptARequest(requestDTO.getRequestID(),requestDTO.getFreeSlotID());
                        freeSlotsDAO.updateSubject(requestDTO.getSubjectCode(), requestDTO.getFreeSlotID());
                        requestDAO.updateStatusDuplicateAcceptedRequest(requestDTO.getStudentID());
                        System.out.println(requestDTO.getFreeSlotID() + " " + requestDTO.getStudentID());
                        bookingDAO.BookFSlot(new BookingDTO(requestDTO.getFreeSlotID(), requestDTO.getStudentID()));
                        url = SUCCESS;

                    }

                }
            }

            request.getRequestDispatcher(url).forward(request, response);

        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
