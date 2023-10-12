/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import sample.utils.DBUtils;

/**
 *
 * @author W10(hiep-tm)
 */
public class FreeSlotsDAO {

    private final static String CREATE_FREESLOT = "INSERT INTO "
            + "FreeSlots(subjectCode,startTime,endTime,password,capacity,meetLink,count,lecturerID) "
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

    public boolean createFreeSlot(FreeSlotsDTO freeSlotsDTO) throws SQLException {
        boolean checkCreate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
//        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CREATE_FREESLOT);
                ps.setString(1, freeSlotsDTO.getSubjectCode());

                // Convert the LocalDateTime object to a Date object
                Date startTime = (Date) Date.from(freeSlotsDTO.getStartTime().atZone(ZoneId.systemDefault()).toInstant());
                Date endTime = (Date) Date.from(freeSlotsDTO.getEndTime().atZone(ZoneId.systemDefault()).toInstant());

                ps.setDate(2, startTime);
                ps.setDate(3, endTime);
                ps.setString(4, freeSlotsDTO.getPassword());
                ps.setInt(5, freeSlotsDTO.getCapacity());
                ps.setString(6, freeSlotsDTO.getMeetLink());
                ps.setInt(7, freeSlotsDTO.getCount());
                ps.setString(8, freeSlotsDTO.getLecturerID());
                
                result=ps.executeUpdate();
                if (result>0) {
                    checkCreate=true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
//            if (rs != null) {
//                rs.close();
//            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return checkCreate;
    }
}
