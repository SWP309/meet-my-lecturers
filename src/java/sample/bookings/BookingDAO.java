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
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.utils.DBUtils;
import services.Service;

/**
 *
 * @author PC
 */
public class BookingDAO {

    private static String BOOKING_VIEW = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink , fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "            WHERE b.status='1' and u.userEmail = ?";

    private static String CANCEL_BOOKING = "UPDATE Bookings SET status = 0 WHERE bookingID = ?";

    private static String CHECK_ATTENDANCE_BOOKING = "UPDATE Bookings SET status = 2 WHERE bookingID = ?";
    private static String BOOKING_FREE_SLOT = "IF NOT EXISTS (SELECT * FROM Bookings WHERE studentID = ? AND freeSlotID = ?) "
            + "                              BEGIN INSERT INTO Bookings(studentID, freeSlotID, status) VALUES (?,?, 1) END;";
    private static String SEARCH_BOOKED_SLOT_BY_ALL = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "  where b.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.subjectCode = ? and u.userEmail = ? and fs.semesterID = ?";
    private static String SEARCH_BOOKED_SLOT_BY_St_Et_SUBJECTCODE = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "  where b.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.subjectCode = ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_St_Et_SEMESTERID = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where  fs.subjectCode = ? and u.userEmail = ?";

    private static String SEARCH_NUMBER_OF_BOOKED_STUDENT = "SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "                         FROM Bookings b\n"
            + "                         WHERE b.status = 1 AND b.freeSlotID = ?\n"
            + "                         GROUP BY b.freeSlotID";

    private static String CHECK_TIME_DUPLICATE_BOOKED_FS = "SELECT fs.freeSlotID\n"
            + "FROM FreeSlots fs\n"
            + "JOIN (  SELECT b.freeSlotID\n"
            + "		FROM Bookings b\n"
            + "		WHERE b.status = 1 \n"
            + "		AND b.studentID = ?) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "WHERE ? BETWEEN fs.startTime AND fs.endTime";
    private static String CHECK_TIME_DUPLICATE_CANCEL = "SELECT fs.freeSlotID\n"
            + "FROM FreeSlots fs\n"
            + "JOIN (  SELECT b.freeSlotID\n"
            + "		FROM Bookings b\n"
            + "		WHERE \n"
            + "		 b.studentID = ?) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "WHERE ? BETWEEN fs.startTime AND fs.endTime";
    private static String DELETE_BOOKED_STATUS = "DELETE Bookings where freeSlotID = ?";
    private static String CHECK_TIME_DUPLICATE_REQUEST = "SELECT r.requestID\n"
            + "FROM Requests r\n"
            + "WHERE r.status = 1 \n"
            + "AND ? BETWEEN r.startTime AND r.endTime\n"
            + "AND r.studentID = ?";
    private static String SEARCH_BOOKED_SLOT_BY_ST_ET = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where b.status='1' and fs.startTime >= ? and fs.endTime <= ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_SUBJECTCODE = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where  b.status='1' and fs.subjectCode = ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_SEMESTER = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where  b.status='1' and fs.semesterID = ? and u.userEmail = ?";
    private static String SEARCH_BOOKED_SLOT_BY_NULL = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime,u.userName, b.bookingID,fs.meetLink, fs.semesterID\n"
            + "          FROM Bookings b\n"
            + "           JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "		  where  b.status='1' and u.userEmail = ? and fs.semesterID = ?";
    private static String SEARCH_STUDENT_MAX_ABSENT_IN4 = "SELECT b.bookingID, fs.lecturerID, fs.subjectCode, fs.startTime, fs.endTime, fs.semesterID, u.userName\n"
            + "            FROM Bookings b\n"
            + "            JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "			JOIN Users u ON fs.lecturerID = u.userID\n"
            + "            WHERE b.studentID = ? AND b.status = 1 AND fs.endTime < ?\n"
            + "            AND fs.semesterID = ( SELECT s.semesterID\n"
            + "           		     FROM Semesters s\n"
            + "            		     WHERE ? BETWEEN s.startDay AND s.endDay)";

