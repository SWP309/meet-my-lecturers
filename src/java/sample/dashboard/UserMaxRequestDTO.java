/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dashboard;

/**
 *
 * @author Minh Khang
 */
public class UserMaxRequestDTO {
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

    public UserMaxRequestDTO() {
    }

    public UserMaxRequestDTO(String lecturerID, int number) {
        this.userID = lecturerID;
        this.number = number;
    }

    @Override
    public String toString() {
        return "UserMaxRequestDTO{" + "lecturerID=" + userID + ", number=" + number + '}';
    }
       
}
