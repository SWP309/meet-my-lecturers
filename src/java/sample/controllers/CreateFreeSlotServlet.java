/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotError;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.users.UserDTO;
import sample.utils.DBUtils;
import sample.viewCreatedSlot.ViewCreatedSlotDAO;
import sample.viewCreatedSlot.ViewCreatedSlotDTO;
import services.Service;

/**
 *
 * @author W10(hiep-tm)
 */
@WebServlet(name = "CreateFreeSlotServlet", urlPatterns = {"/newfreeslot"})
public class CreateFreeSlotServlet extends HttpServlet {

    private static final String ERROR = "create-freeSlot.jsp";
    private static final String SUCCESS = "CreatedSlotController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, AddressException, MessagingException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        boolean flag = true;
        boolean checkCreated = false;
        try {
            HttpSession httpsession = request.getSession();
            UserDTO us = (UserDTO) httpsession.getAttribute("loginedUser");
            String lecturerName = us.getUserName();
            String lecturerEmail = us.getUserEmail();
            FreeSlotsDAO freeSlotsDAO = new FreeSlotsDAO();
            FreeSlotError freeSlotError = new FreeSlotError();
            String lecturerID = us.getUserID();
            String semesterID = request.getParameter("txtSemesterID");
//            boolean existsSemesterID = freeSlotsDAO.checkSemesterID(semesterID);
//            if (!existsSemesterID) {
//                flag = false;
//                freeSlotError.setSemesterIDError("The semesterID is wrong format OR not exist in DB.");
//            }
            List<FreeSlotsDTO> listSemester = freeSlotsDAO.GetListSemesterID();
            List<FreeSlotsDTO> listSubject = freeSlotsDAO.GetListSubject();
            if (us.getUserEmail() != null) {
                request.setAttribute("LIST_SEMESTER", listSemester);
                request.setAttribute("LIST_SUBJECT", listSubject);
            }

            String subjectCode = request.getParameter("txtSubjectCode");
//            boolean existsSubjectCode = freeSlotsDAO.checkSubjectCode(subjectCode);
//            if (!existsSubjectCode) {
//                flag = false;
//                freeSlotError.setSubjectCodeError("The Subject code is wrong format OR not exist in DB.");
//            }

            String password = request.getParameter("txtPassword").trim();
            if (password.isEmpty()) {
                password = null; // Chuyển chuỗi trống thành giá trị null
            }

            String recipientList = request.getParameter("txtRecipient").trim();
            if (recipientList.isEmpty()) {
                recipientList = null;
            }

            int capacity = Integer.parseInt(request.getParameter("txtCapacity"));
            if (capacity < 1 || capacity > 100) {
                flag = false;
                freeSlotError.setCapacityError("The number of student can join this slot must be between 1-100");
            }

            String meetLink = request.getParameter("txtMeetLink");
            boolean existsMeetLink = freeSlotsDAO.checkDuplicateGGMeet(meetLink);
            if (existsMeetLink) {
                flag = false;
                freeSlotError.setMeetLinkError("The gg meet link is duplicated.");
            }

            String block_list = request.getParameter("txtBan").trim();
            if (block_list.isEmpty()) {
                block_list = null; // Chuyển chuỗi trống thành giá trị null
            }

            String setByOption = request.getParameter("txtOption");

            int count = Integer.parseInt(request.getParameter("txtCount"));
            if (count < 1) {
                flag = false;
                freeSlotError.setRepeatedTimeError("The repeated time must be greater OR equal 1");
            }

            int status = 0;
            String statusOption = request.getParameter("txtStatusOption");
            if (statusOption.equals("PUB")) {
                status = 1;
            }
            if (statusOption.equals("PRV")) {
                status = 0;
            }

            int mode = 1;
            String modeOption = request.getParameter("txtModeOption");
            if (modeOption.equals("BOOK")) {
                mode = 1;
            }
            if (modeOption.equals("REQT")) {
                mode = 2;
            }

            String startTime = request.getParameter("txtStartTime");
            String endTime = request.getParameter("txtEndTime");
            //****Check input time with current time
            //tranfer String to Date
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date starts = format.parse(startTime);
            Date ends = format.parse(endTime);
            //get current date
            Date currentTime = new Date();
            // Calculate current time plus 10 minutes
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentTime);
            calendar.add(Calendar.MINUTE, 10);
            Date timeInFuture = calendar.getTime();
            //compare input time to current time
            if (starts.before(timeInFuture) || ends.before(timeInFuture)) {
                flag = false;
                freeSlotError.setPastTimeError("- The start and end times must be in the future"
                        + " and at least 10 minutes greater than the current time!!!");
            }
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
            //****check not allowed create slot <= 5AM or >= 11PM
            calendar.setTime(starts);
            calendar.setTime(ends);
            int startHour = calendar.get(Calendar.HOUR_OF_DAY);
            int endHour = calendar.get(Calendar.HOUR_OF_DAY);
            if (startHour <= 5 || startHour >= 23 || endHour <= 5 || endHour >= 23) {
                flag = false;
                freeSlotError.setDurationError("- Not allowed create slot <= 5AM or >= 11PM!!!");
            }
//            ****check duplicate time with created freeslot
            boolean checkStartTimeDuplicateFS = freeSlotsDAO.checkTimeDuplicateInFreeSlot(lecturerID, starts);
            boolean checkEndTimeDuplicateFS = freeSlotsDAO.checkTimeDuplicateInFreeSlot(lecturerID, ends);
            if (checkStartTimeDuplicateFS == false || checkEndTimeDuplicateFS == false) {
                flag = false;
                freeSlotError.setDuplicateTimeError("- The time you entered overlaps with time of created FREESLOT!!! ");
            }

