/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

import java.time.LocalDateTime;

/**
 *
 * @author W10(hiep-tm)
 */
public class FreeSlotsDTO {

    private String freeSlotID;
    private String subjectCode;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String password;
    private int capacity;
    private String meetLink;
    private int count;
    private String lecturerID;

    public FreeSlotsDTO() {
        this.freeSlotID = "";
        this.subjectCode = "";
        this.startTime = null;
        this.endTime = null;
        this.password = "";
        this.capacity = 0;
        this.meetLink = "";
        this.count = 0;
        this.lecturerID = "";
    }

    public FreeSlotsDTO(String freeSlotID, String subjectCode, LocalDateTime startTime, LocalDateTime endTime, String password, int capacity, String meetLink, int count, String lecturerID) {
        this.freeSlotID = freeSlotID;
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.password = password;
        this.capacity = capacity;
        this.meetLink = meetLink;
        this.count = count;
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

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getMeetLink() {
        return meetLink;
    }

    public void setMeetLink(String meetLink) {
        this.meetLink = meetLink;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

}