/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dashboard;

import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class UserMaxSlotDTO {

    private String userID;
    private String userName;
    private String userEmail;
    private int number;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "UserMaxSlotDTO{" + "student=" + userID + ", number=" + number + '}';
    }

    public UserMaxSlotDTO() {
    }

    public UserMaxSlotDTO(String studentID, int number) {
        this.userID = studentID;
        this.number = number;
    }

    public UserMaxSlotDTO(String userID, String userName, String userEmail, int number) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.number = number;
    }

}
