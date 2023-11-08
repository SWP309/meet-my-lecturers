package sample.controllers;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotsDAO;
import sample.users.UserDTO;
import sample.viewCreatedSlot.ViewCreatedSlotDAO;
import sample.viewCreatedSlot.ViewCreatedSlotDTO;

@WebServlet(name = "CreatedSlotController", urlPatterns = {"/CreatedSlotController"})
public class CreatedSlotController extends HttpServlet {

    private static final String ERROR = "CreatedSlotView.jsp";
    private static final String SUCCESS = "CreatedSlotView.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO us = (UserDTO) session.getAttribute("loginedUser");
            ViewCreatedSlotDAO dao = new ViewCreatedSlotDAO();
            int listCountPage = dao.CountPage(us.getUserEmail());
            request.setAttribute("COUNT_PAGE", listCountPage);
            List<ViewCreatedSlotDTO> listCreatedSlot = dao.GetlistCreatedSlotByCount(us.getUserEmail(), 0);
            System.out.println(us.getUserEmail());
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();

            Date date = new Date();
            freeSlotsDAO.updateStatusOutDate(date);
            if (listCreatedSlot.size() > 0) {
                request.setAttribute("LIST_CREATED_SLOT", listCreatedSlot);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at SearchController: " + e.toString());
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
