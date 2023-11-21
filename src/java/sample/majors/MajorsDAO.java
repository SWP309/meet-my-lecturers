/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.majors;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class MajorsDAO {

    public static ArrayList<MajorsDTO> getAllMajors() throws Exception {
        ArrayList<MajorsDTO> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select distinct [subjectCode]\n"
                    + "From [dbo].[Majors]";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    MajorsDTO type = new MajorsDTO(subjectCode);
                    list.add(type);
                }
            }
            cn.close();
        }
        return list;
    }
}
