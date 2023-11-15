package services;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.requests.RequestDTO;
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;

public class Service {

    private static final int CHECK_INTERVAL_MINUTES = 1; // Check for upcoming Free slots every 1 minutes

    public static Date getNextDate(Date curDate) {
        Date nextDate = null;
        try {
            Calendar today = Calendar.getInstance();
            today.setTime(curDate);
            today.add(Calendar.DAY_OF_YEAR, 1);
            nextDate = today.getTime();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return nextDate;
        }
        return nextDate;
    }

    public static Date getNextWeek(Date curDate) {
        Date nextDate = null;
        try {
            Calendar today = Calendar.getInstance();
            today.setTime(curDate);
            today.add(Calendar.DAY_OF_YEAR, 7);
            nextDate = today.getTime();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return nextDate;
        }
        return nextDate;
    }

    public static boolean duplicateSlot(FreeSlotsDTO f) throws SQLException, ParseException, ClassNotFoundException {
        TimetableDAO tr = new TimetableDAO();
        Calendar startTime = Service.dateToCalendar(f.getStartTime());
//        System.out.println(startTime);
        String day = intToDays(startTime.get(Calendar.DAY_OF_WEEK));
//        System.out.println(day);
        List<TimetableDTO> list = tr.listByDate(f.getLecturerID(), day, f.getStartTime(), f.getEndTime());
//        for (TimetableDTO timetableDTO : list) {
//            System.out.println(timetableDTO.getLecturerID());
//        }
        if (list.size() > 0) {
            return false;
        }
        return true;
    }

    public static boolean duplicateSlot(RequestDTO r) throws SQLException, ParseException, ClassNotFoundException {
        TimetableDAO tr = new TimetableDAO();
        Calendar startTime = Service.dateToCalendar(r.getStartTime());
        String day = intToDays(startTime.get(Calendar.DAY_OF_WEEK));

        String s1 = r.getStartTime().substring(11);
        String s2 = r.getEndTime().substring(11);

//        String start = sdfTime.format(d);
        List<TimetableDTO> list = tr.listByDate(r.getLecturerID(), day, s1, s2);
        if (list.size() > 0) {
            return false;
        }
        return true;
    }

    public static Calendar dateToCalendar(String date) throws ParseException {
        Date dateConvert = sdfDateTime.parse(date);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dateConvert);
        return calendar;
    }

    public static SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    public static SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
    public static SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");

    public static String intToDays(int number) {
        String[] daysInWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        return daysInWeek[number - 1];
    }
//    public static void main(String[] args) throws ParseException, SQLException, ClassNotFoundException {
//        Service ts = new Service();
//        String d = "2023-11-11 8:00";
//        String d1 = "2023-11-11 10:00";
//
//        Date date = sdfDateTime.parse(d);
//        Date date1 = sdfDateTime.parse(d1);
////        FreeSlotsDTO f = new FreeSlotsDTO("SWP391", d, d1, "", 0, "", 0, "", true, "");
//        
//        RequestDTO r = new RequestDTO("", 0, "", d, d1, "", "", "", "");
////Requests(1, true, "Swe", date, date1, "asdfghj", "se123", "gv0002");
//        System.out.println(ts.duplicateSlot(r));
//    }

    public static void sendReminderEmail(String freeSlotID, String lecturer_email,String subjectCode,String startTime) throws AddressException, MessagingException {
        
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
        
        // Compose email content
        String subject = "Upcoming Free Slot Reminder ==> "+"for Subject : "+subjectCode;
        String body = "Dear Lecturer : "+lecturer_email+"\n"+"This is a reminder that your scheduled free slot is approaching. Your slot details are as follows:\n\nSlot ID: " + freeSlotID + "\nStart Time: " + startTime + "\n\nPlease arrive on time for your Free slot.\n\nRegards,\nThe Meet-My-Lecturer FPT-EDU Free Slot Management System\n"+"meet.my.lecturers.fpt.edu@gmail.com";
        
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(lecturer_email));
        msg.setSubject(subject);
        msg.setText(body);
        
        Transport.send(msg);
    }

    public static class FreeSlotReminderTask extends TimerTask {

        @Override
        public void run() {
            try {
                FreeSlotsDAO fsdao = new FreeSlotsDAO();

                // Retrieve upcoming free slots from the database
                List<FreeSlotsDTO> upcomingFSlots = fsdao.getUpcomingFSlots();

                // Send reminder emails for each upcoming free slot
                for (FreeSlotsDTO fslot : upcomingFSlots) {
                    String lecturerID = fsdao.getLecturerIDByFSlotID(fslot.getFreeSlotID());
                    String lecturer_email = fsdao.getEmailByLecturerID(lecturerID);
                    sendReminderEmail(fslot.getFreeSlotID(), lecturer_email,fslot.getSubjectCode(),fslot.getStartTime());
                }
            } catch (SQLException ex) {
                Logger.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            } catch (MessagingException ex) {
                Logger.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void scheduleFreeSlotReminders() {
        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new FreeSlotReminderTask(), 0, CHECK_INTERVAL_MINUTES * 60 * 1000); // Execute task every 1 minutes // 0 is executed immediately
        System.out.println("FreeSlotReminderTask Service is running .........");
    }
    public static void main(String[] args) {
        scheduleFreeSlotReminders();
    }
}
