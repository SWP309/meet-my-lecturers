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
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author PC
 */
public class BookingDAO {

    private static String BOOKING_VIEW = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "            WHERE b.status='1' and u.userEmail = ?";

    private static String CANCEL_BOOKING = "UPDATE Bookings SET status = 0 WHERE bookingID = ?";
    private static String CHECK_ATTENDANCE_BOOKING = "UPDATE Bookings SET status = 2 WHERE bookingID = ?";
    private static String BOOKING_FREE_SLOT = "INSERT INTO \n"
            + "          Bookings(studentID,freeSlotID,status) \n"
            + "            VALUES(?, ?, 1);";
    private static String SEARCH_BOOKED_SLOT_BY_ALL = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "  where b.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.subjectCode = ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_ST_ET = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where b.status='1' and fs.startTime >= ? and fs.endTime <= ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_SUBJECTCODE = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where  b.status='1' and fs.subjectCode = ? and u.userEmail = ?";

    private static String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public List<BookingDTO> getListBooking(String userEmail) throws SQLException {
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
                    String meetLink = rs.getString("meetLink");
                    listBooking.add(new BookingDTO(subjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink));
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

    public List<BookingDTO> searchBSlotViewByAll(String subjectCode, String startTime, String endTime, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_ALL);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setTimestamp(1, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTimeFS.getTime()));
                ptm.setString(3, subjectCode);
                ptm.setString(4, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String fetchedSubjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String userName = rs.getString("userName");
                    String bookingID = rs.getString("bookingID");
                    String meetLink = rs.getString("meetLink");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink));
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
        return searchBSlot;
    }

    public List<BookingDTO> searchBSlotViewByStEt(String startTime, String endTime, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_ST_ET);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setTimestamp(1, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTimeFS.getTime()));
                ptm.setString(3, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String fetchedSubjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String userName = rs.getString("userName");
                    String bookingID = rs.getString("bookingID");
                    String meetLink = rs.getString("meetLink");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink));
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
        return searchBSlot;
    }

    public List<BookingDTO> searchBSlotViewBySubjectCode(String subjectCode, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_SUBJECTCODE);
                ptm.setString(1, subjectCode);
                ptm.setString(2, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                     String fetchedSubjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String userName = rs.getString("userName");
                    String bookingID = rs.getString("bookingID");
                    String meetLink = rs.getString("meetLink");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink));
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
        return searchBSlot;
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

    public boolean BookFSlot(BookingDTO bookingDTO) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(BOOKING_FREE_SLOT);
                ps.setString(1, bookingDTO.getStudentID());
                ps.setString(2, bookingDTO.getFreeSlotID());
                checkUpdate = ps.executeUpdate() > 0;
                System.out.println(checkUpdate);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkUpdate;
    }

    public boolean checkAttendance(String bookingID) throws SQLException {
        boolean checkAttendanceBK = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_ATTENDANCE_BOOKING);
                ptm.setString(1, bookingID);
                checkAttendanceBK = ptm.executeUpdate() > 0 ? true : false;
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
        return checkAttendanceBK;
    }
}
