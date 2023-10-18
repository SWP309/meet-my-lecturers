package sample.users;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.roles.RoleDTO;
import sample.utils.DBUtils;

public class UserDAO implements Serializable{
    private final String SEARCH_LECTURERS = "SELECT userID, userName, userEmail\n" +
            "FROM Users\n" +
            "WHERE roleID = 2 AND userStatus = 1";
    
    private final String SEARCH_USERS_BY_ROLEID = "SELECT r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n" +
            "FROM Users u\n" +
            "JOIN Roles r ON u.roleID = r.roleID \n" +
            "WHERE u.roleID = ?";
    
    private final String SEARCH_USERS_BY_NAME = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n" +
            "FROM Users u\n" +
            "JOIN Roles r ON u.roleID = r.roleID \n" +
            "WHERE u.userName like ?";
    
    private final String SEARCH_USERS_BY_ROLEID_AND_NAME = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n" +
            "FROM Users u\n" +
            "JOIN Roles r ON u.roleID = r.roleID \n" +
            "WHERE u.userName like ? AND u.roleID = ?";
    
    private final String SEARCH_USERS = "SELECT u.roleID, r.roleName, u.userID, u.userName, u.userEmail, u.password, u.userStatus\n" +
            "FROM Users u\n" +
            "JOIN Roles r ON u.roleID = r.roleID";
    
    private final String UPDATE_USER = "UPDATE Users\n" +
            "   SET userName = ?\n" +
            "      ,userEmail = ?\n" +
            "      ,userStatus = ?\n" +
            "      ,password = ?\n" +
            " WHERE userID = ?";
    
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
            while(rs.next()){
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, true, "2", "");
                if(this.lecturers == null){
                    this.lecturers = new ArrayList<>();
                }
                this.lecturers.add(userDTO);
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
            while(rs.next()){
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                boolean userStatus = rs.getBoolean("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if(this.usersByRoleID == null){
                    this.usersByRoleID = new ArrayList<>();
                }
                this.usersByRoleID.add(userDTO);
                if(this.rolesByRoleID == null){
                    this.rolesByRoleID = new ArrayList<>();
                }
                this.rolesByRoleID.add(roleDTO);
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
            while(rs.next()){
                String roleID = rs.getNString("roleID");
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                boolean userStatus = rs.getBoolean("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if(this.usersByName == null){
                    this.usersByName = new ArrayList<>();
                }
                this.usersByName.add(userDTO);
                if(this.rolesByName == null){
                    this.rolesByName = new ArrayList<>();
                }
                this.rolesByName.add(roleDTO);
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
            stm.setString(2, roleID);
            rs = stm.executeQuery();
            while(rs.next()){
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                boolean userStatus = rs.getBoolean("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if(this.usersByNameAndRoleID == null){
                    this.usersByNameAndRoleID = new ArrayList<>();
                }
                this.usersByNameAndRoleID.add(userDTO);
                if(this.rolesByNameAndRoleID == null){
                    this.rolesByNameAndRoleID = new ArrayList<>();
                }
                this.rolesByNameAndRoleID.add(roleDTO);
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
            while(rs.next()){
                String roleID = rs.getNString("roleID");
                String roleName = rs.getNString("roleName");
                String userID = rs.getString("userID");
                String userName = rs.getNString("userName");
                String userEmail = rs.getString("userEmail");
                String password = rs.getNString("password");
                boolean userStatus = rs.getBoolean("userStatus");
                UserDTO userDTO = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                RoleDTO roleDTO = new RoleDTO(roleID, roleName);
                if(this.users == null){
                    this.users = new ArrayList<>();
                }
                this.users.add(userDTO);
                if(this.roles == null){
                    this.roles = new ArrayList<>();
                }
                this.roles.add(roleDTO);
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
            stm.setBoolean(3, userDTO.isUserStatus());
            stm.setNString(4, userDTO.getPassword());
            stm.setString(5, userDTO.getUserID());
            result = stm.executeUpdate();
            if(result > 0){
                checkUpdate = true;
            }
        } finally {
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        return checkUpdate;
    }

    
    
}