/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.subjects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class SubjectDAO {

    public static int insertSubject(SubjectDTO subject) throws Exception {
        int rs = 0;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Insert [dbo].[Subjects] ([subjectCode], [subjectName], [status])\n"
                    + "Values (?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, subject.getSubjectCode());
            pst.setString(2, subject.getSubjectName());
            pst.setInt(3, 1);
            rs = pst.executeUpdate();
            cn.close();

        }
        return rs;
    }

    public static int removeSubject(String subjectCode) throws Exception {
        int rs = 0;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Delete\n"
                    + "From [dbo].[Subjects]\n"
                    + "Where [subjectCode] = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, subjectCode);
            rs = pst.executeUpdate();
            cn.close();
        }
        return rs;
    }

    public static SubjectDTO getSubject(String subjectCode) throws Exception {
        SubjectDTO subject = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select *\n"
                    + "From [dbo].[Subjects]\n"
                    + "Where [subjectCode] like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + subjectCode + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String code = rs.getString("subjectCode").trim();
                    String des = rs.getString("subjectName").trim();
                    int status = rs.getInt("status");
                    subject = new SubjectDTO(code, des, status);
                }
            }
            cn.close();
        }
        return subject;
    }

    public static ArrayList<SubjectDTO> getSubjects(String subject) throws Exception {
        ArrayList<SubjectDTO> list = new ArrayList();
        SubjectDTO sub = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select * \n"
                    + "From [dbo].[Subjects]\n"
                    + "Where [subjectCode] like ? and [status] = 1";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + subject + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("subjectCode");
                    String name = rs.getString("subjectName");
                    int status = rs.getInt("status");
                    sub = new SubjectDTO(id, name, status);
                    list.add(sub);
                }
            }
            cn.close();
        }
        return list;
    }

    public static ArrayList<SubjectDTO> getAllSubject() throws Exception {
        ArrayList<SubjectDTO> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select *\n"
                    + "From [dbo].[Subjects]\n"
                    + "Where status = 1";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String code = rs.getString("subjectCode");
                    String name = rs.getString("subjectName");
                    int status = rs.getInt("status");
                    SubjectDTO type = new SubjectDTO(code, name, status);
                    list.add(type);
                }
            }
            cn.close();
        }
        return list;
    }

    public static int ImportExcelSubject(SubjectDTO subject) {
        Connection cn = null;
        int rs = 0;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "Insert [dbo].[Subjects] ([subjectCode], [subjectName], [status])\n"
                        + "Values (?,?,?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, subject.getSubjectCode());
                pst.setString(2, subject.getSubjectName());
                pst.setInt(3, 1);
                rs = pst.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions here, you can log the error or take appropriate action
            e.printStackTrace(); // This line will print the exception details to the console
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                // Handle closing the connection if it fails
                e.printStackTrace();
            }
        }

        return rs;
    }

    public static int updateSubject(SubjectDTO subject) throws Exception {
        int rs = 0;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Update [dbo].[Subjects]\n"
                    + "Set [status] = 0\n"
                    + "Where [subjectCode] = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, subject.getSubjectCode());
            rs = pst.executeUpdate();
            cn.close();
        }
        return rs;
    }
}
