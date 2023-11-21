
package sample.subjects;

import java.io.Serializable;

public class SubjectDTO implements Serializable{
    private String subjectCode;
    private String subjectName;
    private int status;

    public SubjectDTO() {
    }

    public SubjectDTO(String subjectCode, String subjectName) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
    }

    public SubjectDTO(String subjectCode, String subjectName, int status) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.status = status;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
}
