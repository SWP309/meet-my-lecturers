/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.attendance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class AttendanceDAO {

        public static String convertTimestampToString(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = dateFormat.format(timestamp);
        return dateString;
    }
    
    
    public static ArrayList<AttendanceDTO> getAttendanceSlot(String studentID, String name) throws Exception {
        ArrayList<AttendanceDTO> list = new ArrayList();
        AttendanceDTO att = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "SELECT fs.freeSlotID, fs.semesterID, fs.subjectCode, fs.[startTime], fs.[endTime], b.[status]\n" +
"				FROM Bookings b\n" +
"				JOIN FreeSlots fs ON b.freeSlotID = fs.freeSlotID\n" +
"				WHERE b.status = '2' AND b.studentID = ? AND fs.semesterID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + studentID + "%");
            pst.setString(2, "%" + name + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("freeSlotID");
                    String SemesterID = rs.getString("semesterID");
                    String SubjectCode = rs.getString("subjectCode");
                    String StartTime = convertTimestampToString(rs.getTimestamp("startTime"));
                    String EndTime = convertTimestampToString(rs.getTimestamp("endTime"));
                    byte status = rs.getByte("status");
                    String StudentID = rs.getString("studentID");
                    att = new AttendanceDTO(id, SemesterID, SubjectCode, StartTime, EndTime, status, StudentID);
                    list.add(att);
                }
            }
            cn.close();
        }
        return list;
    }

}
