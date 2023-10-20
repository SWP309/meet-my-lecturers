package sample.requests;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import sample.utils.DBUtils;

public class RequestDAO implements Serializable{

    private final String CREATE_REQUEST = "INSERT INTO Requests "
            + "(status, subjectCode, startTime, endTime, description, studentID, lecturerID) "
            + "values(?, ?, ?, ?, ?, ?, ?)";
    
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

}
