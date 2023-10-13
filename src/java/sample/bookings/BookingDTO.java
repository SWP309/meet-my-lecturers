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

    public BookingDTO() {
        this.subjectCode = "";
        this.lectureName = "";
        this.startTime = null;
        this.endTime = null;
        this.userName = "";
        this.bookingID = "";
    }

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
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
}
