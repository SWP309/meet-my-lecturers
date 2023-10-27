/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

/**
 *
 * @author W10(hiep-tm)
 */
public class FreeSlotsDTO {

    private String freeSlotID;
    private String subjectCode;
    private String startTime;
    private String endTime;
    private String password;
    private int capacity;
    private String meetLink;
    private int count;
    private String lecturerID;
    private boolean status;

    public FreeSlotsDTO() {
        this.freeSlotID = "";
        this.subjectCode = "";
        this.startTime = null;
        this.endTime = null;
        this.password = null;
        this.capacity = 0;
        this.meetLink = "";
        this.count = 0;
        this.lecturerID = "";
        this.status = true;
    }

    public FreeSlotsDTO(String subjectCode, String startTime, String endTime, String password, int capacity, String meetLink, int count, String lecturerID, boolean  status) {
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.password = password;
        this.capacity = capacity;
        this.meetLink = meetLink;
        this.count = count;
        this.lecturerID = lecturerID;
        this.status = status;
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
    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
