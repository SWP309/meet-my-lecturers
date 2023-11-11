/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

import java.text.ParseException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import sample.bookings.BookingDAO;
import sample.utils.DBUtils;

/**
 *
 * @author W10(hiep-tm)
 */
public class FreeSlotsDAO {

    private final static String CHECK_SEMESTERID = "SELECT semesterID FROM Semesters WHERE semesterID = ?";
    private final static String CHECK_SUBJECTCODE = "SELECT subjectCode FROM Subjects WHERE subjectCode = ?";
    private final static String CHECK_BLOCKLIST = "SELECT block_list FROM FreeSlots WHERE block_list LIKE CONCAT('%', ?, '%')";
    private final String CHECK_TIME_DUPLICATE_FS = "SELECT fs.freeSlotID\n"
            + "FROM FreeSlots fs\n"
            + "WHERE fs.lecturerID = ? \n"
            + "AND ? BETWEEN fs.startTime AND fs.endTime\n"
            + "AND fs.status = ?";
    private final static String CREATE_FREESLOT = "INSERT INTO "
            + "FreeSlots(subjectCode,startTime,endTime,password,capacity,meetLink,count,lecturerID,status,semesterID,block_list) "
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private final static String CHECK_DUPLICATE_GGMEETLINK = "SELECT freeSlotID "
            + "FROM FreeSlots WHERE meetLink=?";
    private final static String SEARCH_FREESLOT_BY_SUBJECTCODE = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "					FROM FreeSlots fs\n"
            + "					JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "					WHERE fs.subjectCode = ? AND fs.status = 1 \n"
            + "					AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "								FROM Bookings b\n"
            + "								WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_LECTURERID = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "			JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.lecturerID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_LECNAME = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE lec.userName LIKE ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SEMESTERID = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SUBJECT_AND_LECID = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND fs.lecturerID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SUBJECT_AND_LECNAME = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND lec.userName LIKE ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SUBJECT_AND_SEMESTER = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_LECID_AND_SEMESTER = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.lecturerID = ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_LECNAME_AND_SEMESTER = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE lec.userName LIKE ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SUBCODE_AND_LECID_AND_SEMESTER = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND fs.lecturerID = ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_SUBCODE_AND_LECNAME_AND_SEMESTER = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND lec.userName LIKE ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT_BY_ALL = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.subjectCode = ? AND fs.lecturerID = ? AND lec.userName LIKE ? AND fs.semesterID = ? AND fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";
    private final static String SEARCH_FREESLOT = "SELECT fs.password, fs.freeSlotID, fs.subjectCode, fs.lecturerID, fs.startTime, fs.endTime, fs.capacity, fs.semesterID, lec.userName\n"
            + "            FROM FreeSlots fs\n"
            + "            JOIN Users lec ON fs.lecturerID = lec.userID\n"
            + "            WHERE fs.status = 1\n"
            + "			AND fs.freeSlotID NOT IN (SELECT b.freeSlotID\n"
            + "						FROM Bookings b\n"
            + "						WHERE b.studentID = ? and b.status = 1)";

    private final static String SEARCH_FS_ACCEPT = "SELECT fs.freeSlotID\n"
            + "FROM FreeSlots fs\n"
            + "WHERE fs.startTime = ? AND fs.lecturerID = ? AND fs.status = 1";

    private final static String SEARCH_LECTURER_MAX_FS_IN4 = "SELECT fs.lecturerID, fs.freeSlotID, fs.subjectCode, fs.capacity, fs.startTime, fs.endTime, fs.semesterID\n" +
"            FROM FreeSlots fs\n" +
"            WHERE fs.lecturerID = ? AND fs.status = 1 AND fs.semesterID = ( SELECT s.semesterID\n" +
"            											FROM Semesters s\n" +
"            											WHERE ? BETWEEN s.startDay AND s.endDay)";

    private static BookingDAO bookingDAO = new BookingDAO();

    private static String SEMESTER = "  SELECT DISTINCT fs.semesterID\n"
            + "            FROM [Semesters] fs;";
    private static String SUBJECT = "    SELECT DISTINCT fs.[subjectCode]\n"
            + "            FROM [Subjects] fs;";

