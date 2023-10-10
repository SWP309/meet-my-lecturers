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

    private static String BOOKING_VIEW = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, u.userName\n"
            + "FROM Bookings b\n"
            + "JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "JOIN Users u ON b.studentID = u.userID\n"
            + "JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "WHERE u.userEmail = ?";

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
                    java.sql.Date startTime = rs.getDate("startTime");
                    java.sql.Date endTime = rs.getDate("endTime");
                    String userName = rs.getString("userName");
                    listBooking.add(new BookingDTO(subjectCode, lectureName, startTime, endTime, userName));
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
