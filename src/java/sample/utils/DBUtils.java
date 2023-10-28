/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author CHIBAO
 */
public class DBUtils {

    private static final String USERNAME = "sa";
    private static final String PASSWORD = "12345";    
    public static Connection getConnection() 
            throws ClassNotFoundException, SQLException{
        Connection con = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=MeetMyLecturer2;characterEncoding=UTF-8;useUnicode=true";
        con = DriverManager.getConnection(url, USERNAME, PASSWORD);
        return con;
    }
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
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException, ParseException {
//        DBUtils.getConnection();
//        System.out.println(DBUtils.getConnection());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date startTime = simpleDateFormat.parse("2023-10-25T03:00");
        Date nextDate = DBUtils.getNextDate(startTime);
            
    }
}
