package sample.requests;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.users.UserDTO;
import sample.utils.DBUtils;

public class RequestDAO implements Serializable {

    private final String CREATE_REQUEST = "INSERT INTO Requests \n"
            + "            (freeSlotID, studentID, status, description, subjectCode) \n"
            + "            values(?, ?, ?, ?, ?)";

    private final String SEARCH_REQUESTS = "SELECT r.requestID, fs.freeSlotID, fs.semesterID, r.studentID, u.userName, r.subjectCode, fs.startTime, fs.endTime, r.description\n"
            + "                       FROM Requests r\n"
            + "            			JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "                        JOIN Users u on r.studentID = u.userID\n"
            + "                        WHERE fs.lecturerID = ? and r.status = ?";

    private final String SEARCH_REQUEST_BY_ST_ET_FOR_LEC = "SELECT r.requestID, fs.semesterID, r.freeSlotID, r.studentID, u.userName, r.subjectCode, fs.startTime, fs.endTime, r.description\n"
            + "            FROM Requests r\n"
            + "            JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u on r.studentID = u.userID\n"
            + "            WHERE fs.lecturerID = ? AND r.status = 2 AND fs.startTime >= ? AND fs.endTime <= ? AND fs.semesterID = ?";

    private final String SEARCH_REQUEST_BY_ALL_FOR_LEC = "SELECT r.requestID, fs.semesterID, r.freeSlotID, r.studentID, u.userName, r.subjectCode, fs.startTime, fs.endTime, r.description\n"
            + "            FROM Requests r\n"
            + "            JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u on r.studentID = u.userID\n"
            + "            WHERE fs.lecturerID = ? AND r.status = 2 AND fs.startTime >= ? AND fs.endTime <= ? AND fs.semesterID = ? AND r.subjectCode = ?";

    private final String SEARCH_REQUEST_BY_SUBCODE_FOR_LEC = "SELECT r.requestID, fs.semesterID, r.freeSlotID, r.studentID, u.userName, r.subjectCode, fs.startTime, fs.endTime, r.description\n"
            + "            FROM Requests r\n"
            + "            JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u on r.studentID = u.userID\n"
            + "            WHERE fs.lecturerID = ? AND r.status = 2 AND fs.semesterID = ? AND r.subjectCode = ?";

    private final String SEARCH_REQUEST_BY_NULL_FOR_LEC = "SELECT r.requestID, r.freeSlotID, r.studentID, u.userName, r.subjectCode, fs.startTime, fs.endTime, r.description \n"
            + "            FROM Requests r\n"
            + "            JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u on r.studentID = u.userID\n"
            + "            WHERE fs.lecturerID = ? AND r.status = 2 AND fs.semesterID = ?";

    private final String ACCEPT_REQUEST = "UPDATE Requests\n"
            + "SET status = ?\n"
            + "WHERE requestID = ? and status = 2";

    private final String DELETE_REQUEST = "UPDATE Requests\n"
            + "SET status = ?\n"
            + "WHERE requestID = ?";

    private final String CHECK_TIME_DUPLICATE = "SELECT r.requestID\n"
            + "FROM Requests r\n"
            + "WHERE r.lecturerID = ? \n"
            + "AND ? BETWEEN r.startTime AND r.endTime\n"
            + "AND r.status = ?";

    private final String CHECK_TIME_DUPLICATE_FS = "SELECT fs.freeSlotID\n"
            + "FROM FreeSlots fs\n"
            + "WHERE fs.lecturerID = ? \n"
            + "AND ? BETWEEN fs.startTime AND fs.endTime\n"
            + "AND fs.status = ?";

    private final String SEARCH_REQUEST_BY_STATUS = "SELECT r.requestID, fs.semesterID, r.freeSlotID, r.subjectCode, fs.lecturerID, u.userName, fs.startTime, fs.endTime, r.description, r.note\n"
            + "                        FROM Requests r \n"
            + "            			JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            			JOIN Users u ON fs.lecturerID = u.userID\n"
            + "                        WHERE r.studentID = ? AND r.status = ? AND fs.semesterID = ?\n"
            + "                        ORDER BY r.ID DESC";

