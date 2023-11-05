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
    private String studentID;
    private int bookedStudent;
    private String block_list;

    public FreeSlotsDTO() {
        this.freeSlotID = "";
        this.subjectCode = "";
        this.startTime = "";
        this.endTime = "";
        this.password = "";
        this.capacity = 0;
        this.meetLink = "";
        this.count = 0;
        this.lecturerID = "";
        this.status = 1;
        this.semesterID = "";
        this.lecturerName = "";
        this.bookedStudent = 0;
        this.block_list = null;
        this.studentID = "";
    }
    

    public String getLecturerName() {
        return lecturerName;
    }

    public void setLecturerName(String lecturerName) {
        this.lecturerName = lecturerName;
    }
    
    public FreeSlotsDTO(String subjectCode, String startTime, String endTime, String password, int capacity, String meetLink, int count, String lecturerID, int status, String semesterID, String block_list) {
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
        this.block_list = block_list;
    }

    public FreeSlotsDTO(String freeSlotID, String subjectCode, String startTime, String endTime, String password, int capacity, String meetLink, int count, String lecturerID, int status, String semesterID, String lecturerName, int bookedStudent) {
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
        this.bookedStudent = bookedStudent;
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
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the bookedStudent
     */
    public int getBookedStudent() {
        return bookedStudent;
    }

    /**
     * @param bookedStudent the bookedStudent to set
     */
    public void setBookedStudent(int bookedStudent) {
        this.bookedStudent = bookedStudent;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
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
     * @return the block_list
     */
    public String getBlock_list() {
        return block_list;
    }

    /**
     * @param block_list the block_list to set
     */
    public void setBlock_list(String block_list) {
        this.block_list = block_list;
    }

}
