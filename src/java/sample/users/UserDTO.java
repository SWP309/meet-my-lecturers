package sample.users;

import java.util.Objects;

public class UserDTO {
    private String userID;
    private String userName;
    private String userEmail;
    private boolean userStatus;
    private String roleID;
    private String password;
    
    public UserDTO() {
        this.userID = "";
        this.userName = "";
        this.userEmail = "";
        this.userStatus = true;
        this.roleID = "";
        this.password = "";
    }

    public UserDTO(String userID, String userName, String userEmail, boolean userStatus, String roleID, String password) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userStatus = userStatus;
        this.roleID = roleID;
        this.password = password;
    }

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * @return the userName
     */
    public String getUserName() {
        return userName;
    }

    /**
     * @param userName the userName to set
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * @return the userEmail
     */
    public String getUserEmail() {
        return userEmail;
    }

    /**
     * @param userEmail the userEmail to set
     */
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    /**
     * @return the userStatus
     */
    public boolean isUserStatus() {
        return userStatus;
    }

    /**
     * @param userStatus the userStatus to set
     */
    public void setUserStatus(boolean userStatus) {
        this.userStatus = userStatus;
    }

    /**
     * @return the roleID
     */
    public String getRoleID() {
        return roleID;
    }

    /**
     * @param roleID the roleID to set
     */
    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof UserDTO) {
            UserDTO another = (UserDTO) obj;
            if (this.roleID.equals(another.roleID)) {
                return true;
            }
        }
        return false;
    }

    
}
        