    private final String SEARCH_REQUEST_BY_SUBCODE_AND_STATUS = "SELECT r.requestID, r.freeSlotID, r.subjectCode, fs.lecturerID, u.userName, fs.startTime, fs.endTime, r.status, r.description, r.note\n"
            + "            FROM Requests r \n"
            + "			JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "                       JOIN Users u ON fs.lecturerID = u.userID\n"
            + "            WHERE r.studentID = ? AND r.subjectCode = ? AND r.status = ? AND fs.semesterID = ?\n"
            + "            ORDER BY r.ID DESC";

    private final String SEARCH_ALL_REQUEST = "SELECT r.requestID, r.freeSlotID, r.subjectCode, fs.lecturerID, u.userName, fs.startTime, fs.endTime, r.status, r.description, r.note\n"
            + "FROM Requests r \n"
            + "JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "JOIN Users u ON fs.lecturerID = u.userID\n"
            + "WHERE r.studentID = ? AND fs.semesterID = ?\n"
            + "ORDER BY r.ID DESC";

    private final String LIST_ALL_REQUEST = "SELECT r.requestID, r.freeSlotID, fs.semesterID, r.note, r.subjectCode, fs.lecturerID, u.userName, fs.startTime, fs.endTime, r.status, r.description\n"
            + "                        FROM Requests r\n"
            + "                        JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "                    JOIN Users u ON fs.lecturerID = u.userID\n"
            + "                        WHERE r.studentID = ?\n"
            + "                        ORDER BY r.ID DESC";

    private final String SEARCH_ALL_REQUEST_BY_SUBCODE = "SELECT r.requestID, r.freeSlotID, r.subjectCode, fs.lecturerID, u.userName, fs.startTime, fs.endTime, r.status, r.description, r.note\n"
            + "            FROM Requests r \n"
            + "			JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "            JOIN Users u ON fs.lecturerID = u.userID\n"
            + "            WHERE r.studentID = ? AND r.subjectCode = ? AND fs.semesterID = ?\n"
            + "            ORDER BY r.ID DESC";

    private final String UPDATE_NOTE_REQUEST = "UPDATE [dbo].[Requests]\n"
            + "   SET [note] = ?\n"
            + " WHERE requestID = ?";

    private final String DELETE_REQUEST_STATUS = "DELETE FROM [dbo].[Requests]\n" +
"      WHERE requestID = ?";
    
    private final String UPDATE_STATUS_OUTDATE = "UPDATE [dbo].[Requests]\n"
            + "SET [status] = 3\n"
            + "WHERE requestID IN (SELECT r.requestID\n"
            + "					FROM Requests r\n"
            + "					JOIN FreeSlots fs ON r.freeSlotID = fs.freeSlotID\n"
            + "					WHERE fs.startTime < ? ) ";

    private final String UPDATE_STATUS_DUPLICATE_ACP_REQUEST = "UPDATE Requests\n" +
"SET status = 0 \n" +
"FROM Requests r\n" +
"JOIN (SELECT r1.requestID FROM Requests r1\n" +
"       JOIN FreeSlots fs ON r1.freeSlotID = fs.freeSlotID\n" +
"       WHERE r1.status = 2 AND r1.studentID = ?\n" +
"       AND ((? BETWEEN fs.startTime AND fs.endTime) OR (? BETWEEN fs.startTime AND fs.endTime))) re ON re.requestID = r.requestID\n" +
"WHERE r.requestID = Re.requestID";
    
//    private final String CHECK_TIMETABLE_DUPLICATE1 = "DECLARE @DayOfWeek VARCHAR(15)\n"
//            + "SET @DayOfWeek = DATENAME(dw, ?)\n"
//            + "SELECT s.slotID\n"
//            + "FROM Slots s\n"
//            + "JOIN (SELECT tb.slotID, s.startDay, s.endDay\n"
//            + "		FROM Timetables tb\n"
//            + "		JOIN Semesters s\n"
//            + "		ON tb.semesterID = s.semesterID\n"
//            + "		WHERE tb.semesterID = ? \n"
//            + "		AND tb.lecturerID = ?) t\n"
//            + "ON s.slotID = t.slotID\n"
//            + "WHERE (s.day1 like @DayOfWeek  + '%' OR s.day2 like @DayOfWeek )\n"
//            + "AND ? BETWEEN t.startDay AND t.endDay\n"
//            + "AND ? BETWEEN s.starttime AND s.endtime";

