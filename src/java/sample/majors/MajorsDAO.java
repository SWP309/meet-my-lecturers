/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.majors;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class MajorsDAO {

    private static String SUBJECT = "SELECT subjectCode\n"
            + "FROM Majors\n"
            + "WHERE lecturerID = ?";

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

    public List<MajorsDTO> getListSubjectCodeByMajorsOfLecturer(String lecturerID) throws SQLException {
        List<MajorsDTO> listSubject = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SUBJECT);
                ptm.setString(1, lecturerID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String subjectCode = rs.getString("subjectCode");
                    listSubject.add(new MajorsDTO(subjectCode));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listSubject;
    }
}