    private static String SEARCH_STUDENT_MAX_CANCEL_IN4 = "SELECT b.bookingID, fs.lecturerID, u.userName, fs.subjectCode, fs.startTime, fs.endTime, fs.semesterID\n"
            + "FROM Bookings b\n"
            + "JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "JOIN Users u ON fs.lecturerID = u.userID\n"
            + "WHERE b.studentID = ? AND b.status = 0 AND fs.semesterID = ( SELECT s.semesterID\n"
            + "											FROM Semesters s\n"
            + "											WHERE ? BETWEEN s.startDay AND s.endDay)";

    private static String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public BookingDTO bookingAbsenceNumberBySemester(String semesterID) throws SQLException, ClassNotFoundException, ParseException {
        BookingDTO b = new BookingDTO();
        Date date = new Date();
//        String d = Service.sdfDateTime.format(date);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(
                "select top 5 b.studentID, COUNT(*) AS 'Number of absent slots'\n"
                + "                                    from Bookings b\n"
                + "                                    join FreeSlots f on f.freeSlotID = b.freeSlotID\n"
                + "									join Users u ON b.studentID = u.userID\n"
                + "                                    where b.status = 1 and f.endTime < ? AND u.userStatus = 1 AND f.semesterID = ?"
                + "                                    GROUP BY b.studentID\n"
                + "                                    ORDER BY [Number of absent slots] asc");
        String start = services.Service.sdfDateTime.format(date);
        stm.setTimestamp(1, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
        stm.setString(2, semesterID);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {

            b.setStudentID(rs.getString("studentID"));
            b.setNumberOfAbsenceSlot(rs.getInt("Number of absent slots"));

        }
        con.close();
        return b;
    }

