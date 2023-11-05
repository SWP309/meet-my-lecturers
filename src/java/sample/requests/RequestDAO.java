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

    private final String CREATE_REQUEST = "INSERT INTO Requests "
            + "(status, subjectCode, startTime, endTime, description, studentID, lecturerID, semesterID) "
            + "values(?, ?, ?, ?, ?, ?, ?, ?)";

    private final String SEARCH_REQUESTS = "SELECT r.requestID, u.userID, u.userName, r.subjectCode, r.startTime, r.endTime, r.description \n"
            + "FROM Requests r\n"
            + "JOIN Users u on r.studentID = u.userID\n"
            + "WHERE r.lecturerID = ? and r.status = ?";

    private final String ACCEPT_REQUEST = "UPDATE Requests\n"
            + "SET status = ?\n"
            + "WHERE requestID = ?";

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

    private final String SEARCH_REQUEST_BY_STATUS = "SELECT r.semesterID, r.subjectCode, r.lecturerID, u.userName, r.startTime, r.endTime\n" +
            "FROM Requests r \n" +
            "JOIN Users u ON r.lecturerID = u.userID\n" +
            "WHERE r.studentID = ? AND r.status = ?\n" +
            "ORDER BY r.ID DESC";
    
    private final String SEARCH_REQUEST_BY_SUBCODE_AND_STATUS = "SELECT r.semesterID, r.subjectCode, r.lecturerID, u.userName, r.startTime, r.endTime, r.status\n" +
            "FROM Requests r \n" +
            "JOIN Users u ON r.lecturerID = u.userID\n" +
            "WHERE r.studentID = ? AND r.subjectCode = ? AND r.status = ?\n" +
            "ORDER BY r.ID DESC";
    
    private final String SEARCH_ALL_REQUEST = "SELECT r.semesterID, r.subjectCode, r.lecturerID, u.userName, r.startTime, r.endTime, r.status\n" +
            "FROM Requests r \n" +
            "JOIN Users u ON r.lecturerID = u.userID\n" +
            "WHERE r.studentID = ? \n" +
            "ORDER BY r.ID DESC";
    
    private final String SEARCH_ALL_REQUEST_BY_SUBCODE = "SELECT r.semesterID, r.subjectCode, r.lecturerID, u.userName, r.startTime, r.endTime, r.status\n" +
            "FROM Requests r \n" +
            "JOIN Users u ON r.lecturerID = u.userID\n" +
            "WHERE r.studentID = ? AND r.subjectCode = ? \n" +
            "ORDER BY r.ID DESC";

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
    
    private final String CHECK_TIMETABLE_DUPLICATE = "DECLARE @DayOfWeek VARCHAR(15)\n" +
                "SET @DayOfWeek = DATENAME(dw, ?)\n" +
                "SELECT s.slotID\n" +
                "FROM Slots s\n" +
                "JOIN (SELECT tb.slotID, s.startDay, s.endDay\n" +
                "		FROM Timetables tb\n" +
                "		JOIN Semesters s\n" +
                "		ON tb.semesterID = s.semesterID\n" +
                "		WHERE tb.semesterID = ? \n" +
                "		AND tb.lecturerID = ?) t\n" +
                "ON s.slotID = t.slotID\n" +
                "WHERE (s.day1 like @DayOfWeek  + '%' OR s.day2 like @DayOfWeek )\n" +
                "AND ? BETWEEN t.startDay AND t.endDay\n" +
                "AND ? BETWEEN s.starttime AND s.endtime";

    public boolean createARequest(RequestDTO requestDTO) throws SQLException, ClassNotFoundException, ParseException {
        boolean checkCreate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CREATE_REQUEST);
            stm.setInt(1, requestDTO.getStatus());
            stm.setString(2, requestDTO.getSubjectCode());
            String start = requestDTO.getStartTime();
            String end = requestDTO.getEndTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date starts = format.parse(start);
            Date ends = format.parse(end);
            stm.setTimestamp(3, new Timestamp(starts.getTime()));
            stm.setTimestamp(4, new Timestamp(ends.getTime()));
            stm.setNString(5, requestDTO.getDescription());
            stm.setString(6, requestDTO.getStudentID());
            stm.setString(7, requestDTO.getLecturerID());
            stm.setString(8, requestDTO.getSemesterID());
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

    private List<UserDTO> listUsers;

    public List<UserDTO> getListUsers() {
        return listUsers;
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
                String studentID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                String description = rs.getNString("description");
                RequestDTO requestDTO = new RequestDTO(requestID, 0, subjectCode,
                        starts, ends, description, studentID, userID, "");
                UserDTO userDTO = new UserDTO(studentID, userName, "", 1, "", "");
                if (this.listRequests == null) {
                    this.listRequests = new ArrayList<>();
                }
                this.listRequests.add(requestDTO);
                if (this.listUsers == null) {
                    this.listUsers = new ArrayList<>();
                }
                this.listUsers.add(userDTO);
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

    public boolean acceptARequest(String roleID) throws ClassNotFoundException, SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(ACCEPT_REQUEST);
            stm.setInt(1, 1);
            stm.setString(2, roleID);
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

    public boolean deleteARequest(String roleID) throws ClassNotFoundException, SQLException {
        boolean checkDelete = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(DELETE_REQUEST);
            stm.setInt(1, 0);
            stm.setString(2, roleID);
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
    
    private List<UserDTO> userByStatus;

    public List<UserDTO> getUserByStatus() {
        return userByStatus;
    }
    public void getRequestByStatus(String studentID, int status) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_REQUEST_BY_STATUS);
            stm.setString(1, studentID);
            stm.setInt(2, status);
            rs = stm.executeQuery();
            while(rs.next()){
                String semesterID = rs.getString("semesterID");
                String subjectCode = rs.getString("subjectCode");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                RequestDTO requestDTO = new RequestDTO("", status, subjectCode, starts, ends, "", studentID, lecturerID, semesterID);
                UserDTO userDTO = new UserDTO(lecturerID, lecName, "", 1, "", "");
                if(this.requestByStatus == null){
                    this.requestByStatus = new ArrayList<>();
                }
                this.requestByStatus.add(requestDTO);
                if(this.userByStatus == null){
                    this.userByStatus = new ArrayList<>();
                }
                this.userByStatus.add(userDTO);
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
    }

    private List<RequestDTO> requestBySubCodeAndStatus;

    public List<RequestDTO> getRequestBySubCodeAndStatus() {
        return requestBySubCodeAndStatus;
    }
    
    private List<UserDTO> userBySubCodeAndStatus;

    public List<UserDTO> getUserBySubCodeAndStatus() {
        return userBySubCodeAndStatus;
    }
    public void getRequestBySubCodeAndStatus(String studentID, String subjectCode, int status) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_REQUEST_BY_SUBCODE_AND_STATUS);
            stm.setString(1, studentID);
            stm.setString(2, subjectCode);
            stm.setInt(3, status);
            rs = stm.executeQuery();
            while(rs.next()){
                String semesterID = rs.getString("semesterID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                RequestDTO requestDTO = new RequestDTO("", status, subjectCode, starts, ends, "", studentID, lecturerID, semesterID);
                UserDTO userDTO = new UserDTO(lecturerID, lecName, "", 1, "", "");
                if(this.requestBySubCodeAndStatus == null){
                    this.requestBySubCodeAndStatus = new ArrayList<>();
                }
                this.requestBySubCodeAndStatus.add(requestDTO);
                if(this.userBySubCodeAndStatus == null){
                    this.userBySubCodeAndStatus = new ArrayList<>();
                }
                this.userBySubCodeAndStatus.add(userDTO);
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
    }

    private List<RequestDTO> allRequest;

    public List<RequestDTO> getAllRequest() {
        return allRequest;
    }
    
    private List<UserDTO> allUser;

    public List<UserDTO> getAllUser() {
        return allUser;
    }
    public void getAllRequest(String studentID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_ALL_REQUEST);
            stm.setString(1, studentID);
            rs = stm.executeQuery();
            while(rs.next()){
                String semesterID = rs.getString("semesterID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                String subjectCode = rs.getString("subjectCode");
                int status = rs.getInt("status");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                RequestDTO requestDTO = new RequestDTO("", status, subjectCode, starts, ends, "", studentID, lecturerID, semesterID);
                UserDTO userDTO = new UserDTO(lecturerID, lecName, "", 1, "", "");
                if(this.allRequest == null){
                    this.allRequest = new ArrayList<>();
                }
                this.allRequest.add(requestDTO);
                if(this.allUser == null){
                    this.allUser = new ArrayList<>();
                }
                this.allUser.add(userDTO);
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
    }

    private List<RequestDTO> allRequestBySubCode;

    public List<RequestDTO> getAllRequestBySubCode() {
        return allRequestBySubCode;
    }
    
    private List<UserDTO> allUserBySubCode;

    public List<UserDTO> getAllUserBySubCode() {
        return allUserBySubCode;
    }
    public void getAllRequestBySubCode(String studentID, String subjectCode) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_ALL_REQUEST_BY_SUBCODE);
            stm.setString(1, studentID);
            stm.setString(2, subjectCode);
            rs = stm.executeQuery();
            while(rs.next()){
                String semesterID = rs.getString("semesterID");
                String lecturerID = rs.getString("lecturerID");
                String lecName = rs.getNString("userName");
                int status = rs.getInt("status");
                Date startTime = rs.getTimestamp("startTime");
                Date endTime = rs.getTimestamp("endTime");
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String starts = dateFormat.format(startTime);
                String ends = dateFormat.format(endTime);
                RequestDTO requestDTO = new RequestDTO("", status, subjectCode, starts, ends, "", studentID, lecturerID, semesterID);
                UserDTO userDTO = new UserDTO(lecturerID, lecName, "", 1, "", "");
                if(this.allRequestBySubCode == null){
                    this.allRequestBySubCode = new ArrayList<>();
                }
                this.allRequestBySubCode.add(requestDTO);
                if(this.allUserBySubCode == null){
                    this.allUserBySubCode = new ArrayList<>();
                }
                this.allUserBySubCode.add(userDTO);
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
    }
}
