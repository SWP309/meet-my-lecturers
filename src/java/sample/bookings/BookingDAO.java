/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.bookings;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author PC
 */
public class BookingDAO {

    private static String BOOKING_VIEW = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID\n"
            + "FROM Bookings b\n"
            + "JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "JOIN Users u ON b.studentID = u.userID\n"
            + "JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "WHERE b.status='1' and u.userEmail = ?";
    
     private static String CANCEL_BOOKING = "UPDATE Bookings SET status = 0 WHERE bookingID = ?";

    private static String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public List<BookingDTO> Getlistbooking(String userEmail) throws SQLException {
        List<BookingDTO> listBooking = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(BOOKING_VIEW);
                ptm.setString(1, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(endTime);
                    String userName = rs.getString("userName");
                    String bookingID = rs.getString("bookingID");
                    listBooking.add(new BookingDTO(subjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID));
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
    
     public boolean Cancel(String bookingID) throws SQLException {
        boolean checkCancel = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CANCEL_BOOKING);
                ptm.setString(1, bookingID);
                checkCancel = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkCancel;
    }
   
}
