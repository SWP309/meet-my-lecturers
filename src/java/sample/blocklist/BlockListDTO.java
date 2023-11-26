/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.blocklist;

/**
 *
 * @author W10(hiep-tm)
 */
public class BlockListDTO {

    private String lecturerID;
    private String studentID;
    private int status;
    //bien ngoai lai
    private String userName;
    private String userEmail;

    public BlockListDTO() {
        this.lecturerID = "";
        this.studentID = "";
        this.status = 0;// 0:unblock | 1:block
    }

    public BlockListDTO(String lecturerID, String studentID, int status) {
        this.lecturerID = lecturerID;
        this.studentID = studentID;
        this.status = status;
    }
    public BlockListDTO(String lecturerID, String studentID, String userName, String userEmail, int status) {
        this.lecturerID = lecturerID;
        this.studentID = studentID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.status = status;
    }

    public BlockListDTO(String lecturerID, String studentID) {
        this.lecturerID = lecturerID;
        this.studentID = studentID;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

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
    
}
