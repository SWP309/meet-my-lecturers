/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import static java.awt.SystemColor.text;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDTO;

/**
 *
 * @author W10
 */
public class SendEMailServlet extends HttpServlet {

    private static final String ERROR = "send-email.jsp";
    private static final String SUCCESS = "CreatedSlotController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, AddressException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
//        boolean checkSend = false;
        final String from = "meet.my.lecturers.fpt.edu@gmail.com";
        final String password = "pxgiqlcbynyelaeu";
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");//TLS
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        String recipientList = request.getParameter("txtRecipient");
        String[] recipients = recipientList.split(";");
        List<InternetAddress> addresses = new ArrayList<>();
        for (String recipient : recipients) {
            addresses.add(new InternetAddress(recipient));
        }

        HttpSession sessionn = request.getSession();
        UserDTO us = (UserDTO) sessionn.getAttribute("loginedUser");
        String lecturerName = us.getUserName();
        String lecturerEmail = us.getUserEmail();

        String subjectCode = request.getParameter("txtSubjectCode");
        String startTime = request.getParameter("txtStartTime");
        String endTime = request.getParameter("txtEndTime");
        String fslotPassword = request.getParameter("txtPassword");
        String message = request.getParameter("txtMessage");

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.addRecipients(Message.RecipientType.TO, addresses.toArray(new InternetAddress[0]));
            msg.setSubject("Thong tin cua mon hoc : " + subjectCode + " vao luc : " + startTime + " va ket thuc luc : " + endTime);
//            msg.setText("Ma truy cap Fslot cua ban : " + fslotPassword + "\n"
//                    + " FSlot nay la cua : " + lecturerName + "   Email : " + lecturerEmail + "\n" + message);
            msg.setText(message);

            BodyPart messageBodyPart = new MimeBodyPart();
            // Fill the message
            messageBodyPart.setContent("<html><body><b><h1>Thong tin cua mon hoc : </h1></b></body></html>" + subjectCode + "<html><body><b><h3>vao luc : </h3></b></body></html>" + startTime + "<html><body><b><h3> va ket thuc luc : </h3></b></body></html>" + endTime + "<html><body><b><h1>Ma truy cap Fslot cua ban : </h1></b></body></html>" + fslotPassword + "<html><body><b><h2>FSlot nay la cua : </h2></b></body></html>" + lecturerName + "<html><body><b><h2>Email : </h2></b></body></html>" + lecturerEmail + "<html><body><img src=\"https://camo.githubusercontent.com/f3369035e14e2d3c9f8b1f10c8a48c102a84136fefcabc6c85fd6623abdc57ac/68747470733a2f2f692e696d6775722e636f6d2f7044694166544f2e706e67\" alt=\"This is an image of a cat.\" /></body></html>", "text/html");
//            messageBodyPart.setContent("<html><body><b><h3>vao luc : </h3></b></body></html>" + startTime, "text/html");
//            messageBodyPart.setContent("<html><body><b><h3> va ket thuc luc : </h3></b></body></html>" + endTime, "text/html");
//            messageBodyPart.setContent("<html><body><b><h1>Ma truy cap Fslot cua ban : </h1></b></body></html>" + fslotPassword, "text/html");
//            messageBodyPart.setContent("<html><body><b><h2>FSlot nay la cua : </h2></b></body></html>" + lecturerName, "text/html");
//            messageBodyPart.setContent("<html><body><b><h2>Email : </h2></b></body></html>" + lecturerEmail, "text/html");

            // Create a multipar message
            Multipart multipart = new MimeMultipart();
            // Set text message part
            multipart.addBodyPart(messageBodyPart);
            msg.setContent(multipart);
            Transport.send(msg);
            url = SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
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
        } catch (AddressException ex) {
            Logger.getLogger(SendEMailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (AddressException ex) {
            Logger.getLogger(SendEMailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
