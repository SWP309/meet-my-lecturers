
package sample.subjects;

import java.io.Serializable;

public class SubjectDTO implements Serializable{
    private String subjectCode;
    private String subjectName;

    public SubjectDTO() {
        this.subjectCode = "";
        this.subjectName = "";
    }

    public SubjectDTO(String subjectCode, String subjectName) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
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
