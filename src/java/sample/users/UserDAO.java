package sample.users;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

public class UserDAO implements Serializable{
    private final String SEARCH_LECTURERS = "SELECT userID, userName, userEmail\n" +
                                            "FROM Users\n" +
                                            "WHERE roleID = 2 AND userStatus = 1";

    private List<UserDTO> lecturers;

    public List<UserDTO> getLecturers() {
        return lecturers;
    }
    
    public void getListLecturers() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_LECTURERS);
            rs = stm.executeQuery();
            while(rs.next()){
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, true, "2", "");
                if(this.lecturers == null){
                    this.lecturers = new ArrayList<>();
                }
                this.lecturers.add(userDTO);
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