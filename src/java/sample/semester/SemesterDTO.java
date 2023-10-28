/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.semester;

import java.util.Date;

/**
 *
 * @author Dell
 */
public class SemesterDTO {
    private String semesterID;
    private String semesterName;
    private Date startDay;
    private Date endDay;

    public SemesterDTO() {
    }

    public SemesterDTO(String semesterID, String semesterName, Date startDay, Date endDay) {
        this.semesterID = semesterID;
        this.semesterName = semesterName;
        this.startDay = startDay;
        this.endDay = endDay;
    }

    public String getSemesterID() {
        return semesterID;
    }

    public void setSemesterID(String semesterID) {
        this.semesterID = semesterID;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public Date getStartDay() {
        return startDay;
    }

    public void setStartDay(Date startDay) {
        this.startDay = startDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }

    @Override
    public String toString() {
        return "Semesters{" + "semesterID=" + semesterID + ", semesterName=" + semesterName + ", startDay=" + startDay + ", endDay=" + endDay + '}';
    }
    
    
}
