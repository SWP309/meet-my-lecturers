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
    private static String SUBJECT_LECTURER = "Select [subjectCode]\n"
            + "			From  [dbo].[Majors]\n"
            + "			Where [subjectCode] = ? ";

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

//    public List<MajorsDTO> getSubject(String subjectCode) throws SQLException {
//        List<MajorsDTO> listSubject = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement ptm = null;
//        ResultSet rs = null;
//        try {
//            conn = DBUtils.getConnection();
//            if (conn != null) {
//                ptm = conn.prepareStatement(SUBJECT_LECTURER);
//                rs = ptm.executeQuery();
//                while (rs.next()) {
//                    String sujectCode = rs.getString("subjectCode");
//                    listSubject.add(new MajorsDTO(sujectCode));
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (ptm != null) {
//                ptm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return listSubject;
//    }
    
      public boolean getSubject(String subjectCode) throws ClassNotFoundException, SQLException {
        boolean check = true;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SUBJECT_LECTURER);
            stm.setString(1, subjectCode);
            rs = stm.executeQuery();
            if (rs.next()) {
                check = false;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }
//    public boolean getSubject(String subjectCode) throws Exception {
//        MajorsDTO subject = null;
//        Connection cn = DBUtils.getConnection();
//        if (cn != null) {
//            String sql = "Select *\n"
//                    + "From  [dbo].[Majors]\n"
//                    + "Where [subjectCode] = ?";
//            PreparedStatement pst = cn.prepareStatement(sql);
//            pst.setString(1, subjectCode);
//            ResultSet rs = pst.executeQuery();
//            if (rs != null) {
//                while (rs.next()) {
//                    String lecID = rs.getString("lecturerID").trim();
//                    String sbCode = rs.getString("subjectCode").trim();
//                    String semes = rs.getString("semesterID").trim();
//                    subject = new MajorsDTO(lecID, sbCode, semes);
//                }
//            }
//            cn.close();
//        }
//        return subject;
//    }

}
