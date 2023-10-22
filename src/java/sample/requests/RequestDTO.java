package sample.requests;

import java.io.Serializable;

public class RequestDTO implements Serializable{
    private String requestID;
    private boolean status;
    private String subjectCode;
    private String startTime;
    private String endTime;
    private String description;
    private String studentID;
    private String lecturerID;
    private String semesterID;

    public String getSemesterID() {
        return semesterID;
    }

    public void setSemesterID(String semesterID) {
        this.semesterID = semesterID;
    }

    public RequestDTO() {
        this.requestID = "";
        this.status = false;
        this.subjectCode = "";
        this.startTime = "";
        this.endTime = "";
        this.description = "";
        this.studentID = "";
        this.lecturerID = "";
        this.semesterID = "";
    }

    public RequestDTO(String requestID, boolean status, String subjectCode, String startTime, String endTime, String description, String studentID, String lecturerID, String semesterID) {
        this.requestID = requestID;
        this.status = status;
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.description = description;
        this.studentID = studentID;
        this.lecturerID = lecturerID;
        this.semesterID = semesterID;
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
     * @return the status
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(boolean status) {
        this.status = status;
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
    
    
}
