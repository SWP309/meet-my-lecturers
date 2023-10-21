/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import sample.utils.DBUtils;

/**
 *
 * @author W10(hiep-tm)
 */
public class FreeSlotsDAO {

    private final static String CREATE_FREESLOT = "INSERT INTO "
            + "FreeSlots(subjectCode,startTime,endTime,password,capacity,meetLink,count,lecturerID,status) "
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public boolean createFreeSlot(FreeSlotsDTO freeSlotsDTO) throws SQLException {
        boolean checkCreate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
//        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date startTime = simpleDateFormat.parse(freeSlotsDTO.getStartTime());
            Date endTime = simpleDateFormat.parse(freeSlotsDTO.getEndTime());
            
            if (conn != null) {
                ps = conn.prepareStatement(CREATE_FREESLOT);
                ps.setString(1, freeSlotsDTO.getSubjectCode());
                ps.setTimestamp(2, new Timestamp(startTime.getTime()));
                ps.setTimestamp(3, new Timestamp(endTime.getTime()));
                ps.setString(4, freeSlotsDTO.getPassword());
                ps.setInt(5, freeSlotsDTO.getCapacity());
                ps.setString(6, freeSlotsDTO.getMeetLink());
                ps.setInt(7, freeSlotsDTO.getCount());
                ps.setString(8, freeSlotsDTO.getLecturerID());
                ps.setBoolean(9, freeSlotsDTO.getStatus());

                result = ps.executeUpdate();
                if (result > 0) {
                    checkCreate = true;
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
