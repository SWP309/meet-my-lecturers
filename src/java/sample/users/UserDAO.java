package sample.users;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.dashboard.UserMaxRequestDTO;
import sample.dashboard.UserMaxSlotDTO;
import sample.utils.DBUtils;

public class UserDAO implements Serializable {

    private final String SEARCH_LECTURERS = "SELECT userID, userName, userEmail\n"
            + "FROM Users\n"
            + "WHERE roleID = 2 AND userStatus = 1";

    private List<UserDTO> lecturers;

    public List<UserDTO> getLecturers() {
        return lecturers;
    }

    public void getListLecturers() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_LECTURERS);
            rs = stm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, true, "2", "");
                if (this.lecturers == null) {
                    this.lecturers = new ArrayList<>();
                }
                this.lecturers.add(userDTO);
            }
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
    }

    public static UserDTO getUserByMail(String userMail) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + "where userEmail like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userMail);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("userID").trim();
                    String name = rs.getString("userName").trim();
                    String email = rs.getString("userEmail").trim();
                    boolean status = rs.getBoolean("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }

    public static UserDTO getUser(String userEmail) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + " where userEmail like ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("userID").trim();
                    String name = rs.getString("userName").trim();
                    String email = rs.getString("userEmail").trim();
                    boolean status = rs.getBoolean("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }

    public static UserMaxSlotDTO getStudentMaxBook(String semester) throws Exception {
        UserMaxSlotDTO st = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "WITH StudentCounts AS (\n"
                    + "    SELECT b.studentID, COUNT(*) as 'NumberSlot'\n"
                    + "    FROM Bookings b\n"
                    + "    WHERE b.freeSlotID IN (\n"
                    + "        SELECT fs.freeSlotID\n"
                    + "        FROM FreeSlots fs\n"
                    + "        WHERE fs.startTime >= (SELECT s.startDay\n"
                    + "            FROM Semesters s\n"
                    + "            WHERE s.semesterID = ?) \n"
                    + "        AND fs.endTime <= (SELECT s.endDay\n"
                    + "            FROM Semesters s\n"
                    + "            WHERE s.semesterID = ?) \n"
                    + "    )\n"
                    + "    GROUP BY b.studentID\n"
                    + ")\n"
                    + "SELECT TOP 1 studentID, NumberSlot\n"
                    + "FROM StudentCounts\n"
                    + "ORDER BY NumberSlot DESC;";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, semester);
            pst.setString(2, semester);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("studentID").trim();
                    int numberSlot = rs.getInt("NumberSlot");
                    st = new UserMaxSlotDTO(id, numberSlot);
                    
                    System.out.println(st + "getStudentMaxBook");
                }
            }else{               
            System.out.println("rs bang null getStudentMaxBook(String semester)");
            }
            cn.close();
        }
        return st;
    }

    public static UserMaxRequestDTO getStudentMaxRequest(String semester) throws Exception {
        UserMaxRequestDTO st = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select top 1 r.studentID, COUNT(*) as 'NumberRequest'\n"
                    + "from Requests r\n"
                    + "where r.semesterID = ?\n"
                    + "group by r.studentID\n"
                    + "order by NumberRequest desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, semester);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("studentID").trim();
                    int numberRequest = rs.getInt("NumberRequest");
                    st = new UserMaxRequestDTO(id, numberRequest);
                }
            }else{
            System.out.println("rs bang null getStudentMaxRequest(String semester)");
                
            }
            cn.close();
        }
        return st;
    }

    public static UserMaxSlotDTO getLecturerMaxSlot(String semester) throws Exception {
        UserMaxSlotDTO st = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select top 1 fs.lecturerID, count(*) as 'NumberCreatedSlot'\n"
                    + "from FreeSlots fs\n"
                    + "where fs.startTime >= (select s.startDay\n"
                    + "from Semesters s\n"
                    + "where s.semesterID = ?) \n"
                    + "and fs.endTime <= (select s.endDay\n"
                    + "from Semesters s\n"
                    + "where s.semesterID = ?) \n"
                    + "group by fs.lecturerID\n"
                    + "order by [NumberCreatedSlot] desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, semester);
            pst.setString(2, semester);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("lecturerID").trim();
                    int numberRequest = rs.getInt("NumberCreatedSlot");
                    st = new UserMaxSlotDTO(id, numberRequest);
                }
            }else{
                
            System.out.println("rs bang null getLecturerMaxSlot(String semester)");
            }
            cn.close();
        }
        return st;
    }

    public static UserMaxRequestDTO getLecturerMaxRequest(String semester) throws Exception {
        UserMaxRequestDTO st = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select top 1 r.lecturerID, COUNT(*) as 'NumberOfRequestRev'\n"
                    + "from Requests r\n"
                    + "where r.semesterID = ?\n"
                    + "group by r.lecturerID\n"
                    + "order by [NumberOfRequestRev] desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, semester);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("lecturerID").trim();
                    int numberRequest = rs.getInt("NumberOfRequestRev");
                    st = new UserMaxRequestDTO(id, numberRequest);
                }
            }else{
                
            System.out.println("rs bang null getLecturerMaxRequest(String semester)");
            }
            cn.close();
        }
        return st;
    }
}
