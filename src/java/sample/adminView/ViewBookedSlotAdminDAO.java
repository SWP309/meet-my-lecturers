/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.adminView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import static sample.attendance.AttendanceDAO.convertTimestampToString;
import sample.utils.DBUtils;

/**
 *
 * @author Minh Khang
 */
public class ViewBookedSlotAdminDAO {

    public static ArrayList<ViewBookedSlotAdminDTO> getAllBookedSlots(String studentID, Date startTime, Date endTime) throws Exception {
        ArrayList<ViewBookedSlotAdminDTO> list = new ArrayList();
        ViewBookedSlotAdminDTO bk = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select fl.[lecturerID], bk.[studentID], bk.[freeSlotID], fl.[subjectCode] , fl.[meetLink], fl.[startTime], fl.[endTime]\n"
                    + "From [dbo].[Bookings] as bk, [dbo].[FreeSlots] as fl\n"
                    + "Where bk.freeSlotID = fl.freeSlotID AND bk.[studentID] like ? AND fl.startTime >= ? AND fl.endTime <= ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + studentID + "%");
            pst.setTimestamp(2, new Timestamp(startTime.getTime()));
            pst.setTimestamp(3, new Timestamp(endTime.getTime()));
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("lecturerID");
                    String StudentID = rs.getString("studentID");
                    String freeSlotID = rs.getString("freeSlotID");
                    String SubjectCode = rs.getString("subjectCode");
                    String meetLink = rs.getString("meetLink");
                    String StartTime = convertTimestampToString(rs.getTimestamp("startTime"));
                    String EndTime = convertTimestampToString(rs.getTimestamp("endTime"));
                    bk = new ViewBookedSlotAdminDTO(id, StudentID, freeSlotID, SubjectCode, meetLink, StartTime, EndTime);
                    list.add(bk);
                }
            }
            cn.close();
        }
        return list;
    }

    public static ArrayList<ViewBookedSlotAdminDTO> getAllCreatedSlots(String LecturerID, Date startTime, Date endTime) throws Exception {
        ArrayList<ViewBookedSlotAdminDTO> list = new ArrayList();
        ViewBookedSlotAdminDTO bk = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Select fl.[lecturerID], bk.[studentID], bk.[freeSlotID], fl.[subjectCode] , fl.[meetLink], fl.[startTime], fl.[endTime]\n"
                    + "From [dbo].[Bookings] as bk, [dbo].[FreeSlots] as fl\n"
                    + "Where bk.freeSlotID = fl.freeSlotID AND fl.lecturerID like ? AND fl.startTime >= ? AND fl.endTime <= ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, "%" + LecturerID + "%");
            pst.setTimestamp(2, new Timestamp(startTime.getTime()));
            pst.setTimestamp(3, new Timestamp(endTime.getTime()));
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("lecturerID");
                    String StudentID = rs.getString("studentID");
                    String freeSlotID = rs.getString("freeSlotID");
                    String SubjectCode = rs.getString("subjectCode");
                    String meetLink = rs.getString("meetLink");
                    String StartTime = convertTimestampToString(rs.getTimestamp("startTime"));
                    String EndTime = convertTimestampToString(rs.getTimestamp("endTime"));
                    bk = new ViewBookedSlotAdminDTO(id, StudentID, freeSlotID, SubjectCode, meetLink, StartTime, EndTime);
                    list.add(bk);
                }
            }
            cn.close();
        }
        return list;
    }
}
