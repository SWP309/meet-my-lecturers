/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.bookings;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author PC
 */
public class BookingDTO {

    private String subjectCode;
    private String lectureName;
    private String startTime;
    private String endTime;
    private String userName;
    private String bookingID;
    private String meetLink;
    private String freeSlotID;
    private String studentID;

    public BookingDTO() {
        this.subjectCode = "";
        this.lectureName = "";
        this.startTime = null;
        this.endTime = null;
        this.userName = "";
        this.bookingID = "";
        this.meetLink = "";
        this.freeSlotID = "";
    }

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID, String meetLink) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
        this.meetLink = meetLink;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getLectureName() {
        return lectureName;
    }

    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
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

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getMeetLink() {
        return meetLink;
    }

    public void setMeetLink(String meetLink) {
        this.meetLink = meetLink;
    }

    public String getFreeSlotID() {
        return freeSlotID;
    }

    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

   

}