            // ****check time valid with Semester 
            String checkStartTimeInSemester = freeSlotsDAO.getSemesterID(starts);
            String checkEndTimeInSemester = freeSlotsDAO.getSemesterID(ends);
            if (!checkStartTimeInSemester.equals(semesterID) || !checkEndTimeInSemester.equals(semesterID) || checkStartTimeInSemester.equals("") || checkEndTimeInSemester.equals("")) {
                flag = false;
                freeSlotError.setSemesterTimeError("- The time you entered NOT MATCH with this Semester");
            }

            FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(subjectCode, startTime, endTime, password, capacity, meetLink, count, lecturerID, status, semesterID, block_list, mode);

//            //*****check duplicate timetable*****
//            Service service = new Service();
//            boolean checkTimetableDuplicate = service.duplicateSlot(freeSlotsDTO);
//            System.out.println(checkTimetableDuplicate);
//            if (checkTimetableDuplicate==false) {
//                flag=false;
//                freeSlotError.setDuplicateTimeTableError("- The time you entered overlaps your TimeTable. Please check FAP!!!");
//            }
            request.setAttribute("FREESLOT_ERROR", freeSlotError);

            if (flag) {
                for (int i = 1; i <= count; i++) {
                    checkCreated = freeSlotsDAO.createFreeSlot(freeSlotsDTO);
                    if (checkCreated) {
                        final String from = "meet.my.lecturers.fpt.edu@gmail.com";
                        final String mailpassword = "fmpheqhatzpjndvh";
                        Properties prop = new Properties();
                        prop.put("mail.smtp.host", "smtp.gmail.com");
                        prop.put("mail.smtp.port", "587");
                        prop.put("mail.smtp.auth", "true");
                        prop.put("mail.smtp.starttls.enable", "true");//TLS
                        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(from, mailpassword);
                            }
                        });

                        if (recipientList != null) {
                            String[] recipients = recipientList.split(",");
                            List<InternetAddress> addresses = new ArrayList<>();
                            for (String recipient : recipients) {
                                addresses.add(new InternetAddress(recipient));
                            }

                            Message msg = new MimeMessage(session);
                            msg.addHeader("Content-Charset", "UTF-8");
                            msg.setFrom(new InternetAddress(from));
                            msg.addRecipients(Message.RecipientType.TO, addresses.toArray(new InternetAddress[0]));
                            msg.setSubject("Thông Tin Cua Môn Học : " + subjectCode + " Vào Lúc : " + startTime + " Và Ket Thúc Lúc : " + endTime);

                            // Create a multipart message
                            Multipart multipart = new MimeMultipart();

                            //first body part of the multipart
                            BodyPart messageBodyPart = new MimeBodyPart();
                            messageBodyPart.setContent("<html><body><b><h1>Thông Tin Của Môn Học : </h1></b></body></html>" + subjectCode + "<html><body><b><h3>Bắt Đầu lúc : </h3></b></body></html>" + startTime + "<html><body><b><h3> Và Kết Thúc lúc : </h3></b></body></html>" + endTime + "<html><body><b><h1>Mã Truy Cập Fslot Của Bạn : </h1></b></body></html>" + password + "<html><body><b><h2>FSlot Này Là Của : </h2></b></body></html>" + lecturerName + "<html><body><b><h2>Email : </h2></b></body></html>" + lecturerEmail + "<html><body><img src=\"https://uni.fpt.edu.vn/Data/Sites/1/skins/default/img/og-image.png\" alt=\"This is an image of a cat.\" /></body></html>", "text/html; charset=UTF-8");
                            multipart.addBodyPart(messageBodyPart);

                            msg.setContent(multipart);
                            Transport.send(msg);
                        }
                    }

                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date sTime = simpleDateFormat.parse(freeSlotsDTO.getStartTime());
                    Date eTime = simpleDateFormat.parse(freeSlotsDTO.getEndTime());
                    if (setByOption.equals("DA")) {
                        Date sNextDay = services.Service.getNextDate(sTime);
                        startTime = simpleDateFormat.format(sNextDay);
                        freeSlotsDTO.setStartTime(startTime);
                        Date eNextDay = services.Service.getNextDate(eTime);
                        endTime = simpleDateFormat.format(eNextDay);
                        freeSlotsDTO.setEndTime(endTime);
                    }
                    if (setByOption.equals("DW")) {
                        Date sNextWeek = services.Service.getNextWeek(sTime);
                        startTime = simpleDateFormat.format(sNextWeek);
                        freeSlotsDTO.setStartTime(startTime);
                        Date eNextWeek = services.Service.getNextWeek(eTime);
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
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (AddressException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (AddressException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(CreateFreeSlotServlet.class.getName()).log(Level.SEVERE, null, ex);
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
