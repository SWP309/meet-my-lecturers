package sample.users;

import java.io.Serializable;

public class UserDTO implements Serializable{
    private String userID;
    private String userName;
    private String userEmail;
    private boolean userStatus;
    private String timetableID;
    private String roleID;
    private String password;
    private String requestID;
    private String freeSlotID;

    public UserDTO() {
        this.userID = "";
        this.userName = "";
        this.userEmail = "";
        this.userStatus = true;
        this.timetableID = "";
        this.roleID = "";
        this.password = "";
        this.requestID = "";
        this.freeSlotID = "";
    }

    public UserDTO(String userID, String userName, String userEmail, boolean userStatus, String timetableID, String roleID, String password, String requestID, String freeSlotID) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userStatus = userStatus;
        this.timetableID = timetableID;
        this.roleID = roleID;
        this.password = password;
        this.requestID = requestID;
        this.freeSlotID = freeSlotID;
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
     * @return the timetableID
     */
    public String getTimetableID() {
        return timetableID;
    }

    /**
     * @param timetableID the timetableID to set
     */
    public void setTimetableID(String timetableID) {
        this.timetableID = timetableID;
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

    /**
     * @return the requestID
     */
    public String getRequestID() {
        return requestID;
    }

    /**
     * @param requestID the requestID to set
     */
    public void setRequestID(String requestID) {
        this.requestID = requestID;
    }

    /**
     * @return the freeSlotID
     */
    public String getFreeSlotID() {
        return freeSlotID;
    }

    /**
     * @param freeSlotID the freeSlotID to set
     */
    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }
    
    
}
        