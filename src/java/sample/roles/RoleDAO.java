/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.roles;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class RoleDAO {

    public static ArrayList<RoleDTO> getAllRole() throws Exception {
        ArrayList<RoleDTO> list = new ArrayList<>();
        //b1: tao connection
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select *\n"
                    + "From [dbo].[Roles]";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String name = rs.getString("roleName");
                    String id = rs.getString("roleID");
                    RoleDTO type = new RoleDTO(id, name);
                    list.add(type);
                }
            }
            cn.close();
        }
        return list;
    }
}
