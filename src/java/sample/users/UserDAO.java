package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import sample.utils.DBUtils;

public class UserDAO {

    public static UserDTO getUser(String email) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + "where userEmail like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String userName = rs.getString("userName");
                    String userEmail = rs.getString("userEmail");
                    boolean userStatus = rs.getBoolean("userStatus");
                    String timetableID = rs.getString("timetableID");
                    String roleID = rs.getString("roleID");
                    String password = rs.getString("password");
                    String requestID = rs.getString("requestID");
                    String freeSlotID = rs.getString("freeSlotID");
                    us = new UserDTO(userID,  userName,  userEmail,  userStatus,  timetableID,  roleID,  password,  requestID,  freeSlotID);
                }
            }
            cn.close();
        }
        return us;
    }
}
