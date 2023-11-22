/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.major;

/**
 *
 * @author CHIBAO
 */
public class MajorDTO {

    /**
     * @param args the command line arguments
     */
    private String semesterID;
    private String lecturerID;
    private String subjectCode;
    //bien ngoai lai
    private String subjectName;

    public MajorDTO() {
    }

    public MajorDTO(String semesterID, String lecturerID, String subjectCode, String subjectName) {
        this.semesterID = semesterID;
        this.lecturerID = lecturerID;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
    }
    
    

    public MajorDTO(String semesterID, String lecturerID, String subjectCode) {
        this.semesterID = semesterID;
        this.lecturerID = lecturerID;
        this.subjectCode = subjectCode;
    }

    public String getSemesterID() {
        return semesterID;
    }

    public void setSemesterID(String semesterID) {
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

    @Override
    public String toString() {
        return "MajorDTO{" + "semesterID=" + getSemesterID() + ", lecturerID=" + getLecturerID() + ", subjectCode=" + getSubjectCode() + '}';
    }

    /**
     * @return the subjectName
     */
    public String getSubjectName() {
        return subjectName;
    }

    /**
     * @param subjectName the subjectName to set
     */
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
}
