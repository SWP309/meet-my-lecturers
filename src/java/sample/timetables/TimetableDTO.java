
package sample.timetables;

public class TimetableDTO {
    private String subjectCode;
    private String slotID;
    private String lecturerID;
    private String semesterID;
    private String startTime;
    private String endTime;
    private String day1;
    private String day2;

    public TimetableDTO() {
        this.subjectCode = "";
        this.slotID = "";
        this.lecturerID = "";
        this.semesterID = "";
    }

    public TimetableDTO(String subjectCode, String slotID, String lecturerID, String semesterID) {
        this.subjectCode = subjectCode;
        this.slotID = slotID;
        this.lecturerID = lecturerID;
        this.semesterID = semesterID;
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
     * @return the slotID
     */
    public String getSlotID() {
        return slotID;
    }

    /**
     * @param slotID the slotID to set
     */
    public void setSlotID(String slotID) {
        this.slotID = slotID;
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
     * @return the day1
     */
    public String getDay1() {
        return day1;
    }

    /**
     * @param day1 the day1 to set
     */
    public void setDay1(String day1) {
        this.day1 = day1;
    }

    /**
     * @return the day2
     */
    public String getDay2() {
        return day2;
    }

    /**
     * @param day2 the day2 to set
     */
    public void setDay2(String day2) {
        this.day2 = day2;
    }
    
}
