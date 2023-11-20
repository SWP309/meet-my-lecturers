/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.semester;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author Dell
 */
public class SemesterDAO {

    public List<SemesterDTO> select() throws SQLException, ClassNotFoundException {

        List<SemesterDTO> list = null;
        //Tạo connection để kết nối vào DBMS
        Connection con = null;
        con = DBUtils.getConnection();
        //Tạo đối tượng statement
        Statement stm = con.createStatement();
        //Thực thi lệnh SELECT
        ResultSet rs = stm.executeQuery("select * from [dbo].[Semesters]");
        list = new ArrayList<>();
        while (rs.next()) {
            SemesterDTO semesters = new SemesterDTO();
            semesters.setSemesterID(rs.getString("semesterID"));
            semesters.setSemesterName(rs.getString("semesterName"));
            semesters.setStartDay(rs.getTimestamp("startDay"));
            semesters.setEndDay(rs.getTimestamp("endDay"));
            list.add(semesters);
        }
        con.close();
        return list;
    }

    public SemesterDTO read(String semesterID) throws SQLException, ClassNotFoundException {
        SemesterDTO semesters = null;
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from Semesters where semesterID = ? ");
        stm.setString(1, semesterID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            semesters = new SemesterDTO();
            semesters.setSemesterID(rs.getString("semesterID"));
            semesters.setSemesterName(rs.getString("semesterName"));
            semesters.setStartDay(rs.getTimestamp("startDay"));
            semesters.setEndDay(rs.getTimestamp("endDay"));

        }
        con.close();
        return semesters;
    }

    public void create(SemesterDTO semesters) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("insert into Semesters values(?, ?, ?, ?)");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        stm.setString(1, semesters.getSemesterID());
        stm.setString(2, semesters.getSemesterName());
        stm.setString(3, sdf.format(semesters.getStartDay()));
        stm.setString(4, sdf.format(semesters.getEndDay()));
        int count = stm.executeUpdate();
        con.close();
    }

    public void update(SemesterDTO semesters) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("update Semesters set semesterName = ?, startDay = ?, endDay = ? where semesterID = ?");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        stm.setString(1, semesters.getSemesterName());
        stm.setString(2, sdf.format(semesters.getStartDay()));
        stm.setString(3, sdf.format(semesters.getEndDay()));
        stm.setString(4, sdf.format(semesters.getSemesterID()));
        int count = stm.executeUpdate();
        con.close();
    }

    public void delete(String semesterID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("delete from Semesters where semesterID = ? ");
        stm.setString(1, semesterID);
        int count = stm.executeUpdate();
        con.close();
    }

    public String getCurrentSemester() throws ClassNotFoundException, SQLException, ParseException {
        String semesterID = null;
        Date currentDate = new Date();
        System.out.println(currentDate);
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement("SELECT s.semesterID\n"
                + "                			FROM Semesters s\n"
                + "                			WHERE ? BETWEEN s.startDay AND s.endDay");
        String start = services.Service.sdfDateTime.format(currentDate);
        stm.setTimestamp(1, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            semesterID = rs.getString("semesterID");
        }
        return semesterID;
    }
}
