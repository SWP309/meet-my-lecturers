package sample.freeslots;

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
    private int status;
    private String semesterID;
    //bien ngoai lai, t chi them vao cho de trong viec hien thi ten giang vien
    //bien nay khong co trong bang, nen la mn cu dat la String = null nha.
    private String lecturerName;

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
        this.status = 0; 
    }

    public String getLecturerName() {
        return lecturerName;
    }

    public void setLecturerName(String lecturerName) {
        this.lecturerName = lecturerName;
    }

    public FreeSlotsDTO(String freeSlotID, String subjectCode, String startTime, String endTime, String password, int capacity, String meetLink, int count, String lecturerID, int status, String semesterID, String lecturerName) {
        this.freeSlotID = freeSlotID;
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.password = password;
        this.capacity = capacity;
        this.meetLink = meetLink;
        this.count = count;
        this.lecturerID = lecturerID;
        this.status = status;
        this.semesterID = semesterID;
        this.lecturerName = lecturerName;
    }

    public FreeSlotsDTO(String subjectCode, String startTime, String endTime, String password, int capacity, String meetLink, int count, String lecturerID, int status, String semesterID) {
        this.subjectCode = subjectCode;
        this.startTime = startTime;
        this.endTime = endTime;
        this.password = password;
        this.capacity = capacity;
        this.meetLink = meetLink;
        this.count = count;
        this.lecturerID = lecturerID;
        this.status = status;
        this.semesterID = semesterID;
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

    public int getStatus() {
        return isStatus();
    }

    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the status
     */
    public int isStatus() {
        return status;
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
