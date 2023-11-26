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
    private int status;
    private String lecturerID;

    //Biến ngoại lai
    private int numberOfAbsenceSlot;
    private int numberOfCancelSlot;
    private String semesterID;

    public BookingDTO() {
        this.subjectCode = "";
        this.lectureName = "";
        this.startTime = null;
        this.endTime = null;
        this.userName = "";
        this.bookingID = "";
        this.meetLink = "";
        this.freeSlotID = "";
        this.status = 0;
        this.numberOfAbsenceSlot = 0;
    }

    public BookingDTO(String freeSlotID, String studentID) {
        this.freeSlotID = freeSlotID;
        this.studentID = studentID;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public int getNumberOfCancelSlot() {
        return numberOfCancelSlot;
    }

    public void setNumberOfCancelSlot(int numberOfCancelSlot) {
        this.numberOfCancelSlot = numberOfCancelSlot;
    }

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID, String meetLink, String freeSlotID, String studentID, int status, String lecturerID, int numberOfAbsenceSlot, int numberOfCancelSlot, String semesterID) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
        this.meetLink = meetLink;
        this.freeSlotID = freeSlotID;
        this.studentID = studentID;
        this.status = status;
        this.lecturerID = lecturerID;
        this.numberOfAbsenceSlot = numberOfAbsenceSlot;
        this.numberOfCancelSlot = numberOfCancelSlot;
        this.semesterID = semesterID;
    }

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID, String meetLink, String freeSlotID, String studentID, int status, int numberOfAbsenceSlot) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
        this.meetLink = meetLink;
        this.freeSlotID = freeSlotID;
        this.studentID = studentID;
        this.status = status;
        this.numberOfAbsenceSlot = numberOfAbsenceSlot;
    }

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID, String meetLink, String freeSlotID, String studentID, int status) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
        this.meetLink = meetLink;
        this.freeSlotID = freeSlotID;
        this.studentID = studentID;
        this.status = status;
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

    public BookingDTO(String subjectCode, String lectureName, String startTime, String endTime, String userName, String bookingID, String meetLink, String semesterID) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.userName = userName;
        this.bookingID = bookingID;
        this.meetLink = meetLink;
        this.semesterID = semesterID;
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

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the numberOfAbsenceSlot
     */
    public int getNumberOfAbsenceSlot() {
        return numberOfAbsenceSlot;
    }

    /**
     * @param numberOfAbsenceSlot the numberOfAbsenceSlot to set
     */
    public void setNumberOfAbsenceSlot(int numberOfAbsenceSlot) {
        this.numberOfAbsenceSlot = numberOfAbsenceSlot;
    }

}
