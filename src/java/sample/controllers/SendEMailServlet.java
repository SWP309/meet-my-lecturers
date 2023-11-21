/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
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
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.freeslots.FreeSlotError;
import sample.users.UserDTO;

/**
 *
 * @author W10
 */
public class SendEMailServlet extends HttpServlet {

    private static final String ERROR = "send-email.jsp";
    private static final String SUCCESS = "CreatedSlotController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, AddressException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
//        boolean checkSend = false;
        boolean flag = true;
        final String from = "meet.my.lecturers.fpt.edu@gmail.com";
        final String password = "fmpheqhatzpjndvh";
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
        String[] recipients = recipientList.split(",");
        List<InternetAddress> addresses = new ArrayList<>();
        for (String recipient : recipients) {
            addresses.add(new InternetAddress(recipient));
        }

        HttpSession sessionn = request.getSession();
        UserDTO us = (UserDTO) sessionn.getAttribute("loginedUser");
        FreeSlotError freeSlotError = new FreeSlotError();
        String lecturerName = us.getUserName();
        String lecturerEmail = us.getUserEmail();

        String subjectCode = request.getParameter("txtSubjectCode");
        
        Part attachmentPart = request.getPart("txtAttachment");
        String fileName = extractFileName(attachmentPart);
        InputStream attachmentInputStream = attachmentPart.getInputStream();
        
        String startTime = request.getParameter("txtStartTime");
        String endTime = request.getParameter("txtEndTime");

        //tranfer String to Date
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date starts = format.parse(startTime);
        Date ends = format.parse(endTime);
        //****check end time greater than start time
        if (ends.before(starts) || ends.equals(starts)) {
            flag = false;
            freeSlotError.setEndTimeError("- The end times must be greater than start times!!!");
        }
        //****check duration from start time to end time
        // Calculate duration between startTime and endTime
        long timeDifference = ends.getTime() - starts.getTime();
        int minutesDifference = (int) (timeDifference / (1000 * 60));
        if (minutesDifference > 90 || minutesDifference < 15) {
            flag = false;
            freeSlotError.setDurationError("- Duration of a slot must be from 15 to 90 minutes!!!");
        }
        request.setAttribute("FREESLOT_ERROR", freeSlotError);
        
        String fslotPassword = request.getParameter("txtPassword");
        String message = request.getParameter("txtMessage");

        try {
            if (flag) {
                Message msg = new MimeMessage(session);
                msg.addHeader("Content-Charset", "UTF-8");
                msg.setFrom(new InternetAddress(from));
                msg.addRecipients(Message.RecipientType.TO, addresses.toArray(new InternetAddress[0]));
                msg.setSubject("Thông Tin Cua Môn Hoc : " + subjectCode + " Vào Lúc : " + startTime + " Và Ket Thúc Lúc : " + endTime);

                //first body part of the multipart
                BodyPart messageBodyPart = new MimeBodyPart();
                messageBodyPart.setContent("<html><body><b><h1>Thông Tin Của Môn Học : </h1></b></body></html>" + subjectCode + "<html><body><b><h3>Bắt Đầu lúc : </h3></b></body></html>" + startTime + "<html><body><b><h3> Và Kết Thúc lúc : </h3></b></body></html>" + endTime + "<html><body><b><h1>Mã Truy Cập Fslot Của Bạn : </h1></b></body></html>" + fslotPassword + "<html><body><b><h4>===============================================================================<html><body><b><h4>" + message + "<html><body><b><h4>===============================================================================<html><body><b><h4>" + "<html><body><b><h2>FSlot Này Là Của : </h2></b></body></html>" + lecturerName + "<html><body><b><h2>Email : </h2></b></body></html>" + lecturerEmail + "<html><body><img src=\"https://fpt.edu.vn/Content/images/assets/Logo-FU-03.png\" alt=\"This is an image of a cat.\" /></body></html>", "text/html; charset=UTF-8");
                
                //second body part of the multipart
                MimeBodyPart attachmentBodyPart = new MimeBodyPart();
                attachmentBodyPart.setDataHandler(new DataHandler(new ByteArrayDataSource(attachmentInputStream, "application/octet-stream")));
                attachmentBodyPart.setFileName(fileName);
                
                // Create a multipart message
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);
                multipart.addBodyPart(attachmentBodyPart);

                msg.setContent(multipart);
                Transport.send(msg);
                url = SUCCESS;
            }
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
        } catch (ParseException ex) {
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
        } catch (ParseException ex) {
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

    public String extractFileName(Part part) {
        String disposition = part.getHeader("content-disposition");
        String[] components = disposition.split(";");
        for (String component : components) {
            if (component.trim().startsWith("filename")) {
                return component.substring(component.indexOf("filename") + 9).trim().replace("\"", "");
            }
        }
        return null;
    }

}
