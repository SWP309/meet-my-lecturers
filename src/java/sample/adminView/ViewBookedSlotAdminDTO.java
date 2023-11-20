/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.adminView;

/**
 *
 * @author Minh Khang
 */
public class ViewBookedSlotAdminDTO {
    private String studentID;
    private String lecturerID;
    private String freeSlotID;
    private String subjectCode;
    private String meetLink;
    private String startTime;
    private String endTime;

    public ViewBookedSlotAdminDTO() {
    }

    public ViewBookedSlotAdminDTO(String lecturerID, String studentID, String freeSlotID, String subjectCode, String meetLink, String startTime, String endTime) {
        this.lecturerID = lecturerID;
        this.studentID = studentID;
        this.freeSlotID = freeSlotID;
        this.subjectCode = subjectCode;
        this.meetLink = meetLink;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public String getFreeSlotID() {
        return freeSlotID;
    }

    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getMeetLink() {
        return meetLink;
    }

    public void setMeetLink(String meetLink) {
        this.meetLink = meetLink;
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
    
    
}
