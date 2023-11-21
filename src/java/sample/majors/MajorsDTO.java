/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.majors;

/**
 *
 * @author Minh Khang
 */
public class MajorsDTO {
    private String lecturerID;
    private String subjectCode;
    private String semesterID;

    public MajorsDTO() {
    }

    public MajorsDTO(String lecturerID, String subjectCode, String semesterID) {
        this.lecturerID = lecturerID;
        this.subjectCode = subjectCode;
        this.semesterID = semesterID;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSemesterID() {
        return semesterID;
    }

    public void setSemesterID(String semesterID) {
        this.semesterID = semesterID;
    }

    public MajorsDTO(String subjectCode) {
        this.subjectCode = subjectCode;
    }
    
}
