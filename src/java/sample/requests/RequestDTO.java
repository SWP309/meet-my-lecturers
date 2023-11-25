package sample.requests;

import java.io.Serializable;

public class RequestDTO implements Serializable{
    private String requestID;
    private int status;
    private String subjectCode;
    private String freeSlotID;
    private String description;
    private String studentID;
    private String note;
    
    //bien ngoai lai
    private String studentName;
    private String startTime;
    private String endTime;
    private String lecturerID;
    private String lecturerName;
    private String semesterID;
    

    public RequestDTO() {
    }

    public RequestDTO(String requestID, int status, String subjectCode, String freeSlotID, String description, String studentID, String studentName, String startTime, String endTime, String semesterID) {
        this.requestID = requestID;
        this.status = status;
        this.subjectCode = subjectCode;
        this.freeSlotID = freeSlotID;
        this.description = description;
        this.studentID = studentID;
        this.studentName = studentName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.semesterID = semesterID;
    }

    public RequestDTO(String requestID, String studentID, String subjectCode, String freeSlotID, String description, String studentName, String startTime, String endTime, String semesterID) {
        this.requestID = requestID;
        this.subjectCode = subjectCode;
        this.freeSlotID = freeSlotID;
        this.description = description;
        this.studentID = studentID;
        this.studentName = studentName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.semesterID = semesterID;
    }
    
    

    public RequestDTO(String requestID, String note, int status, String subjectCode, String freeSlotID, String description, String startTime, String endTime, String lecturerID, String lecturerName, String semesterID) {
        this.requestID = requestID;
        this.status = status;
        this.subjectCode = subjectCode;
        this.freeSlotID = freeSlotID;
        this.description = description;
        this.note = note;
        this.startTime = startTime;
        this.endTime = endTime;
        this.lecturerID = lecturerID;
        this.lecturerName = lecturerName;
        this.semesterID = semesterID;
    }
   

 
    
    public RequestDTO(String requestID, String freeSlotID, int status, String subjectCode, String startTime, 
            String endTime, String description,String studentID, String lecturerID, String semesterID) {
        this.requestID = "";
        this.freeSlotID = "";
        this.status = 0;
        this.subjectCode = "";
        this.startTime = "";
        this.endTime = "";
        this.description = "";
        this.studentID = "";
        this.lecturerID = "";
        this.semesterID = "";
        this.note = "";
    }

    public RequestDTO(int status, String subjectCode, String freeSlotID, String description, String studentID, 
            String note, String studentName) {
        this.status = status;
        this.subjectCode = subjectCode;
        this.freeSlotID = freeSlotID;
        this.description = description;
        this.studentID = studentID;
        this.note = note;
        this.studentName = studentName;
    }
    
    
    /**
     * @return the requestID
     */
    public String getRequestID() {
        return requestID;
    }

    /**
     * @param requestID the requestID to set
     */
    public void setRequestID(String requestID) {
        this.requestID = requestID;
    }
   
    /**
     * @return the subjectCode
     */
    public String getSubjectCode() {
        return subjectCode;
    }

    /**
     * @param subjectCode the subjectCode to set
     */
    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }


    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the studentID
     */
    public String getStudentID() {
        return studentID;
    }

    /**
     * @param studentID the studentID to set
     */
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
     * @return the note
     */
    public String getNote() {
        return note;
    }

    /**
     * @param note the note to set
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * @return the studentName
     */
    public String getStudentName() {
        return studentName;
    }

    /**
     * @param studentName the studentName to set
     */
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    /**
     * @return the freeSlotID
     */
    public String getFreeSlotID() {
        return freeSlotID;
    }

    /**
     * @param freeSlotID the freeSlotID to set
     */
    public void setFreeSlotID(String freeSlotID) {
        this.freeSlotID = freeSlotID;
    }

    @Override
    public String toString() {
        return "RequestDTO{" + "requestID=" + getRequestID() + ", status=" + getStatus() + ", subjectCode=" + getSubjectCode() + ", freeSlotID=" + getFreeSlotID() + ", description=" + getDescription() + ", studentID=" + getStudentID() + ", note=" + getNote() + ", studentName=" + getStudentName() + ", startTime=" + getStartTime() + ", endTime=" + getEndTime() + ", lecturerID=" + getLecturerID() + ", semesterID=" + getSemesterID() + '}';
    }

    /**
     * @return the startTime
     */
    public String getStartTime() {
        return startTime;
    }

    /**
     * @param startTime the startTime to set
     */
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * @return the endTime
     */
    public String getEndTime() {
        return endTime;
    }

    /**
     * @param endTime the endTime to set
     */
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /**
     * @return the lecturerID
     */
    public String getLecturerID() {
        return lecturerID;
    }

    /**
     * @param lecturerID the lecturerID to set
     */
    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    /**
     * @return the semesterID
     */
    public String getSemesterID() {
        return semesterID;
    }

    /**
     * @param semesterID the semesterID to set
     */
    public void setSemesterID(String semesterID) {
        this.semesterID = semesterID;
    }

    /**
     * @return the lecturerName
     */
    public String getLecturerName() {
        return lecturerName;
    }

    /**
     * @param lecturerName the lecturerName to set
     */
    public void setLecturerName(String lecturerName) {
        this.lecturerName = lecturerName;
    }
    
    
    
}
