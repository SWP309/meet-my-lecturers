/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.semester;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;

/**
 *
 * @author Minh Khang
 */
public class SemesterDTO {
    private String semesterID;
    private String semesterName;
    private String startDay;
    private String endDay;

    public SemesterDTO() {
    }

    public SemesterDTO(String semesterID) {
        this.semesterID = semesterID;
    }

    public SemesterDTO(String semesterID, String semesterName, String startDay, String endDay) {
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

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay;
    }

    public String getEndDay() {
        return endDay;
    }

    public void setEndDay(String endDay) {
        this.endDay = endDay;
    }
    
    
}