    public boolean createFreeSlot(FreeSlotsDTO freeSlotsDTO) throws SQLException {
        boolean checkCreate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
//        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();

            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date startTime = simpleDateFormat.parse(freeSlotsDTO.getStartTime());
            Date endTime = simpleDateFormat.parse(freeSlotsDTO.getEndTime());

            if (conn != null) {
                ps = conn.prepareStatement(CREATE_FREESLOT);
                ps.setString(1, freeSlotsDTO.getSubjectCode());
                ps.setTimestamp(2, new Timestamp(startTime.getTime()));
                ps.setTimestamp(3, new Timestamp(endTime.getTime()));
                ps.setString(4, freeSlotsDTO.getPassword());
                ps.setInt(5, freeSlotsDTO.getCapacity());
                ps.setString(6, freeSlotsDTO.getMeetLink());
                ps.setInt(7, freeSlotsDTO.getCount());
                ps.setString(8, freeSlotsDTO.getLecturerID());
                ps.setInt(9, freeSlotsDTO.getStatus());
                ps.setString(10, freeSlotsDTO.getSemesterID());
                ps.setString(11, freeSlotsDTO.getBlock_list());
                result = ps.executeUpdate();
                if (result > 0) {
                    checkCreate = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
//            if (rs != null) {
//                rs.close();
//            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkCreate;
    }

    public boolean checkDuplicateGGMeet(String meetLink) throws SQLException {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_DUPLICATE_GGMEETLINK);
                ps.setString(1, meetLink);
                rs = ps.executeQuery();
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return exists;
    }

    public List<FreeSlotsDTO> select() throws SQLException, ClassNotFoundException {
        List<FreeSlotsDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from FreeSlots");
        list = new ArrayList<>();
        while (rs.next()) {
            FreeSlotsDTO freeSlots = new FreeSlotsDTO();
            freeSlots.setFreeSlotID(rs.getString("freeSlotID"));
            freeSlots.setSubjectCode(rs.getString("subjectCode"));
            String start = convertTimestampToString(rs.getTimestamp("startTime"));
            freeSlots.setStartTime(start);
            String end = convertTimestampToString(rs.getTimestamp("endTime"));
            freeSlots.setEndTime(end);
            freeSlots.setPassword(rs.getString("password"));
            freeSlots.setCapacity(rs.getInt("capacity"));
            freeSlots.setMeetLink(rs.getString("meetLink"));
            freeSlots.setCount(rs.getInt("count"));
            freeSlots.setLecturerID(rs.getString("lecturerID"));
            list.add(freeSlots);
        }
        con.close();
        return list;
    }

    public FreeSlotsDTO read(int ID) throws SQLException, ClassNotFoundException {
        FreeSlotsDTO freeSlots = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from FreeSlots where ID = ?");
        stm.setInt(1, ID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            freeSlots = new FreeSlotsDTO();
            freeSlots.setFreeSlotID(rs.getString("freeSlotID"));
            freeSlots.setSubjectCode(rs.getString("subjectCode"));
            String start = convertTimestampToString(rs.getTimestamp("startTime"));
            freeSlots.setStartTime(start);
            String end = convertTimestampToString(rs.getTimestamp("endTime"));
            freeSlots.setEndTime(end);
            freeSlots.setPassword(rs.getString("password"));
            freeSlots.setCapacity(rs.getInt("capacity"));
            freeSlots.setMeetLink(rs.getString("meetLink"));
            freeSlots.setCount(rs.getInt("count"));
            freeSlots.setLecturerID(rs.getString("lecturerID"));
        }
        con.close();
        return freeSlots;
    }

    public void create(FreeSlotsDTO freeSlots) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("insert into FreeSlots values(?, ?, ?, ?, ?, ?, ?, ?)");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//        stm.setString(1, freeSlots.getFreeSlotID());
        stm.setString(1, freeSlots.getSubjectCode());
        stm.setString(2, sdf.format(freeSlots.getStartTime()));
        stm.setString(3, sdf.format(freeSlots.getEndTime()));
        stm.setString(4, freeSlots.getPassword());
        stm.setInt(5, freeSlots.getCapacity());
        stm.setString(6, freeSlots.getMeetLink());
        stm.setInt(7, freeSlots.getCount());
        stm.setString(8, freeSlots.getLecturerID());
        int count = stm.executeUpdate();
        con.close();
    }

