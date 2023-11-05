/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.users;

/**
 *
 * @author PC
 */
public class Top3StudentDTO {

    private String userID;
    private String userName;
    private String bookingCount;

    public Top3StudentDTO() {
        this.userID = "";
        this.userName = "";
        this.bookingCount = "";
    }

    public Top3StudentDTO(String userID, String userName, String bookingCount) {
        this.userID = userID;
        this.userName = userName;
        this.bookingCount = bookingCount;
    }

    @Override
    public String toString() {
        return "Top3StudentDTO{" + "userID=" + userID + ", userName=" + userName + ", bookingCount=" + bookingCount + '}';
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(String bookingCount) {
        this.bookingCount = bookingCount;
    }

}
