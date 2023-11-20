
package sample.subjects;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author CHIBAO
 */
public class SubjectDAO implements Serializable{
    
    private final String SEARCH_SUBJECTS = "SELECT s.subjectCode, s.subjectName\n" +
                        "FROM Subjects s";
    
    private final String LIST_ADD_MAJORS = "SELECT subjectCode \n" +
                                        "FROM Subjects s\n" +
                                        "WHERE s.subjectCode  not in (SELECT m.subjectCode\n" +
                                        "							FROM Majors m\n" +
                                        "							WHERE m.lecturerID = ?)";
    
    private List<SubjectDTO> subjects;

    public List<SubjectDTO> getSubjects() {
        return subjects;
    }

    public void getListSubjects() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(SEARCH_SUBJECTS);
            rs = stm.executeQuery();
            while (rs.next()) {
                String subCode = rs.getNString("subjectCode");
                String subName = rs.getNString("subjectName");
                SubjectDTO subjectDTO = new SubjectDTO(subCode, subName);
                if (this.subjects == null) {
                    this.subjects = new ArrayList<>();
                }
                this.subjects.add(subjectDTO);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public List<SubjectDTO> listAddMajor(String lecturerID) throws SQLException, ClassNotFoundException {
        List<SubjectDTO> list = null;
        Connection con = null;
        con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(LIST_ADD_MAJORS);
        stm.setString(1, lecturerID);
        ResultSet rs = stm.executeQuery();
        list = new ArrayList<>();
        
        if (rs != null) {
            while (rs.next()) {
                SubjectDTO subjectDTO = new SubjectDTO();
                subjectDTO.setSubjectCode(rs.getString("subjectCode"));
                list.add(subjectDTO);
            }
        }
        con.close();
        return list;
    }
}