    public BookingDTO bookingCancelNumberBySemester(String semesterID) throws SQLException, ClassNotFoundException, ParseException {
        BookingDTO b = new BookingDTO();
        Date date = new Date();
//        String d = Service.sdfDateTime.format(date);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select top 5 b.studentID, COUNT(*) AS 'Number of cancel slots'\n"
                + "                                    from Bookings b\n"
                + "                                    join FreeSlots f on f.freeSlotID = b.freeSlotID\n"
                + "									JOIN Users u ON b.studentID = u.userID\n"
                + "                                    where b.status = 0 AND u.userStatus = 1 AND f.semesterID = ?"
                + "                                   GROUP BY b.studentID\n"
                + "                                    ORDER BY [Number of cancel slots] asc");
        String start = services.Service.sdfDateTime.format(date);
        stm.setString(1, semesterID);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            b.setStudentID(rs.getString("studentID"));
            b.setNumberOfCancelSlot(rs.getInt("Number of cancel slots"));
        }
        con.close();
        return b;
    }

    public List<BookingDTO> bookingAbsenceNumber() throws SQLException, ClassNotFoundException, ParseException {
        List<BookingDTO> list = new ArrayList<>();
        Date date = new Date();
//        String d = Service.sdfDateTime.format(date);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(
                "select top 5 b.studentID, COUNT(*) AS 'Number of absent slots'\n"
                + "                                    from Bookings b\n"
                + "                                    join FreeSlots f on f.freeSlotID = b.freeSlotID\n"
                + "									join Users u ON b.studentID = u.userID\n"
                + "                                    where b.status = 1 and f.endTime < ? AND u.userStatus = 1 AND f.semesterID = ( SELECT s.semesterID\n"
                + "                											FROM Semesters s\n"
                + "                											WHERE ? BETWEEN s.startDay AND s.endDay)\n"
                + "                                    GROUP BY b.studentID\n"
                + "                                    ORDER BY [Number of absent slots] desc");
        String start = services.Service.sdfDateTime.format(date);
        stm.setTimestamp(1, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
        stm.setTimestamp(2, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            BookingDTO b = new BookingDTO();
            b.setStudentID(rs.getString("studentID"));
            b.setNumberOfAbsenceSlot(rs.getInt("Number of absent slots"));
            list.add(b);
        }
        con.close();
        return list;
    }

    public List<BookingDTO> bookingCancelNumber() throws SQLException, ClassNotFoundException, ParseException {
        List<BookingDTO> list = new ArrayList<>();
        Date date = new Date();
//        String d = Service.sdfDateTime.format(date);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select top 5 b.studentID, COUNT(*) AS 'Number of cancel slots'\n"
                + "                                    from Bookings b\n"
                + "                                    join FreeSlots f on f.freeSlotID = b.freeSlotID\n"
                + "									JOIN Users u ON b.studentID = u.userID\n"
                + "                                    where b.status = 0 AND u.userStatus = 1 AND f.semesterID = ( SELECT s.semesterID\n"
                + "                											FROM Semesters s\n"
                + "                											WHERE ? BETWEEN s.startDay AND s.endDay)\n"
                + "                                   GROUP BY b.studentID\n"
                + "                                    ORDER BY [Number of cancel slots] desc");
        String start = services.Service.sdfDateTime.format(date);
        stm.setTimestamp(1, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            BookingDTO b = new BookingDTO();
            b.setStudentID(rs.getString("studentID"));
            b.setNumberOfCancelSlot(rs.getInt("Number of cancel slots"));
            list.add(b);
        }
        con.close();
        return list;
    }

    public List<BookingDTO> getStudentMaxAbsentIn4(String studentID) throws SQLException, ClassNotFoundException {
        List<BookingDTO> listStudent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date currentDate = new Date();
                ptm = conn.prepareStatement(SEARCH_STUDENT_MAX_ABSENT_IN4);
                ptm.setString(1, studentID);
                ptm.setTimestamp(2, new Timestamp(currentDate.getTime()));
                ptm.setTimestamp(3, new Timestamp(currentDate.getTime()));
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String bookingID = rs.getString("bookingID");
                    String lecturerID = rs.getString("lecturerID");
                    String lecturerName = rs.getNString("userName");
                    String subjectCode = rs.getString("subjectCode");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String starts = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String ends = convertDateToString(endTime);
                    String semesterID = rs.getString("semesterID");
                    BookingDTO bookingDTO = new BookingDTO();
                    bookingDTO.setBookingID(bookingID);
                    bookingDTO.setStudentID(studentID);
                    bookingDTO.setLecturerID(lecturerID);
                    bookingDTO.setLectureName(lecturerName);
                    bookingDTO.setSubjectCode(subjectCode);
                    bookingDTO.setStartTime(starts);
                    bookingDTO.setEndTime(ends);
                    bookingDTO.setSemesterID(semesterID);
                    listStudent.add(bookingDTO);
                }
            }
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
        return listStudent;
    }

    public List<BookingDTO> getStudentMaxCancelIn4(String studentID) throws SQLException, ClassNotFoundException {
        List<BookingDTO> listStudent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date currentDate = new Date();
                ptm = conn.prepareStatement(SEARCH_STUDENT_MAX_CANCEL_IN4);
                ptm.setString(1, studentID);
                ptm.setTimestamp(2, new Timestamp(currentDate.getTime()));
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String bookingID = rs.getString("bookingID");
                    String lecturerID = rs.getString("lecturerID");
                    String lecturerName = rs.getNString("userName");
                    String subjectCode = rs.getString("subjectCode");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String starts = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String ends = convertDateToString(endTime);
                    String semesterID = rs.getString("semesterID");
                    BookingDTO bookingDTO = new BookingDTO();
                    bookingDTO.setBookingID(bookingID);
                    bookingDTO.setLecturerID(lecturerID);
                    bookingDTO.setStudentID(studentID);
                    bookingDTO.setLectureName(lecturerName);
                    bookingDTO.setSubjectCode(subjectCode);
                    bookingDTO.setStartTime(starts);
                    bookingDTO.setEndTime(ends);
                    bookingDTO.setSemesterID(semesterID);
                    listStudent.add(bookingDTO);
                }
            }
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
        return listStudent;
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    listBooking.add(new BookingDTO(subjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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

    public List<BookingDTO> searchBSlotViewByNull(String userEmail, String semesterID) throws SQLException {
        List<BookingDTO> listBooking = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_NULL);
                ptm.setString(1, userEmail);
                ptm.setString(2, semesterID);
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    listBooking.add(new BookingDTO(subjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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

    public List<BookingDTO> searchBSlotViewByAll(String subjectCode, String startTime, String endTime, String userEmail, String semesterID) throws SQLException {
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
                ptm.setString(5, semesterID);
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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

    public List<BookingDTO> searchBSlotViewByStEtSubjectCode(String subjectCode, String startTime, String endTime, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_St_Et_SUBJECTCODE);
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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

    public List<BookingDTO> searchBSlotViewByStEtSemesterID(String semesterID, String startTime, String endTime, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_St_Et_SEMESTERID);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setTimestamp(1, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTimeFS.getTime()));
                ptm.setString(3, semesterID);
                ptm.setString(4, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String userName = rs.getString("userName");
                    String bookingID = rs.getString("bookingID");
                    String meetLink = rs.getString("meetLink");
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(subjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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

    public List<BookingDTO> searchBSlotViewBySemester(String semesterID, String userEmail) throws SQLException {
        List<BookingDTO> searchBSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_BOOKED_SLOT_BY_SEMESTER);
                ptm.setString(1, semesterID);
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
                    String fetchedSemesterID = rs.getString("semesterID");
                    searchBSlot.add(new BookingDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, userName, bookingID, meetLink, fetchedSemesterID));
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
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CANCEL_BOOKING);
                ptm.setString(1, bookingID);
                checkDelete = ptm.executeUpdate() > 0 ? true : false;
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
        return checkDelete;
    }
      public boolean DeleteStatusBookedCancel(String freeSlotID) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_BOOKED_STATUS);
                ptm.setString(1, freeSlotID);
                checkDelete = ptm.executeUpdate() > 0 ? true : false;
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
        return checkDelete;
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
                ps.setString(3, bookingDTO.getStudentID());
                ps.setString(4, bookingDTO.getFreeSlotID());
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

    public int getBookedStudent(String freeSlotID) throws SQLException {
        int count = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_NUMBER_OF_BOOKED_STUDENT);
                ptm.setString(1, freeSlotID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("Number of students");
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
        return count;
    }

    public boolean checkTimeDuplicateInBookedFreeSlot(String studentID, Date starts) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE_BOOKED_FS);
            stm.setString(1, studentID);
            stm.setTimestamp(2, new Timestamp(starts.getTime()));
            rs = stm.executeQuery();
            if (rs.next()) {
                check = false;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }
    public boolean checkTimeDuplicateInBookedCancel(String studentID, Date starts) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE_CANCEL);
            stm.setString(1, studentID);
            stm.setTimestamp(2, new Timestamp(starts.getTime()));
            rs = stm.executeQuery();
            if (rs.next()) {
                check = false;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }

    public boolean checkTimeDuplicateInRequest(String studentID, Date starts) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE_REQUEST);
            stm.setString(1, studentID);
            stm.setTimestamp(2, new Timestamp(starts.getTime()));
            rs = stm.executeQuery();
            if (rs.next()) {
                check = false;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }

    public List<BookingDTO> bookingPresenceInformation() throws SQLException, ClassNotFoundException {
        List<BookingDTO> list = new ArrayList<>();
        Date date = new Date();
        String d = Service.sdfDateTime.format(date);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select b.bookingID, b.studentID, b.freeSlotID, f.subjectCode, f.startTime, f.endTime\n"
                + "from Bookings b\n"
                + "join FreeSlots f on f.freeSlotID = b.freeSlotID\n"
                + "where b.status = 1 and f.endTime < ?");
        stm.setString(1, d);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            BookingDTO b = new BookingDTO();
            b.setBookingID(rs.getString("bookingID"));
            b.setStudentID(rs.getString("studentID"));
            b.setFreeSlotID(rs.getString("freeSlotID"));
            b.setSubjectCode(rs.getString("subjectCode"));
            b.setStatus(rs.getInt("status"));
            b.setStartTime(rs.getString("startTime"));
            b.setEndTime(rs.getString("endTime"));
            list.add(b);
        }
        con.close();
        return list;
    }

}
