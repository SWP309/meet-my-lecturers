package sample.users;

import java.io.Serializable;

public class UserDTO implements Serializable{

    private String userID;
    private String userName;
    private String userEmail;
    private int userStatus;
    private String roleID;
    private String password;
    //bien ngoai lai
    private int createdSlot;
    private int receivedRequest;

    public UserDTO() {
        this.userID = "";
        this.userName = "";
        this.userEmail = "";
        this.userStatus = 1;
        this.roleID = "";
        this.password = "";
        this.createdSlot = 0;
        this.receivedRequest = 0;
    }

    public UserDTO(String userID, String userName, String userEmail, int userStatus, String roleID, String password) {
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

    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
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
            if (this.getRoleID().equals(another.getRoleID())) {
                return true;
            }
        }
        return false;
    }

    /**
     * @return the createdSlot
     */
    public int getCreatedSlot() {
        return createdSlot;
    }

    /**
     * @param createdSlot the createdSlot to set
     */
    public void setCreatedSlot(int createdSlot) {
        this.createdSlot = createdSlot;
    }

    /**
     * @return the receivedRequest
     */
    public int getReceivedRequest() {
        return receivedRequest;
    }

    /**
     * @param receivedRequest the receivedRequest to set
     */
    public void setReceivedRequest(int receivedRequest) {
        this.receivedRequest = receivedRequest;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userID=" + userID + ", userName=" + userName + ", userEmail=" + userEmail + ", userStatus=" + userStatus + ", roleID=" + roleID + ", password=" + password + ", createdSlot=" + createdSlot + ", receivedRequest=" + receivedRequest + '}';
    }

}
