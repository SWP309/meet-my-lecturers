/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.semester;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class SemesterDAO {

    public static List<SemesterDTO> getAllSemesterID() throws Exception {
        List<SemesterDTO> list = new ArrayList<>();
        //b1: tao connection
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select [semesterID]\n"
                    + "From [dbo].[Semesters]";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String semesterID = rs.getString("semesterID");
                    SemesterDTO semester = new SemesterDTO(semesterID);
                    list.add(semester);
                }
            }
            cn.close();
        }
        return list;
    }
}
