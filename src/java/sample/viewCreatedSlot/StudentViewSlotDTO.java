/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.viewCreatedSlot;

/**
 *
 * @author PC
 */
public class StudentViewSlotDTO {

    private String subjectCode;
    private String studentName;
    private String startTime;
    private String endTime;
    private String userName;
    private String freeSlotID;

    public StudentViewSlotDTO() {
        this.subjectCode = "";
        this.studentName = "";
        this.startTime = null;
        this.endTime = null;
        this.userName = "";
        this.freeSlotID = "";
    }

    public StudentViewSlotDTO(String subjectCode, String studentName, String startTime, String endTime, String userName, String freeSlotID) {
        this.subjectCode = subjectCode;
        this.studentName = studentName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.freeSlotID = freeSlotID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFreeSlotID() {
        return freeSlotID;
    }

    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }

}
