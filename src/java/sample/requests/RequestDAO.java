package sample.requests;

import java.io.Serializable;
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
import sample.users.UserDTO;
import sample.utils.DBUtils;

public class RequestDAO implements Serializable{

    private final String CREATE_REQUEST = "INSERT INTO Requests "
            + "(status, subjectCode, startTime, endTime, description, studentID, lecturerID, semesterID) "
            + "values(?, ?, ?, ?, ?, ?, ?, ?)";

    private final String SEARCH_REQUESTS = "SELECT r.requestID, u.userID, u.userName, r.subjectCode, r.startTime, r.endTime, r.description \n" +
            "FROM Requests r\n" +
            "JOIN Users u on r.studentID = u.userID\n" +
            "WHERE r.lecturerID = ? and r.status = ?";

    private final String ACCEPT_REQUEST = "UPDATE Requests\n" +
            "SET status = ?\n" +
            "WHERE requestID = ?";
    
    public boolean createARequest(RequestDTO requestDTO) throws SQLException, ClassNotFoundException, ParseException{
        boolean checkCreate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CREATE_REQUEST);
            stm.setBoolean(1, requestDTO.isStatus());
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
            if(result > 0){
                checkCreate = true;
            }
        } finally {
            if(stm != null){
                stm.close();
            }
            if(con != null){
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
            stm.setBoolean(2, false);
            rs = stm.executeQuery();
            while(rs.next()){
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
                RequestDTO requestDTO = new RequestDTO(requestID, false, subjectCode
                        , starts, ends, description, studentID, userID, "");
                UserDTO userDTO = new UserDTO(studentID, userName, "", true, "", "");
                if(this.listRequests == null){
                    this.listRequests = new ArrayList<>();
                }
                this.listRequests.add(requestDTO);
                if(this.listUsers == null){
                    this.listUsers = new ArrayList<>();
                }
                this.listUsers.add(userDTO);
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

    public boolean acceptARequest(String roleID) throws ClassNotFoundException, SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(ACCEPT_REQUEST);
            stm.setBoolean(1, true);
            stm.setString(2, roleID);
            result = stm.executeUpdate();
            if(result > 0){
                checkUpdate = true;
            }
        } finally {
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        return checkUpdate;
    }

}
