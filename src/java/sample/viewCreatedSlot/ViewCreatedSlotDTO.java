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
public class ViewCreatedSlotDTO {

    private String subjectCode;
    private String lectureName;
    private String startTime;
    private String endTime;
    private String freeSlotID;
    private String semesterID;
    private String meetLink;
    private int joinedMembers;
    private int capacity;

    public ViewCreatedSlotDTO() {
        this.subjectCode = "";
        this.lectureName = "";
        this.startTime = null;
        this.endTime = null;
        this.freeSlotID = "";
        this.semesterID = "";
        this.meetLink = "";
        this.joinedMembers = 0;
        this.capacity = 0;
    }

    public ViewCreatedSlotDTO(String subjectCode, String lectureName, String startTime, String endTime, String freeSlotID, String semesterID, String meetLink, int joinedMembers, int capacity) {
        this.subjectCode = subjectCode;
        this.lectureName = lectureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.freeSlotID = freeSlotID;
        this.semesterID = semesterID;
        this.meetLink = meetLink;
        this.joinedMembers = joinedMembers;
        this.capacity = capacity;
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

    public String getMeetLink() {
        return meetLink;
    }

    public void setMeetLink(String meetLink) {
        this.meetLink = meetLink;
    }

    /**
     * @return the joinedMembers
     */
    public int getJoinedMembers() {
        return joinedMembers;
    }

    /**
     * @param joinedMembers the joinedMembers to set
     */
    public void setJoinedMembers(int joinedMembers) {
        this.joinedMembers = joinedMembers;
    }

    /**
     * @return the capacity
     */
    public int getCapacity() {
        return capacity;
    }

    /**
     * @param capacity the capacity to set
     */
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

}
