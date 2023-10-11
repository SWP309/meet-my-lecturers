
package sample.timetables;

public class TimetableDTO {
    private String subjectCode;
    private String slotID;
    private String lecturerID;
    private String semesterID;

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
    
}
