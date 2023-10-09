package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import sample.utils.DBUtils;

public class UserDAO {

    public static UserDTO getUserByMail(String userMail) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + "where userEmail like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userMail);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("userID").trim();
                    String name = rs.getString("userName").trim();
                    String email = rs.getString("userEmail").trim();
                    boolean status = rs.getBoolean("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }

    public static UserDTO getUser(String userEmail) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + " where userEmail like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("userID").trim();
                    String name = rs.getString("userName").trim();
                    String email = rs.getString("userEmail").trim();
                    boolean status = rs.getBoolean("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }
}