    private final String CHECK_TIMETABLE_DUPLICATE = "DECLARE @DayOfWeek VARCHAR(15)\n"
            + "SET @DayOfWeek = DATENAME(dw, ?)\n"
            + "SELECT s.slotID\n"
            + "FROM Slots s\n"
            + "JOIN (SELECT tb.slotID, s.startDay, s.endDay\n"
            + "		FROM Timetables tb\n"
            + "		JOIN Semesters s\n"
            + "		ON tb.semesterID = s.semesterID\n"
            + "		WHERE tb.semesterID = ? \n"
            + "		AND tb.lecturerID = ?) t\n"
            + "ON s.slotID = t.slotID\n"
            + "WHERE (s.day1 like @DayOfWeek  + '%' OR s.day2 like @DayOfWeek )\n"
            + "AND ? BETWEEN t.startDay AND t.endDay\n"
            + "AND ? BETWEEN s.starttime AND s.endtime";

    public boolean createARequest(RequestDTO requestDTO) throws SQLException, ClassNotFoundException, ParseException {
        boolean checkCreate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CREATE_REQUEST);
            stm.setString(1, requestDTO.getFreeSlotID());
            stm.setString(2, requestDTO.getStudentID());
            stm.setInt(3, requestDTO.getStatus());
            stm.setNString(4, requestDTO.getDescription());
            stm.setNString(5, requestDTO.getSubjectCode());
            result = stm.executeUpdate();
            if (result > 0) {
                checkCreate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkCreate;
    }

    private List<RequestDTO> listRequests;

    public List<RequestDTO> getListRequests() {
        return listRequests;
    }

