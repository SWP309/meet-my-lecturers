/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.blocklist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author W10
 */
public class BlockListDAO {

    private final String SEARCH_ALL_BLOCKLIST = "SELECT u.userID, u.userName, u.userEmail, bl.status\n"
            + "FROM BlockList bl\n"
            + "JOIN Users u on bl.studentID = u.userID\n"
            + "WHERE lecturerID = ?";
    private final String SEARCH_BLOCKED_IN_LIST = "SELECT u.userID, u.userName, u.userEmail, bl.status\n"
            + "FROM BlockList bl\n"
            + "JOIN Users u on bl.studentID = u.userID\n"
            + "WHERE lecturerID = ? AND bl.status = 1";
    private final String SEARCH_UNBLOCKED_IN_LIST = "SELECT u.userID, u.userName, u.userEmail, bl.status\n"
            + "FROM BlockList bl\n"
            + "JOIN Users u on bl.studentID = u.userID\n"
            + "WHERE lecturerID = ? AND bl.status = 0";
    private final String SEARCH_STUDENTID_IN_LIST = "SELECT u.userID, u.userName, u.userEmail, bl.status\n" +
                                                    "FROM BlockList bl\n" +
                                                    "JOIN Users u on bl.studentID = u.userID\n" +
                                                    "WHERE bl.lecturerID = ? AND bl.studentID LIKE '%' + ? + '%'";
    
    private final String CHECK_BLOCKLIST = "SELECT studentID FROM BlockList WHERE studentID = ? AND lecturerID = ? AND status = 1";

    private List<BlockListDTO> listBlockList;

    public List<BlockListDTO> getListBlockList() {
        return listBlockList;
    }

    public List<BlockListDTO> getAllBlockList(String lecturerID) throws SQLException {
        List<BlockListDTO> searchAllBlockList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_ALL_BLOCKLIST);
            stm.setString(1, lecturerID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String studentID = rs.getString("userID");
                String userName = rs.getString("userName");
                String userEmail = rs.getString("userEmail");
                int status = rs.getInt("status");

                BlockListDTO blockListDTO = new BlockListDTO(lecturerID, studentID, userName, userEmail, status);
                searchAllBlockList.add(blockListDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return searchAllBlockList;
    }

    public List<BlockListDTO> getBlockedInList(String lecturerID) throws SQLException {
        List<BlockListDTO> searchBlockedInList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_BLOCKED_IN_LIST);
            stm.setString(1, lecturerID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String studentID = rs.getString("userID");
                String userName = rs.getString("userName");
                String userEmail = rs.getString("userEmail");
                int status = rs.getInt("status");

                BlockListDTO blockListDTO = new BlockListDTO(lecturerID, studentID, userName, userEmail, status);
                searchBlockedInList.add(blockListDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return searchBlockedInList;
    }

    public List<BlockListDTO> getUnBlockedInList(String lecturerID) throws SQLException {
        List<BlockListDTO> searchUnBlockedInList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_UNBLOCKED_IN_LIST);
            stm.setString(1, lecturerID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String studentID = rs.getString("userID");
                String userName = rs.getString("userName");
                String userEmail = rs.getString("userEmail");
                int status = rs.getInt("status");

                BlockListDTO blockListDTO = new BlockListDTO(lecturerID, studentID, userName, userEmail, status);
                searchUnBlockedInList.add(blockListDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return searchUnBlockedInList;
    }

    public List<BlockListDTO> getStudentIDInList(String lecturerID, String studentIDSearch) throws SQLException {
        List<BlockListDTO> searchStudentIDInList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_STUDENTID_IN_LIST);
            stm.setString(1, lecturerID);
            stm.setString(2, studentIDSearch);
            rs = stm.executeQuery();
            while (rs.next()) {
                String studentID = rs.getString("userID");
                String userName = rs.getString("userName");
                String userEmail = rs.getString("userEmail");
                int status = rs.getInt("status");

                BlockListDTO blockListDTO = new BlockListDTO(lecturerID, studentID, userName, userEmail, status);
                searchStudentIDInList.add(blockListDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return searchStudentIDInList;
    }
    
    public boolean addBlockList(BlockListDTO blockListDTO) throws SQLException {
        boolean checkAdd = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                ps = conn.prepareStatement("Insert into BlockList(lecturerID, studentID, status) values(?, ?, ?)");
                ps.setString(1, blockListDTO.getLecturerID());
                ps.setString(2, blockListDTO.getStudentID());
                ps.setInt(3, blockListDTO.getStatus());
                result = ps.executeUpdate();
                if (result > 0) {
                    checkAdd = true;
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
        return checkAdd;
    }
    
    public boolean updateBlockList(BlockListDTO blockListDTO) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                ps = conn.prepareStatement("UPDATE BlockList\n" +
                                           "SET status = ?\n" +
                                           "WHERE lecturerID = ? AND studentID = ?");
                ps.setInt(1, blockListDTO.getStatus());
                ps.setString(2, blockListDTO.getLecturerID());
                ps.setString(3, blockListDTO.getStudentID());
                result = ps.executeUpdate();
                if (result > 0) {
                    checkUpdate = true;
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
        return checkUpdate;
    }
    
    public boolean deleteBlockList(BlockListDTO blockListDTO) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int result;
        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                ps = conn.prepareStatement("DELETE FROM BlockList\n" +
                                           "WHERE lecturerID = ? AND studentID = ?");
                ps.setString(1, blockListDTO.getLecturerID());
                ps.setString(2, blockListDTO.getStudentID());
                result = ps.executeUpdate();
                if (result > 0) {
                    checkDelete = true;
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
        return checkDelete;
    }
    
    public boolean checkStudentInBlockListOfLecturer(String studentID, String lecturerID) throws SQLException {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECK_BLOCKLIST);
                ps.setString(1, studentID);
                ps.setString(2, lecturerID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return exists;
    }
}
