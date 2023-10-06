package sample.requests;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import sample.utils.DBUtils;

public class RequestDAO {

    private final String CREATE_USER = "INSERT  INTO Requests(status, subjectCode, "
            + "startTime, endTime, description, studentID, lecturerID) "
            + "values(?, ?, ?, ?, ?, ?, ?)";
    
    public boolean createARequest(RequestDTO requestDTO) throws SQLException, ClassNotFoundException, ParseException {
        boolean checkCreate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(CREATE_USER);
            stm.setBoolean(1, false);
            stm.setString(2, requestDTO.getSubjectCode());
            String start = requestDTO.getStartTime();
            String end = requestDTO.getEndTime();
            SimpleDateFormat format1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            Date starts = format1.parse(start);
            Date starts2 = format2.parse(end);
            stm.setDate(3, (java.sql.Date) starts);//lam sao de dong nhat kieu du lieu
            stm.setDate(4, (java.sql.Date) starts2);
            stm.setString(5, requestDTO.getDescription());
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
