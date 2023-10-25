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
    private int number;

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
       
}
