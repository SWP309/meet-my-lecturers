package services;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import sample.freeslots.FreeSlotsDTO;
import sample.requests.RequestDTO;
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;

public class Service {

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
        String day = intToDays(startTime.get(Calendar.DAY_OF_WEEK));
        List<TimetableDTO> list = tr.listByDate(f.getLecturerID(), day, f.getStartTime(), f.getEndTime());
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
        return daysInWeek[number-1];
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
}
