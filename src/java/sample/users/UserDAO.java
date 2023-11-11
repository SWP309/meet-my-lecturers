package sample.users;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import sample.roles.RoleDTO;
import sample.dashboard.UserMaxRequestDTO;
import sample.dashboard.UserMaxSlotDTO;
import sample.utils.DBUtils;

public class UserDAO implements Serializable {

    private final String SEARCH_LECTURERS = "SELECT userID, userName, userEmail\n"
            + "FROM Users\n"
            + "WHERE roleID = 2 AND userStatus = 1";
    private final String SEARCH_TOP3_STUDENT = "SELECT top 3 b.studentID, u.userName, COUNT(b.bookingID) AS bookingCount\n"
            + "FROM Bookings b\n"
            + "JOIN Users u ON u.userID = b.studentID\n"
            + "GROUP BY b.studentID, u.userName\n"
            + "ORDER BY bookingCount DESC";

    private final String SEARCH_USERS_BY_ROLEID = "SELECT r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "FROM Users u\n"
            + "JOIN Roles r ON u.roleID = r.roleID \n"
            + "WHERE u.roleID = ?";

    private static final String SEARCH_LECTURER_MAX_FS_NUMBER = "select top 5 fs.lecturerID, count(*) as 'NumberCreatedSlot'\n"
            + "                    from FreeSlots fs\n"
            + "                    where fs.semesterID = ( SELECT s.semesterID\n"
            + "											FROM Semesters s\n"
            + "											WHERE ? BETWEEN s.startDay AND s.endDay)\n"
            + "                    AND fs.status = 1\n"
            + "					group by fs.lecturerID\n"
            + "					order by [NumberCreatedSlot] desc";

    private static final String SEARCH_LECTURER_MAX_REQUEST_NUMBER = "select top 5 r.lecturerID, COUNT(*) as 'NumberOfRequestRec'\n" +
"                    from Requests r\n" +
"                    where r.semesterID = ( SELECT s.semesterID\n" +
"			FROM Semesters s\n" +
"			WHERE ? BETWEEN s.startDay AND s.endDay)\n" +
"			AND r.status = 1\n" +
"                    group by r.lecturerID\n" +
"                    order by [NumberOfRequestRec] desc";

    private final String SEARCH_USERS_BY_USERID = "SELECT r.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "            FROM Users u\n"
            + "            JOIN Roles r ON u.roleID = r.roleID \n"
            + "            WHERE u.userID = ?";

    private final String SEARCH_USERS_BY_NAME = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "FROM Users u\n"
            + "JOIN Roles r ON u.roleID = r.roleID \n"
            + "WHERE u.userName like ?";

    private final String SEARCH_USERS_BY_ROLEID_AND_NAME = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "FROM Users u\n"
            + "JOIN Roles r ON u.roleID = r.roleID \n"
            + "WHERE u.userName like ? AND u.roleID = ?";

    private final String SEARCH_USERS_BY_ROLEID_AND_NAME_AND_USERID = "SELECT r.roleName, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "FROM Users u\n"
            + "JOIN Roles r on u.roleID = r.roleID \n"
            + "WHERE u.userName like ? AND u.roleID = ? AND u.userID = ?";

    private final String SEARCH_USERS = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n"
            + "FROM Users u\n"
            + "JOIN Roles r ON u.roleID = r.roleID";

    private final String UPDATE_USER = "UPDATE Users\n"
            + "   SET userName = ?\n"
            + "      ,userEmail = ?\n"
            + "      ,userStatus = ?\n"
            + "      ,password = ?\n"
            + " WHERE userID = ?";

    private final String BAN_USER = "UPDATE Users\n"
            + "SET userStatus = 0\n"
            + "WHERE userID = ?";

    private List<UserDTO> lecturers;

    public List<UserDTO> getLecturers() {
        return lecturers;
    }

