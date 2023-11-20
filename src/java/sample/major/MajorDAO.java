/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.major;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author CHIBAO
 */
public class MajorDAO implements Serializable {

    public boolean createMajor(MajorDTO majorDTO) throws SQLException {
        boolean checkCreate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
//        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                ps = conn.prepareStatement("Insert into Majors(subjectCode, lecturerID, semesterID) values(?, ?, ?)");
                ps.setString(1, majorDTO.getSubjectCode());
                ps.setString(2, majorDTO.getLecturerID());
                ps.setString(3, majorDTO.getSemesterID());
                result = ps.executeUpdate();
                if (result > 0) {
                    checkCreate = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkCreate;
    }

    public List<MajorDTO> select() throws SQLException, ClassNotFoundException {
        List<MajorDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from Majors");
        list = new ArrayList<>();
        while (rs.next()) {
            MajorDTO majorDTO = new MajorDTO();
            majorDTO.setLecturerID(rs.getString("lecturerID"));
            majorDTO.setSubjectCode(rs.getString("subjectCode"));
            majorDTO.setSemesterID(rs.getString("semesterID"));

            list.add(majorDTO);
        }
        con.close();
        return list;
    }

    public List<MajorDTO> select(String lecturerID) throws SQLException, ClassNotFoundException {
        List<MajorDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("SELECT m.lecturerID, m.subjectCode, s.subjectName\n"
                + "FROM Majors m\n"
                + "JOIN Subjects s ON m.subjectCode = s.subjectCode\n"
                + "WHERE m.lecturerID = ?");
        stm.setString(1, lecturerID);
        ResultSet rs = stm.executeQuery();
        list = new ArrayList<>();
        
        if (rs != null) {
            while (rs.next()) {
                MajorDTO majorDTO = new MajorDTO();
                majorDTO.setLecturerID(lecturerID);
                majorDTO.setSubjectCode(rs.getString("subjectCode"));
                majorDTO.setSubjectName(rs.getString("subjectName"));
                System.out.println(majorDTO.toString());
                list.add(majorDTO);
            }
        }
        con.close();
        return list;
    }

    public void update(MajorDTO majorDTO) throws SQLException, ClassNotFoundException, ParseException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("update Majors set subjectCode = ?, semesterID = ? where lecturerID = ?");
        stm.setString(1, majorDTO.getSubjectCode());
        stm.setString(2, majorDTO.getSemesterID());
        stm.setString(3, majorDTO.getLecturerID());
        int count = stm.executeUpdate();
        con.close();
    }

    public void delete(MajorDTO majorDTO) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("delete from Majors where lecturerID = ? and subjectCode = ? and semesterID = ?");
        stm.setString(1, majorDTO.getLecturerID());
        stm.setString(1, majorDTO.getSubjectCode());
        stm.setString(1, majorDTO.getSemesterID());
        stm.executeUpdate();
        con.close();
    }

}
