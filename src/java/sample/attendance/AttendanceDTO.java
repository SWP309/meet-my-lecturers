/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.attendance;

/**
 *
 * @author Minh Khang
 */
public class AttendanceDTO {
    private String freeSlotID;
    private String semesterID;
    private String subjectCode;
    private String startTime;
    private String endTime;
    private byte status;
    private String studentID;

    public AttendanceDTO() {
    }

    public AttendanceDTO(String freeSlotID, String semesterID, String subjectCode, String startTime, String endTime, byte status) {
        this.freeSlotID = freeSlotID;
        this.semesterID = semesterID;
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    
    public AttendanceDTO(String freeSlotID, String semesterID, String subjectCode, String startTime, String endTime, byte status, String studentID) {
        this.freeSlotID = freeSlotID;
        this.semesterID = semesterID;
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.studentID = studentID;
    }

    public String getFreeSlotID() {
        return freeSlotID;
    }

    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }

    public String getSemesterID() {
        return semesterID;
    }

    public void setSemesterID(String semesterID) {
        this.semesterID = semesterID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
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

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }
    
    
}
