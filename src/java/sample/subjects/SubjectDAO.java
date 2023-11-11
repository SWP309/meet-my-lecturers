
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
}
