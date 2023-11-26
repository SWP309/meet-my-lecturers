/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.viewCreatedSlot;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author PC
 */
public class ViewCreatedSlotDAO {

    private static String CREATED_SLOT_VIEW_COUNT_PAGE = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID, fs.semesterID, fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "FROM FreeSlots fs\n"
            + "JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "LEFT JOIN (\n"
            + "    SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "    FROM Bookings b\n"
            + "    WHERE b.status = 1\n"
            + "    GROUP BY b.freeSlotID\n"
            + ") bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "WHERE fs.status='1' and u1.userEmail = ?\n"
            + "ORDER BY fs.freeSlotID -- Add an order by clause for consistency\n"
            + "OFFSET ? ROW\n"
            + "FETCH NEXT 6 ROWS ONLY;";

    private static String CREATED_SLOT_VIEW = "	SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID, fs.semesterID, fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "FROM FreeSlots fs\n"
            + "JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "LEFT JOIN (\n"
            + "    SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "    FROM Bookings b\n"
            + "    WHERE b.status = 1\n"
            + "    GROUP BY b.freeSlotID\n"
            + ") bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "WHERE fs.status='1' and u1.userEmail = ?\n"
            + "ORDER BY fs.freeSlotID\n";

    private static String COUNT_PAGE = "SELECT CEILING(CAST(COUNT(*) AS float) / 5) AS page_count -- Change the divisor to the desired number of items per page\n"
            + "	FROM FreeSlots fs\n"
            + "	JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "	LEFT JOIN (\n"
            + "		SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "		FROM Bookings b\n"
            + "		WHERE b.status = 1\n"
            + "		GROUP BY b.freeSlotID\n"
            + "	) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "	WHERE fs.status='1' and u1.userEmail = ? ";
    private static String CREATED_SLOT_VIEW_SUB = "  SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID ,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "           WHERE fs.status='0' AND u1.userEmail = ?";

    private static String STUDENT_VIEW_SLOT = "	SELECT DISTINCT b.studentID,u.userName AS studentName, fs.startTime, fs.endTime, fs.freeSlotID\n"
            + "           FROM Bookings b\n"
            + "            JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON b.studentID = u.userID\n"
            + "           JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "            WHERE b.status='1' and fs.freeSlotID = ?";
    private static String HIDE_CREATED_SLOT = "UPDATE FreeSlots SET status = 0 WHERE freeSlotID = ?";
    private static String UNHIDE_CREATED_SLOT = "UPDATE FreeSlots SET status = 1 WHERE freeSlotID = ?";

    private static String DELETE_CREATED_SLOT
            = "    DELETE FROM [dbo].[Requests] WHERE freeSlotID = ?;\n"
            + "				   DELETE FROM [dbo].[Bookings] WHERE freeSlotID = ?;\n"
            + "              DELETE FROM [dbo].[FreeSlots] WHERE freeSlotID = ?;";

    private static String UPDATE_CREATED_SLOT
            = "UPDATE FreeSlots \n"
            + "SET startTime = ?, \n"
            + "    endTime = ?, \n"
            + "    subjectCode = ? \n"
            + "WHERE freeSlotID = ? ";
    private static String SEARCH_FREE_SLOT_BY_ALL = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "		  where fs.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.subjectCode = ? and u1.userEmail = ? and fs.semesterID = ?";
    private static String SEARCH_FREE_SLOT_BY_ST_ET_SUBJECTCODE = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "		  where fs.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.subjectCode = ? and u1.userEmail = ?";
    private static String SEARCH_FREE_SLOT_BY_ST_ET_SEMESTER = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "		  where fs.status='1' and fs.startTime >= ? and fs.endTime <= ? and fs.semesterID = ? and u1.userEmail = ?";
    private static String SEARCH_FREE_SLOT_BY_ST_ET = "SELECT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "                       FROM FreeSlots fs\n"
            + "                    JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "					LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.status = 1\n"
            + "						GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "           	  where fs.status='1' and fs.startTime >= ? and fs.endTime <= ? and u1.userEmail = ?";
    private static String SEARCH_FREE_SLOT_BY_SUBJECTCODE = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "		  where  fs.status='1' and fs.subjectCode = ? and u1.userEmail = ?";
    private static String SEARCH_FREE_SLOT_BY_SEMESTER = "SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID,fs.semesterID,fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "           FROM FreeSlots fs\n"
            + "          JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "           LEFT JOIN (SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "              FROM Bookings b\n"
            + "              WHERE b.status = 1\n"
            + "              GROUP BY b.freeSlotID) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "		  where  fs.status='1' and fs.semesterID = ? and u1.userEmail = ?";
    private static String CHECK_ATTENDANCE_CREATE_SLOT = "UPDATE FreeSlots SET status = 2 WHERE freeSlotID = ?";

    private static String CHECK_TIME_DUPLICATE_FS = " SELECT DISTINCT fs.subjectCode, u1.userName AS lectureName, fs.startTime, fs.endTime, fs.freeSlotID, fs.semesterID, fs.meetLink, bo.[Number of students], fs.capacity\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users u1 ON fs.lecturerID = u1.userID\n"
            + "            LEFT JOIN (\n"
            + "                SELECT freeSlotID, COUNT(*) AS 'Number of students'\n"
            + "                FROM Bookings b\n"
            + "                WHERE b.status = 1\n"
            + "                GROUP BY b.freeSlotID\n"
            + "            ) bo ON fs.freeSlotID = bo.freeSlotID\n"
            + "            WHERE fs.status='1' and u1.userEmail = ?  AND ? BETWEEN fs.startTime AND fs.endTime\n"
            + "            ORDER BY fs.freeSlotID";

    private static String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public boolean checkTimeDuplicateInFreeSlot(String userEmail, Date date) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE_FS);
            stm.setString(1, userEmail);
            stm.setTimestamp(2, new Timestamp(date.getTime()));
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

    public boolean checkAttendance(String freeSlotID) throws SQLException {
        boolean checkAttendanceFS = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_ATTENDANCE_CREATE_SLOT);
                ptm.setString(1, freeSlotID);
                checkAttendanceFS = ptm.executeUpdate() > 0 ? true : false;
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
        return checkAttendanceFS;
    }

    private Timestamp convertStringToTimestamp(String dateString) throws ParseException {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date parsedDate = dateFormat.parse(dateString);
            return new java.sql.Timestamp(parsedDate.getTime());
        } catch (ParseException e) {
            // Ghi log lỗi
            System.out.println("Lỗi định dạng ngày giờ: " + e.getMessage());
            // Hoặc ném ngoại lệ để thông báo về lỗi định dạng không hợp lệ
            throw new ParseException("Lỗi định dạng ngày giờ không hợp lệ: " + e.getMessage(), e.getErrorOffset());
        }
    }

    public List<ViewCreatedSlotDTO> GetlistCreatedSlotByCount(String userEmail, int countpage) throws SQLException {
        List<ViewCreatedSlotDTO> listCreatedSlotSub = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATED_SLOT_VIEW_COUNT_PAGE);
                ptm.setString(1, userEmail);
                ptm.setInt(2, countpage);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(endTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    String semesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    listCreatedSlotSub.add(new ViewCreatedSlotDTO(subjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, semesterID, meetLink, joinedMembers, capacity));
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
        return listCreatedSlotSub;
    }

    public List<ViewCreatedSlotDTO> GetlistCreatedSlot(String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> listCreatedSlotSub = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATED_SLOT_VIEW);
                ptm.setString(1, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(endTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    String semesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    listCreatedSlotSub.add(new ViewCreatedSlotDTO(subjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, semesterID, meetLink, joinedMembers, capacity));
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
        return listCreatedSlotSub;
    }

    public int CountPage(String userEmail) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        int pagecount = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(COUNT_PAGE);
                ptm.setString(1, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    pagecount = rs.getInt("page_count");
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

        return pagecount;
    }

    public List<ViewCreatedSlotDTO> GetlistCreatedSlotSub(String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> listCreatedSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATED_SLOT_VIEW_SUB);
                ptm.setString(1, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(endTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    String semesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    listCreatedSlot.add(new ViewCreatedSlotDTO(subjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, semesterID, meetLink, joinedMembers, capacity));
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
        return listCreatedSlot;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewByAll(String subjectCode, String startTime, String endTime, String userEmail, String semesterID) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_ALL);
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
                    String freeSlotID = rs.getString("freeSlotID");
                    String fetchedSemesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    searchFSlotList.add(new ViewCreatedSlotDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, fetchedSemesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewByStEtSubjectCode(String subjectCode, String startTime, String endTime, String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_ST_ET_SUBJECTCODE);
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
                    String freeSlotID = rs.getString("freeSlotID");
                    String fetchedSemesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    searchFSlotList.add(new ViewCreatedSlotDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, fetchedSemesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewByStEtSemesterID(String semesterID, String startTime, String endTime, String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_ST_ET_SEMESTER);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setTimestamp(1, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTimeFS.getTime()));
                ptm.setString(3, semesterID);
                ptm.setString(4, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String fetchedSubjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    String fetchedSemesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    searchFSlotList.add(new ViewCreatedSlotDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, fetchedSemesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewByStEt(String startTime, String endTime, String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_ST_ET);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setTimestamp(1, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTimeFS.getTime()));
                ptm.setString(3, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String SubjectCode = rs.getString("subjectCode");
                    String lectureName = rs.getString("lectureName");
                    Timestamp fetchedStartTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(fetchedStartTime);
                    Timestamp fetchedEndTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(fetchedEndTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    String semesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");

                    searchFSlotList.add(new ViewCreatedSlotDTO(SubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, semesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewBySubjectCode(String subjectCode, String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_SUBJECTCODE);
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
                    String freeSlotID = rs.getString("freeSlotID");
                    String semesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    searchFSlotList.add(new ViewCreatedSlotDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, semesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<ViewCreatedSlotDTO> searchFSlotViewBySemesterID(String semesterID, String userEmail) throws SQLException {
        List<ViewCreatedSlotDTO> searchFSlotList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_FREE_SLOT_BY_SEMESTER);
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
                    String freeSlotID = rs.getString("freeSlotID");
                    String fetchedSemesterID = rs.getString("semesterID");
                    String meetLink = rs.getString("meetLink");
                    int joinedMembers = rs.getInt("Number of students");
                    int capacity = rs.getInt("capacity");
                    searchFSlotList.add(new ViewCreatedSlotDTO(fetchedSubjectCode, lectureName, startTimeStr, endTimeStr, freeSlotID, fetchedSemesterID, meetLink, joinedMembers, capacity));
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
        return searchFSlotList;
    }

    public List<StudentViewSlotDTO> GetListStudent(String userEmail) throws SQLException {
        List<StudentViewSlotDTO> liststudent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STUDENT_VIEW_SLOT);
                ptm.setString(1, userEmail);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String studentID = rs.getString("studentID");
                    String studentName = rs.getString("studentName");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String startTimeStr = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String endTimeStr = convertDateToString(endTime);
                    String freeSlotID = rs.getString("freeSlotID");
                    liststudent.add(new StudentViewSlotDTO(studentID, studentName, startTimeStr, endTimeStr, userEmail, freeSlotID));
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
        return liststudent;
    }

    public boolean Hide(String freeSlotID) throws SQLException {
        boolean CheckHide = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(HIDE_CREATED_SLOT);
                ptm.setString(1, freeSlotID);
                CheckHide = ptm.executeUpdate() > 0 ? true : false;
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
        return CheckHide;
    }

  

    public boolean UnHide(String freeSlotID) throws SQLException {
        boolean CheckUnhide = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UNHIDE_CREATED_SLOT);
                ptm.setString(1, freeSlotID);
                CheckUnhide = ptm.executeUpdate() > 0 ? true : false;
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
        return CheckUnhide;
    }

    public boolean Delete(String freeSlotID) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_CREATED_SLOT);
                ptm.setString(1, freeSlotID);
                ptm.setString(2, freeSlotID);
                ptm.setString(3, freeSlotID);
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

    public boolean update(ViewCreatedSlotDTO listCreatedSlot) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            Date startTime = simpleDateFormat.parse(listCreatedSlot.getStartTime());
            Date endTime = simpleDateFormat.parse(listCreatedSlot.getEndTime());
            conn = DBUtils.getConnection();
            if (conn != null) {
                System.out.println("chay vao dc ham if");
                ptm = conn.prepareStatement(UPDATE_CREATED_SLOT);
                ptm.setTimestamp(1, new Timestamp(startTime.getTime()));
                ptm.setTimestamp(2, new Timestamp(endTime.getTime()));
                ptm.setString(3, listCreatedSlot.getSubjectCode());
                ptm.setString(4, listCreatedSlot.getFreeSlotID());
                checkUpdate = ptm.executeUpdate() > 0;
                System.out.println(checkUpdate);
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
        return checkUpdate;
    }

}