    public void getRequest(String userID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_REQUESTS);
            stm.setString(1, userID);
            stm.setInt(2, 2);
            rs = stm.executeQuery();
            while (rs.next()) {
                String requestID = rs.getString("requestID");
                String semesterID = rs.getString("semesterID");
                String studentID = rs.getString("studentID");
                String studentName = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String description = rs.getNString("description");
                String freeSlotID = rs.getString("freeSlotID");
                RequestDTO requestDTO = new RequestDTO(requestID, studentID, subjectCode, freeSlotID, description, studentName, starts, ends, semesterID);
                if (this.listRequests == null) {
                    this.listRequests = new ArrayList<>();
                }
                this.listRequests.add(requestDTO);
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

    public boolean acceptARequest(String requestID) throws ClassNotFoundException, SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(ACCEPT_REQUEST);
            stm.setInt(1, 1);
            stm.setString(2, requestID);
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    public boolean deleteARequest(String requestID) throws ClassNotFoundException, SQLException {
        boolean checkDelete = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(DELETE_REQUEST);
            stm.setInt(1, 0);
            stm.setString(2, requestID);
            result = stm.executeUpdate();
            if (result > 0) {
                checkDelete = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkDelete;
    }

    public boolean updateNoteRequest(String note, String requestID) throws ClassNotFoundException, SQLException, ParseException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result = 0;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(UPDATE_NOTE_REQUEST);
            stm.setNString(1, note);
            stm.setString(2, requestID);
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    public boolean updateStatusOutDate(Date currentTime) throws ClassNotFoundException, SQLException, ParseException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result = 0;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(UPDATE_STATUS_OUTDATE);
            stm.setTimestamp(1, new Timestamp(currentTime.getTime()));
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }
    
    public boolean deleteRequestStatus(String requestID) throws ClassNotFoundException, SQLException, ParseException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result = 0;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(DELETE_REQUEST_STATUS);
            stm.setString(1, requestID);
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    public boolean updateStatusDuplicateAcceptedRequest(String studentID, String startTime, String endTime) throws ClassNotFoundException, SQLException, ParseException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result = 0;
        System.out.println("updateStatusDuplicateAcceptedRequest");
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(UPDATE_STATUS_DUPLICATE_ACP_REQUEST);
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeF = simpleDateFormat.parse(startTime);
                Date endTimeF = simpleDateFormat.parse(endTime);

                stm.setString(1, studentID);
                stm.setTimestamp(2, new Timestamp(startTimeF.getTime()));
                stm.setTimestamp(3, new Timestamp(endTimeF.getTime()));
            result = stm.executeUpdate();
            System.out.println("sdsas");
            if (result > 0) {
                checkUpdate = true;
                System.out.println("dasd");
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    public boolean checkTimeDuplicateInRequest(String lecturerID, Date date) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIME_DUPLICATE);
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

//    public boolean checkTimetableDuplicate1(Date date, String semesterID, String lecturerID) throws ClassNotFoundException, SQLException {
//        boolean check = true;
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        try {
//            con = DBUtils.getConnection();
//            stm = con.prepareStatement(CHECK_TIMETABLE_DUPLICATE);
//            stm.setTimestamp(1, new Timestamp(date.getTime()));
//            stm.setString(2, semesterID);
//            stm.setString(3, lecturerID);
//            stm.setDate(4, new java.sql.Date(date.getTime()));
//            stm.setTime(5, new Time(date.getTime()));
//            rs = stm.executeQuery();
//            if (rs.next()) {
//                check = false;
//            }
//        } finally {
//            if (stm != null) {
//                stm.close();
//            }
//            if (con != null) {
//                con.close();
//            }
//        }
//        return check;
//    }
//
//    public boolean checkTimetableDuplicate2(Date date, String semesterID, String lecturerID) throws ClassNotFoundException, SQLException {
//        boolean check = true;
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        try {
//            con = DBUtils.getConnection();
//            stm = con.prepareStatement(CHECK_TIMETABLE_DUPLICATE);
//            stm.setTimestamp(1, new Timestamp(date.getTime()));
//            stm.setString(2, semesterID);
//            stm.setString(3, lecturerID);
//            stm.setTimestamp(4, new Timestamp(date.getTime()));
//            stm.setTimestamp(5, new Timestamp(date.getTime()));
//            rs = stm.executeQuery();
//            if (rs.next()) {
//                check = false;
//            }
//        } finally {
//            if (stm != null) {
//                stm.close();
//            }
//            if (con != null) {
//                con.close();
//            }
//        }
//        return check;
//    }
    public boolean checkTimetableDuplicate(Date date, String semesterID, String lecturerID) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CHECK_TIMETABLE_DUPLICATE);
            stm.setTimestamp(1, new Timestamp(date.getTime()));
            System.out.println(new Timestamp(date.getTime()));
            stm.setString(2, semesterID);
            stm.setString(3, lecturerID);
            stm.setTimestamp(4, new Timestamp(date.getTime()));
            stm.setTime(5, new Time(date.getTime())); // Set as java.sql.Time
            System.out.println(new Time(date.getTime()));
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

    private List<RequestDTO> requestByStatus;

    public List<RequestDTO> getRequestByStatus() {
        return requestByStatus;
    }

    public void getRequestByStatus(String studentID, int status, String semesterID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_REQUEST_BY_STATUS);
            stm.setString(1, studentID);
            stm.setInt(2, status);
            stm.setString(3, semesterID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String subjectCode = rs.getString("subjectCode");//4
                String requestID = rs.getString("requestID");//1
                String lecturerID = rs.getString("lecturerID");//5
                String lecName = rs.getNString("userName");//6
                Date startTime = rs.getTimestamp("startTime");//7
                Date endTime = rs.getTimestamp("endTime");//8
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String freeSlotID = rs.getString("freeSlotID");//2
                String note = rs.getNString("note");//3
                String description = rs.getNString("description");//10
                RequestDTO requestDTO = new RequestDTO(requestID, note, status, subjectCode, freeSlotID, description, starts, ends, lecturerID, lecName, semesterID);
                if (this.requestByStatus == null) {
                    this.requestByStatus = new ArrayList<>();
                }
                this.requestByStatus.add(requestDTO);
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

    private List<RequestDTO> requestBySubCodeAndStatus;

    public List<RequestDTO> getRequestBySubCodeAndStatus() {
        return requestBySubCodeAndStatus;
    }

    public void getRequestBySubCodeAndStatus(String studentID, String subjectCode, int status, String semesterID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_REQUEST_BY_SUBCODE_AND_STATUS);
            stm.setString(1, studentID);
            stm.setString(2, subjectCode);
            stm.setInt(3, status);
            stm.setString(4, semesterID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String requestID = rs.getString("requestID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String freeSlotID = rs.getString("freeSlotID");
                String note = rs.getNString("note");
                String description = rs.getNString("description");
                RequestDTO requestDTO = new RequestDTO(requestID, note, status, subjectCode, freeSlotID, description, starts, ends, lecturerID, lecName, semesterID);
                if (this.requestBySubCodeAndStatus == null) {
                    this.requestBySubCodeAndStatus = new ArrayList<>();
                }
                this.requestBySubCodeAndStatus.add(requestDTO);
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

    private List<RequestDTO> allRequest;

    public List<RequestDTO> getAllRequest() {
        return allRequest;
    }

    public void getAllRequest(String studentID, String semesterID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_ALL_REQUEST);
            stm.setString(1, studentID);
            stm.setString(2, semesterID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String requestID = rs.getString("requestID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                int status = rs.getInt("status");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String freeSlotID = rs.getString("freeSlotID");
                String note = rs.getNString("note");
                String description = rs.getNString("description");
                RequestDTO requestDTO = new RequestDTO(requestID, note, status, subjectCode, freeSlotID, description, starts, ends, lecturerID, lecName, semesterID);
                UserDTO userDTO = new UserDTO(lecturerID, lecName, "", 1, "", "");
                if (this.allRequest == null) {
                    this.allRequest = new ArrayList<>();
                }
                this.allRequest.add(requestDTO);
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
    private List<RequestDTO> listRequest;

    public List<RequestDTO> getListRequest() {
        return listRequest;
    }

    public void getListRequest(String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(LIST_ALL_REQUEST);
            stm.setString(1, studentID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String requestID = rs.getString("requestID");//1
                String semesterID = rs.getString("semesterID");//3
                String lecturerID = rs.getString("lecturerID");//6
                String lecName = rs.getNString("userName");//7
                String note = rs.getNString("note");//4
                String subjectCode = rs.getString("subjectCode");//5
                int status = rs.getInt("status");//10
                Date startTime = rs.getTimestamp("startTime");//8
                Date endTime = rs.getTimestamp("endTime");//9
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String freeSlotID = rs.getString("freeSlotID");//2
                String description = rs.getNString("description");//2
                RequestDTO requestDTO = new RequestDTO(requestID, note, status, subjectCode, freeSlotID, description, starts, ends, lecturerID, lecName, semesterID);
                if (this.listRequest == null) {
                    this.listRequest = new ArrayList<>();
                }
                this.listRequest.add(requestDTO);
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

    private List<RequestDTO> allRequestBySubCode;

    public List<RequestDTO> getAllRequestBySubCode() {
        return allRequestBySubCode;
    }

    public void getAllRequestBySubCode(String studentID, String subjectCode, String semesterID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_ALL_REQUEST_BY_SUBCODE);
            stm.setString(1, studentID);
            stm.setString(2, subjectCode);
            stm.setString(3, semesterID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String requestID = rs.getString("requestID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                int status = rs.getInt("status");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String freeSlotID = rs.getString("freeSlotID");
                String description = rs.getNString("description");
                String note = rs.getNString("note");
                RequestDTO requestDTO = new RequestDTO(requestID, note, status, subjectCode, freeSlotID, description, starts, ends, lecturerID, lecName, semesterID);
                if (this.allRequestBySubCode == null) {
                    this.allRequestBySubCode = new ArrayList<>();
                }
                this.allRequestBySubCode.add(requestDTO);
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

    private static String convertDateToString(Timestamp sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }

    public List<RequestDTO> searchRequestViewByStEt(String startTime, String endTime, String userID, String semesterID) throws SQLException, ClassNotFoundException, ParseException {
        List<RequestDTO> searchRequestList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_REQUEST_BY_ST_ET_FOR_LEC);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setString(1, userID);
                ptm.setTimestamp(2, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(3, new Timestamp(endTimeFS.getTime()));
                ptm.setString(4, semesterID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String requestID = rs.getString("requestID");
                    String studentID = rs.getString("studentID");
                    String studentName = rs.getNString("userName");
                    String subjectCode = rs.getString("subjectCode");
                    Date startT = rs.getTimestamp("startTime");
                    Date endT = rs.getTimestamp("endTime");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String starts = dateFormat.format(startT);
                    String ends = dateFormat.format(endT);
                    String description = rs.getNString("description");
                    String freeSlotID = rs.getString("freeSlotID");
                    RequestDTO requestDTO = new RequestDTO(requestID, studentID,
                            subjectCode, freeSlotID, description, studentName, starts, ends, semesterID);
                    searchRequestList.add(requestDTO);
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
        return searchRequestList;
    }

    public List<RequestDTO> searchRequestByAll(String subjectCode, String startTime, String endTime, String userID, String semesterID) throws SQLException, ClassNotFoundException, ParseException {

        List<RequestDTO> searchRequestList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_REQUEST_BY_ALL_FOR_LEC);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date startTimeFS = simpleDateFormat.parse(startTime);
                Date endTimeFS = simpleDateFormat.parse(endTime);

                ptm.setString(1, userID);
                ptm.setTimestamp(2, new Timestamp(startTimeFS.getTime()));
                ptm.setTimestamp(3, new Timestamp(endTimeFS.getTime()));
                ptm.setString(4, semesterID);
                ptm.setString(5, subjectCode);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String requestID = rs.getString("requestID");
                    String freeSlotID = rs.getString("requestID");
                    String studentID = rs.getString("studentID");
                    String studentName = rs.getNString("userName");
                    Date startT = rs.getDate("startTime");
                    Date endT = rs.getTimestamp("endTime");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String starts = dateFormat.format(startT);
                    String ends = dateFormat.format(endT);
                    String description = rs.getNString("description");
                    RequestDTO requestDTO = new RequestDTO(requestID, studentID,
                            subjectCode, freeSlotID, description, studentName, starts, ends, semesterID);
                    searchRequestList.add(requestDTO);
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
        return searchRequestList;
    }

    public List<RequestDTO> searchRequestBySubjectCode(String subjectCode, String userID, String semesterID) throws SQLException, ClassNotFoundException {
        List<RequestDTO> searchRequestList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_REQUEST_BY_SUBCODE_FOR_LEC);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
//                Date startTimeFS = simpleDateFormat.parse(startTime);
//                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setString(1, userID);
                ptm.setString(2, semesterID);
                ptm.setString(3, subjectCode);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String requestID = rs.getString("requestID");
//                String semesterID = rs.getString("semesterID");
                    String studentID = rs.getString("studentID");
                    String studentName = rs.getNString("userName");
//                String subjectCode = rs.getString("subjectCode");
                    Date startTime = rs.getTimestamp("startTime");
                    Date endTime = rs.getTimestamp("endTime");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String starts = dateFormat.format(startTime);
                    String ends = dateFormat.format(endTime);
                    String description = rs.getNString("description");
                    String freeSlotID = rs.getString("freeSlotID");
                    RequestDTO requestDTO = new RequestDTO(requestID, studentID,
                            subjectCode, freeSlotID, description, studentName, starts, ends, semesterID);
                    searchRequestList.add(requestDTO);
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
        return searchRequestList;
    }

    public List<RequestDTO> searchRequestByNull(String userID, String semesterID) throws SQLException, ClassNotFoundException {
        List<RequestDTO> searchRequestList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_REQUEST_BY_NULL_FOR_LEC);
//                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
//                Date startTimeFS = simpleDateFormat.parse(startTime);
//                Date endTimeFS = simpleDateFormat.parse(endTime);
                ptm.setString(1, userID);
                ptm.setString(2, semesterID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String requestID = rs.getString("requestID");
                    String freeSlotID = rs.getString("freeSlotID");
//                String semesterID = rs.getString("semesterID");
                    String studentID = rs.getString("studentID");
                    String studentName = rs.getNString("userName");
                    String subjectCode = rs.getString("subjectCode");
                    Date startTime = rs.getTimestamp("startTime");
                    Date endTime = rs.getTimestamp("endTime");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String starts = dateFormat.format(startTime);
                    String ends = dateFormat.format(endTime);
                    String description = rs.getNString("description");
                    RequestDTO requestDTO = new RequestDTO(requestID, studentID,
                            subjectCode, freeSlotID, description, studentName, starts, ends, semesterID);
                    searchRequestList.add(requestDTO);
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
        return searchRequestList;
    }
}
