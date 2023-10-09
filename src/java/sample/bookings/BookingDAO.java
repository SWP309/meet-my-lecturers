/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.bookings;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author PC
 */
public class BookingDAO {
       private static String BOOKING_VIEW= "SELECT  fs.subjectCode,u.userName,b.semesterName,fs.startTime,s.endTime  FROM Bookings b JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID JOIN  User u ON b.userID = u.userID";
        
       
       
       public List<BookingDTO> Getlistbooking() throws SQLException {
        List<BookingDTO> listBooking = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(BOOKING_VIEW);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("userID");
                    String userName = rs.getString("fullName");
                    String semesterName = rs.getString("roleID");
                    java.sql.Date startTime = rs.getDate("startTime");
                    java.sql.Date endTime = rs.getDate("endTime");
                    listBooking.add(new BookingDTO(subjectCode, userName, semesterName, startTime, endTime));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listBooking;
    }
    
}
