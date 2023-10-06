/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.bookings;

import java.sql.Date;

/**
 *
 * @author PC
 */
public class BookingDTO {

    private String subjectCode;
    private String userName;
    private String semesterName;
    private java.sql.Date startTime;
    private java.sql.Date endTime;

    public BookingDTO() {
        this.subjectCode = "";
        this.userName = "";
        this.semesterName = "";
        this.startTime = null;
        this.endTime = null;
    }

    public BookingDTO(String subjectCode, String userName, String semesterName, Date startTime, Date endTime) {
        this.subjectCode = subjectCode;
        this.userName = userName;
        this.semesterName = semesterName;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

}