    public List<Top3StudentDTO> GetlistTop3() throws SQLException {
        List<Top3StudentDTO> listTop3 = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_TOP3_STUDENT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String studentID = rs.getString("studentID");
                    String userName = rs.getString("userName");
                    String bookingCount = rs.getString("bookingCount");
                    listTop3.add(new Top3StudentDTO(studentID, userName, bookingCount));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listTop3;
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
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, 1, "2", "");
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
                    int status = rs.getInt("userStatus");
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
                    int status = rs.getInt("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }

    public static UserDTO getUserByID(String user_id) throws Exception {
        UserDTO us = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select *\n"
                    + "from [dbo].[Users]\n"
                    + " where userID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, user_id);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String id = rs.getString("userID").trim();
                    String name = rs.getString("userName").trim();
                    String email = rs.getString("userEmail").trim();
                    int status = rs.getInt("userStatus");
                    String roleID = rs.getString("roleID").trim();
                    String password = rs.getString("password").trim();
                    us = new UserDTO(id, name, email, status, roleID, password);
                }
            }
            cn.close();
        }
        return us;
    }

    private List<UserDTO> usersByRoleID;

    public List<UserDTO> getUsersByRoleID() {
        return usersByRoleID;
    }

    private List<RoleDTO> rolesByRoleID;

    public List<RoleDTO> getRolesByRoleID() {
        return rolesByRoleID;
    }

    public void getUsersByRoleID(String roleID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS_BY_ROLEID);
            stm.setString(1, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.usersByRoleID == null) {
                    this.usersByRoleID = new ArrayList<>();
                }
                this.usersByRoleID.add(userDTO);
                if (this.rolesByRoleID == null) {
                    this.rolesByRoleID = new ArrayList<>();
                }
                this.rolesByRoleID.add(roleDTO);
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

    private List<UserDTO> usersByName;

    public List<UserDTO> getUsersByName() {
        return usersByName;
    }
    private List<RoleDTO> rolesByName;

    public List<RoleDTO> getRolesByName() {
        return rolesByName;
    }

    public void getUsersByName(String name) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS_BY_NAME);
            stm.setNString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleID = rs.getNString("roleID");
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.usersByName == null) {
                    this.usersByName = new ArrayList<>();
                }
                this.usersByName.add(userDTO);
                if (this.rolesByName == null) {
                    this.rolesByName = new ArrayList<>();
                }
                this.rolesByName.add(roleDTO);
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

    private List<UserDTO> usersByNameAndRoleID;

    public List<UserDTO> getUsersByNameAndRoleID() {
        return usersByNameAndRoleID;
    }

    private List<RoleDTO> rolesByNameAndRoleID;

    public List<RoleDTO> getRolesByNameAndRoleID() {
        return rolesByNameAndRoleID;
    }

    public void getUsersByNameAndRoleID(String name, String roleID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS_BY_ROLEID_AND_NAME);
            stm.setNString(1, "%" + name + "%");
            stm.setNString(2, roleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.usersByNameAndRoleID == null) {
                    this.usersByNameAndRoleID = new ArrayList<>();
                }
                this.usersByNameAndRoleID.add(userDTO);
                if (this.rolesByNameAndRoleID == null) {
                    this.rolesByNameAndRoleID = new ArrayList<>();
                }
                this.rolesByNameAndRoleID.add(roleDTO);
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
    private List<UserDTO> users;

    public List<UserDTO> getUsers() {
        return users;
    }

    private List<RoleDTO> roles;

    public List<RoleDTO> getRoles() {
        return roles;
    }

    public void getUsersFunc() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS);
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleID = rs.getNString("roleID");
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.users == null) {
                    this.users = new ArrayList<>();
                }
                this.users.add(userDTO);
                if (this.roles == null) {
                    this.roles = new ArrayList<>();
                }
                this.roles.add(roleDTO);
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

    public boolean updateAUser(UserDTO userDTO) throws ClassNotFoundException, SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(UPDATE_USER);
            stm.setNString(1, userDTO.getUserName());
            stm.setString(2, userDTO.getUserEmail());
            stm.setInt(3, userDTO.getUserStatus());
            stm.setNString(4, userDTO.getPassword());
            stm.setString(5, userDTO.getUserID());
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }
    public boolean banUser(String userID) throws ClassNotFoundException, SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement stm = null;
        int result;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(BAN_USER);
            stm.setString(1, userID);
            result = stm.executeUpdate();
            if (result > 0) {
                checkUpdate = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    private List<UserDTO> usersByUserID;

    public List<UserDTO> getUsersByUserID() {
        return usersByUserID;
    }

    private List<RoleDTO> rolesByUserID;

    public List<RoleDTO> getRolesByUserID() {
        return rolesByUserID;
    }

    public void getUsersByUserID(String userID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS_BY_USERID);
            stm.setNString(1, userID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleID = rs.getNString("roleID");
                String roleName = rs.getNString("roleName");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.usersByUserID == null) {
                    this.usersByUserID = new ArrayList<>();
                }
                this.usersByUserID.add(userDTO);
                if (this.rolesByUserID == null) {
                    this.rolesByUserID = new ArrayList<>();
                }
                this.rolesByUserID.add(roleDTO);
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

    private List<UserDTO> usersByUserIDAndNameAndRoleID;

    public List<UserDTO> getUsersByUserIDAndNameAndRoleID() {
        return usersByUserIDAndNameAndRoleID;
    }

    private List<RoleDTO> rolesByUserIDAndNameAndRoleID;

    public List<RoleDTO> getRolesByUserIDAndNameAndRoleID() {
        return rolesByUserIDAndNameAndRoleID;
    }

    public void getUsersByUserIDAndNameAndRoleID(String userID, String name, String roleID) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_USERS_BY_ROLEID_AND_NAME_AND_USERID);
            stm.setNString(1, "%" + name + "%");
            stm.setNString(2, roleID);
            stm.setNString(3, userID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String roleName = rs.getNString("roleName");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                int userStatus = rs.getInt("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if (this.usersByUserIDAndNameAndRoleID == null) {
                    this.usersByUserIDAndNameAndRoleID = new ArrayList<>();
                }
                this.usersByUserIDAndNameAndRoleID.add(userDTO);
                if (this.rolesByUserIDAndNameAndRoleID == null) {
                    this.rolesByUserIDAndNameAndRoleID = new ArrayList<>();
                }
                this.rolesByUserIDAndNameAndRoleID.add(roleDTO);
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
            } else {
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
            } else {
                System.out.println("rs bang null getStudentMaxRequest(String semester)");

            }
            cn.close();
        }
        return st;
    }

    public static List<UserDTO> getLecturerMaxFSNumber(Date currentDate) throws SQLException, ClassNotFoundException {
        List<UserDTO> listUser = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_LECTURER_MAX_FS_NUMBER);
                ptm.setTimestamp(1, new Timestamp(currentDate.getTime()));
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String lecturerID = rs.getString("lecturerID");
                    int createdSlot = rs.getInt("NumberCreatedSlot");
                    UserDTO userDTO = new UserDTO();
                    userDTO.setUserID(lecturerID);
                    userDTO.setCreatedSlot(createdSlot);
                    listUser.add(userDTO);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listUser;
    }
    
    public static List<UserDTO> getLecturerMaxRequestNumber(Date currentDate) throws SQLException, ClassNotFoundException, ParseException {
        List<UserDTO> listUser = new ArrayList<>();
        System.out.println("UserDAO getLecturerMaxRequestNumber");
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                System.out.println(currentDate);
                
                ptm = conn.prepareStatement(SEARCH_LECTURER_MAX_REQUEST_NUMBER);
                String start = services.Service.sdfDateTime.format(currentDate);
                ptm.setTimestamp(1, new Timestamp(services.Service.sdfDateTime.parse(start).getTime()));
                System.out.println("980");
                rs = ptm.executeQuery();
                System.out.println("hjk");
                while (rs.next()) {
                    String lecturerID = rs.getString("lecturerID");
                    int receivedRequest = rs.getInt("NumberOfRequestRec");
                    UserDTO userDTO = new UserDTO();
                    userDTO.setUserID(lecturerID);
                    userDTO.setReceivedRequest(receivedRequest);
                    listUser.add(userDTO);
                    System.out.println(userDTO.toString());
                }
                System.out.println("dfghdfh");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listUser;
    }

    public static int ImportExcelUsers(UserDTO users) throws ClassNotFoundException, SQLException {
        Connection cn = DBUtils.getConnection();
        int rs = 0;
        if (cn != null) {
            String sql = "INSERT INTO [dbo].[Users] (userID, userName, userEmail, userStatus, roleID, password)\n"
                    + "VALUES (?, ?, ?, ?, ?, ?);";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, users.getUserID());
            pst.setString(2, users.getUserName());
            pst.setString(3, users.getUserEmail());
            pst.setInt(4, users.getUserStatus());
            pst.setString(5, users.getRoleID());
            pst.setString(6, users.getPassword());
            rs = pst.executeUpdate();
            cn.close();
            pst.close();
        } else {
            System.out.println("Error Import Excel func");
        }
        return rs;
    }

    public static int changePassword(String userid, String password) throws Exception {
        int rs = 0;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "Update dbo.Users\n"
                    + "Set password = ?,\n"
                    + " userStatus = 1\n"
                    + "Where userID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, password);
            pst.setString(2, userid);
            rs = pst.executeUpdate();
            cn.close();
        }
        return rs;
    }
}
