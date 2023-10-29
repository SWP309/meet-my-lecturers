/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.timetables;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.slots.SlotDTO;
import sample.subjects.SubjectDTO;
import sample.utils.DBUtils;

/**
 *
 * @author CHIBAO
 */
public class TimetableDAO implements Serializable{

    private final String SEARCH_TIMETABLES = "SELECT T.slotID, T.subjectCode, S.subjectName, SL.day1, SL.day2, SL.starttime, SL.endtime\n" +
                    "FROM Timetables T\n" +
                    "JOIN Slots SL ON T.slotID = SL.slotID\n" +
                    "JOIN Subjects S ON T.subjectCode = S.subjectCode\n" +
                    "WHERE T.lecturerID = ? AND T.semesterID = ?";
    
    private List<TimetableDTO> timetables;
    
    private List<SubjectDTO> subjects;
    
    private List<SlotDTO> slots;

    public List<TimetableDTO> getTimetables() {
        return timetables;
    }

    public List<SlotDTO> getSlots() {
        return slots;
    }

    public List<SubjectDTO> getSubjects() {
        return subjects;
    }
    
    private static String convertTimeToString(Time sqlTime) {
        // Sử dụng SimpleDateFormat để định dạng ngày giờ
        DateFormat dateFormat = new SimpleDateFormat("HH:mm");

        // Sử dụng phương thức format để chuyển đổi Time thành String
        return dateFormat.format(sqlTime);
    }
    
    public void getListTimetables(String lecturerID, String semesterID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_TIMETABLES);
            stm.setString(1, lecturerID);
            stm.setString(2, semesterID);
            rs = stm.executeQuery();
            while(rs.next()){
                String slotID = rs.getNString("slotID");
                String subjectCode = rs.getNString("subjectCode");
                String subjectName = rs.getNString("subjectName");
                String day1 = rs.getString("day1");
                String day2 = rs.getString("day2");
                Time startTime = rs.getTime("starttime");
                String formattedStart = convertTimeToString(startTime);
                Time endTime = rs.getTime("endtime");
                String formattedEnd = convertTimeToString(endTime);
                TimetableDTO timetableDTO = new TimetableDTO(subjectCode, slotID, lecturerID, semesterID);
                SlotDTO slotDTO = new SlotDTO(slotID, day1, day2, formattedStart, formattedEnd);
                SubjectDTO subjectDTO = new SubjectDTO(subjectCode, subjectName);
                if(this.timetables == null){
                    this.timetables = new ArrayList<>();
                }
                this.timetables.add(timetableDTO);
                if(this.subjects == null){
                    this.subjects = new ArrayList<>();
                }
                this.subjects.add(subjectDTO);
                if(this.slots == null){
                    this.slots = new ArrayList<>();
                }
                this.slots.add(slotDTO);
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
    }
        public List<TimetableDTO> listByDate(String lecturerID, String day, String start, String end) throws SQLException, ClassNotFoundException {
        List<TimetableDTO> list = new ArrayList<>();
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(
                "select t.semesterID, t.lecturerID, t.slotID, s.starttime, s.endtime, s.day1, s.day2, t.subjectCode\n"
                + "from Timetables as t\n"
                + "left join Slots as s on t.slotID = s.slotID\n"
                + "where lecturerID = ? and (day1 = ? or day2 = ?)\n "
                + "and ((? between starttime and endtime) or ( ? between starttime and endtime))");
        stm.setString(1, lecturerID);
        stm.setString(2, day);
        stm.setString(3, day);
        stm.setString(4, start);
        stm.setString(5, end);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            TimetableDTO t = new TimetableDTO();
            t.setLecturerID(rs.getString("lecturerID"));
            t.setSlotID(rs.getString("slotID"));
            t.setStartTime(services.Service.sdfTime.format(rs.getTime("starttime")));
            t.setEndTime(services.Service.sdfTime.format(rs.getTime("endtime")));
            t.setDay1(rs.getString("day1"));
            t.setDay2(rs.getString("day2"));
            t.setSubjectCode(rs.getString("subjectCode"));
            list.add(t);
        }
        con.close();
        return list;
    }
}