    public void update(FreeSlotsDTO freeSlots) throws SQLException, ClassNotFoundException, ParseException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("update FreeSlots set subjectCode = ?, startTime = ?, endTime = ?, password = ?, capacity = ?, meetLink = ?, count = ?, lecturer = ?  where ID = ?");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        stm.setString(1, freeSlots.getSubjectCode());
        Date starts = convertStringToTimestamp(freeSlots.getStartTime());
        Date ends = convertStringToTimestamp(freeSlots.getEndTime());
        stm.setTimestamp(3, new Timestamp(starts.getTime()));
        stm.setTimestamp(4, new Timestamp(ends.getTime()));
        stm.setString(4, freeSlots.getPassword());
        stm.setInt(5, freeSlots.getCapacity());
        stm.setString(6, freeSlots.getMeetLink());
        stm.setInt(7, freeSlots.getCount());
        stm.setString(8, freeSlots.getLecturerID());
        int count = stm.executeUpdate();
        con.close();
    }

    public void delete(String freeSlotsID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("delete from FreeSlots where freeSlotID = ? ");
        stm.setString(1, freeSlotsID);
        stm.executeUpdate();
        con.close();
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

    public String convertTimestampToString(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = dateFormat.format(timestamp);
        return dateString;
    }

    public List<FreeSlotsDTO> searchByStudentID(String studentID) throws SQLException, ClassNotFoundException {

        List<FreeSlotsDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from [dbo].[FreeSlots] where studentID = ?");
        stm.setString(1, studentID);
        ResultSet rs = stm.executeQuery();
        list = new ArrayList<>();
        while (rs.next()) {
            FreeSlotsDTO requests = new FreeSlotsDTO();
//            requests.setID(rs.getInt("ID"));
            requests.setFreeSlotID(rs.getString("freeSlotID"));
            requests.setSubjectCode(rs.getString("subjectCode"));
            String start = convertTimestampToString(rs.getTimestamp("startTime"));
            requests.setStartTime(start);
            String end = convertTimestampToString(rs.getTimestamp("endTime"));
            requests.setEndTime(end);
            requests.setPassword(rs.getString("password"));
            requests.setCapacity(rs.getInt("capacity"));
            requests.setMeetLink(rs.getString("meetLink"));
            requests.setCount(rs.getInt("count"));
            requests.setLecturerID(rs.getString("lecturerID"));
            requests.setStatus(rs.getInt("status"));
            list.add(requests);
        }
        con.close();
        return list;
    }

    public List<FreeSlotsDTO> searchByLecturerID(String lecturerID) throws SQLException, ClassNotFoundException {

        List<FreeSlotsDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from [dbo].[FreeSlots] where lecturerID = ?");
        stm.setString(1, lecturerID);
        ResultSet rs = stm.executeQuery();
        list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        while (rs.next()) {
            FreeSlotsDTO requests = new FreeSlotsDTO();
//            requests.setID(rs.getInt("ID"));
            requests.setFreeSlotID(rs.getString("freeSlotID"));
            requests.setSubjectCode(rs.getString("subjectCode"));
            String start = convertTimestampToString(rs.getTimestamp("startTime"));
            requests.setStartTime(start);
            String end = convertTimestampToString(rs.getTimestamp("endTime"));
            requests.setEndTime(end);
            requests.setPassword(rs.getString("password"));
            requests.setCapacity(rs.getInt("capacity"));
            requests.setMeetLink(rs.getString("meetLink"));
            requests.setCount(rs.getInt("count"));
            requests.setLecturerID(rs.getString("lecturerID"));
            requests.setStatus(rs.getInt("status"));
            list.add(requests);
        }
        con.close();
        return list;
    }

    public List<FreeSlotsDTO> searchBySubjectCode(String subjectCode) throws SQLException, ClassNotFoundException {

        List<FreeSlotsDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from [dbo].[FreeSlots] where subjectCode = ?");
        stm.setString(1, subjectCode);
        ResultSet rs = stm.executeQuery();
        list = new ArrayList<>();
        while (rs.next()) {
            FreeSlotsDTO requests = new FreeSlotsDTO();
//            requests.setID(rs.getInt("ID"));
            requests.setFreeSlotID(rs.getString("freeSlotID"));
            requests.setSubjectCode(rs.getString("subjectCode"));
            String start = convertTimestampToString(rs.getTimestamp("startTime"));
            requests.setStartTime(start);
            String end = convertTimestampToString(rs.getTimestamp("endTime"));
            requests.setEndTime(end);
            requests.setPassword(rs.getString("password"));
            requests.setCapacity(rs.getInt("capacity"));
            requests.setMeetLink(rs.getString("meetLink"));
            requests.setCount(rs.getInt("count"));
            requests.setLecturerID(rs.getString("lecturerID"));
            requests.setStatus(rs.getInt("status"));
            list.add(requests);
        }
        con.close();
        return list;
    }

    private List<FreeSlotsDTO> freeSlotBySubjectCode;

    public List<FreeSlotsDTO> getFreeSlotBySubjectCode() {
        return freeSlotBySubjectCode;
    }

    private String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public void getFreeSlotBySubjectCode(String subjectCode, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBJECTCODE);
            stm.setString(1, subjectCode);
            stm.setString(2, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubjectCode == null) {
                    this.freeSlotBySubjectCode = new ArrayList<>();
                }
                this.freeSlotBySubjectCode.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotByLecturerID;

    public List<FreeSlotsDTO> getFreeSlotByLecturerID() {
        return freeSlotByLecturerID;
    }

    public void getFreeSlotByLecturerID(String lecturerID, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_LECTURERID);
            stm.setString(1, lecturerID);
            stm.setString(2, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecname = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                String password = rs.getString("password");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotByLecturerID == null) {
                    this.freeSlotByLecturerID = new ArrayList<>();
                }
                this.freeSlotByLecturerID.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotByLecName;

    public List<FreeSlotsDTO> getFreeSlotByLecName() {
        return freeSlotByLecName;
    }

    public void getFreeSlotByLecName(String name, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_LECNAME);
            stm.setNString(1, "%" + name + "%");
            stm.setString(2, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getString("userName");
                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotByLecName == null) {
                    this.freeSlotByLecName = new ArrayList<>();
                }
                this.freeSlotByLecName.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySemesterID;

    public List<FreeSlotsDTO> getFreeSlotBySemesterID() {
        return freeSlotBySemesterID;
    }

    public void getFreeSlotBySemesterID(String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SEMESTERID);
            stm.setString(1, semester);
            stm.setString(2, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySemesterID == null) {
                    this.freeSlotBySemesterID = new ArrayList<>();
                }
                this.freeSlotBySemesterID.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySubjectAndLecID;

    public List<FreeSlotsDTO> getFreeSlotBySubjectAndLecID() {
        return freeSlotBySubjectAndLecID;
    }

    public void getFreeSlotBySubjectAndLecID(String subjectCode, String lecturerID, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBJECT_AND_LECID);
            stm.setString(1, subjectCode);
            stm.setString(2, lecturerID);
            stm.setString(3, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubjectAndLecID == null) {
                    this.freeSlotBySubjectAndLecID = new ArrayList<>();
                }
                this.freeSlotBySubjectAndLecID.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySubjectAndLecName;

    public List<FreeSlotsDTO> getFreeSlotBySubjectAndLecName() {
        return freeSlotBySubjectAndLecName;
    }

    public void getFreeSlotBySubjectAndLecName(String subjectCode, String name, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBJECT_AND_LECNAME);
            stm.setString(1, subjectCode);
            stm.setString(2, "%" + name + "%");
            stm.setString(3, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubjectAndLecName == null) {
                    this.freeSlotBySubjectAndLecName = new ArrayList<>();
                }
                this.freeSlotBySubjectAndLecName.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySubjectAndSemester;

    public List<FreeSlotsDTO> getFreeSlotBySubjectAndSemester() {
        return freeSlotBySubjectAndSemester;
    }

    public void getFreeSlotBySubjectAndSemester(String subjectCode, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBJECT_AND_SEMESTER);
            stm.setString(1, subjectCode);
            stm.setString(2, semester);
            stm.setString(3, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubjectAndSemester == null) {
                    this.freeSlotBySubjectAndSemester = new ArrayList<>();
                }
                this.freeSlotBySubjectAndSemester.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotByLecIDAndSemester;

    public List<FreeSlotsDTO> getFreeSlotByLecIDAndSemester() {
        return freeSlotByLecIDAndSemester;
    }

    public void getFreeSlotByLecIDAndSemester(String lecturerID, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_LECID_AND_SEMESTER);
            stm.setString(1, lecturerID);
            stm.setString(2, semester);
            stm.setString(3, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotByLecIDAndSemester == null) {
                    this.freeSlotByLecIDAndSemester = new ArrayList<>();
                }
                this.freeSlotByLecIDAndSemester.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotByLecNameAndSemester;

    public List<FreeSlotsDTO> getFreeSlotByLecNameAndSemester() {
        return freeSlotByLecNameAndSemester;
    }

    public void getFreeSlotByLecNameAndSemester(String name, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_LECNAME_AND_SEMESTER);
            stm.setNString(1, "%" + name + "%");
            stm.setString(2, semester);
            stm.setString(3, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotByLecNameAndSemester == null) {
                    this.freeSlotByLecNameAndSemester = new ArrayList<>();
                }
                this.freeSlotByLecNameAndSemester.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySubCodeAndLecIDAndSemester;

    public List<FreeSlotsDTO> getFreeSlotBySubCodeAndLecIDAndSemester() {
        return freeSlotBySubCodeAndLecIDAndSemester;
    }

    public void getFreeSlotBySubCodeAndLecIDAndSemester(String subjectCode, String lecturerID, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBCODE_AND_LECID_AND_SEMESTER);
            stm.setString(1, subjectCode);
            stm.setString(2, lecturerID);
            stm.setString(3, semester);
            stm.setString(4, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String password = rs.getString("password");
//                String lecturerID = rs.getString("lecturerID");    
                String lecname = rs.getNString("userName");
//                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubCodeAndLecIDAndSemester == null) {
                    this.freeSlotBySubCodeAndLecIDAndSemester = new ArrayList<>();
                }
                this.freeSlotBySubCodeAndLecIDAndSemester.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotBySubCodeAndLecNameAndSemester;

    public List<FreeSlotsDTO> getFreeSlotBySubCodeAndLecNameAndSemester() {
        return freeSlotBySubCodeAndLecNameAndSemester;
    }

    public void getFreeSlotBySubCodeAndLecNameAndSemester(String subjectCode, String name, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_SUBCODE_AND_LECNAME_AND_SEMESTER);
            stm.setString(1, subjectCode);
            stm.setNString(2, "%" + name + "%");
            stm.setString(3, semester);
            stm.setString(4, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
//                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotBySubCodeAndLecNameAndSemester == null) {
                    this.freeSlotBySubCodeAndLecNameAndSemester = new ArrayList<>();
                }
                this.freeSlotBySubCodeAndLecNameAndSemester.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotByAll;

    public List<FreeSlotsDTO> getFreeSlotByAll() {
        return freeSlotByAll;
    }

    public void getFreeSlotByAll(String subjectCode, String lecturerID, String name, String semester, String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT_BY_ALL);
            stm.setString(1, subjectCode);
            stm.setString(2, lecturerID);
            stm.setNString(3, "%" + name + "%");
            stm.setString(4, semester);
            stm.setString(5, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String password = rs.getString("password");
//                String lecturerID = rs.getString("lecturerID");    
                String lecname = rs.getNString("userName");
//                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotByAll == null) {
                    this.freeSlotByAll = new ArrayList<>();
                }
                this.freeSlotByAll.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private List<FreeSlotsDTO> freeSlotList;

    public List<FreeSlotsDTO> getFreeSlotList() {
        return freeSlotList;
    }

    public void getFreeSlot(String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FREESLOT);
            stm.setString(1, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String freeSlotID = rs.getString("freeSlotID");
                String lecturerID = rs.getString("lecturerID");
                String password = rs.getString("password");
                String lecname = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Timestamp startTime = rs.getTimestamp("startTime");
                String starts = convertDateToString(startTime);
                Timestamp endTime = rs.getTimestamp("endTime");
                String ends = convertDateToString(endTime);
                int capacity = rs.getInt("capacity");
                String semester = rs.getString("semesterID");
                int bookedStudent = bookingDAO.getBookedStudent(freeSlotID);
                FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO(freeSlotID, subjectCode, starts, ends, password, capacity, "", 0, lecturerID, 1, semester, lecname, bookedStudent);
                if (this.freeSlotList == null) {
                    this.freeSlotList = new ArrayList<>();
                }
                this.freeSlotList.add(freeSlotsDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean checkTimeDuplicateInFreeSlot(String lecturerID, Date date) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE_FS);
            stm.setString(1, lecturerID);
            stm.setTimestamp(2, new Timestamp(date.getTime()));
            stm.setInt(3, 1);
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

    public boolean checkSemesterID(String semesterID) throws SQLException {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_SEMESTERID);
                ps.setString(1, semesterID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return exists;
    }

    public boolean checkSubjectCode(String subjectCode) throws SQLException {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_SUBJECTCODE);
                ps.setString(1, subjectCode);
                rs = ps.executeQuery();
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return exists;
    }

    public String searchFSAccept(String startTime, String lecturerID) throws ClassNotFoundException, SQLException, ParseException {
        String freeSlotID = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_FS_ACCEPT);
            Date starts = convertStringToTimestamp(startTime);
            stm.setTimestamp(1, new Timestamp(starts.getTime()));
            stm.setString(2, lecturerID);
            rs = stm.executeQuery();
            if (rs.next()) {
                freeSlotID = rs.getString("freeSlotID");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return freeSlotID;
    }

    public boolean checkBlockList(String block_list, String freeslotID) throws SQLException {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_BLOCKLIST);
                ps.setString(1, block_list);
                ps.setString(2, freeslotID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return exists;
    }

    public List<FreeSlotsDTO> GetListSemesterID() throws SQLException {
        List<FreeSlotsDTO> listSemester = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEMESTER);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String semesterID = rs.getString("semesterID");
                    listSemester.add(new FreeSlotsDTO(semesterID));
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
        return listSemester;
    }

    public List<FreeSlotsDTO> GetListSubject() throws SQLException {
        List<FreeSlotsDTO> listSubject = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SUBJECT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    listSubject.add(new FreeSlotsDTO(subjectCode));
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
        return listSubject;
    }

    public List<FreeSlotsDTO> getLecturerMaxFSIn4(String lecturerID) throws SQLException, ClassNotFoundException, ParseException {
        List<FreeSlotsDTO> listFreeSlot = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date currentDate = new Date();
                ptm = conn.prepareStatement(SEARCH_LECTURER_MAX_FS_IN4);
                ptm.setString(1, lecturerID);
                String start = services.Service.sdfDateTime.format(currentDate);
                ptm.setTimestamp(2, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
//                ptm.setTimestamp(2, new Timestamp(currentDate.getTime()));
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String freeSlotID = rs.getString("freeSlotID");
                    String subjectCode = rs.getString("subjectCode");
                    int capacity = rs.getInt("capacity");
                    Timestamp startTime = rs.getTimestamp("startTime");
                    String starts = convertDateToString(startTime);
                    Timestamp endTime = rs.getTimestamp("endTime");
                    String ends = convertDateToString(endTime);
                    String semesterID = rs.getString("semesterID");
                    FreeSlotsDTO freeSlotsDTO = new FreeSlotsDTO();
                    freeSlotsDTO.setFreeSlotID(freeSlotID);
                    freeSlotsDTO.setLecturerID(lecturerID);
                    freeSlotsDTO.setCapacity(capacity);
                    freeSlotsDTO.setStartTime(starts);
                    freeSlotsDTO.setEndTime(ends);
                    freeSlotsDTO.setSemesterID(semesterID);
                    freeSlotsDTO.setSubjectCode(subjectCode);
                    listFreeSlot.add(freeSlotsDTO);
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
        return listFreeSlot;
    }

}
