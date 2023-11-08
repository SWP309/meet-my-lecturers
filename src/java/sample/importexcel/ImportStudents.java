package sample.importexcel;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.catalina.User;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Minh Khang
 */
public class ImportStudents extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Part filePart = request.getPart("txtexcel");
            String fileName = filePart.getSubmittedFileName();
            String URL = "";

            if (fileName != null) {

                if (fileName.endsWith(".xls")) {
                    InputStream inp = filePart.getInputStream();
                    HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(inp));
                    HSSFSheet sheet = wb.getSheetAt(0);
                    try {
                        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                            Row row = sheet.getRow(i);

                            String userID = row.getCell(1).getStringCellValue();
                            String userName = row.getCell(2).getStringCellValue();
                            String userEmail = row.getCell(3).getStringCellValue();
                            int userStatus = (int) row.getCell(4).getNumericCellValue();
                            if (userStatus >= 0 && userStatus < 5) {
                                int roleid = (int) row.getCell(5).getNumericCellValue();
                                if (roleid >= 0 && roleid < 5) {
                                    String roleID = String.valueOf(roleid);
                                    int passWord = (int) (Math.random() * 1000000) % 1000 + 10000;
                                    String password = String.valueOf(passWord);
                                    UserDTO existed = UserDAO.getUserByID(userID);
                                    if (existed != null) {
                                        continue;
                                    }
                                    UserDTO users = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                                    UserDAO.ImportExcelUsers(users);
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Import Successfully");
                                    URL = "MainController?action=importPage";
                                } else {
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Error role ID at line: " + i);
                                    URL = "MainController?action=importPage";
                                    break;
                                }
                            } else {
                                wb.close();
                                request.setAttribute("EXCSERVLET", "Error status at line: " + i);
                                URL = "MainController?action=importPage";
                                break;
                            }
                        }
//                        wb.close();
//                        request.setAttribute("EXCSERVLET", "Import Successfully");
//                        URL = "MainController?action=importPage";
                    } catch (IllegalStateException e) {
                        wb.close();
                        request.setAttribute("EXCSERVLET", "Wrong format data ");
                        URL = "MainController?action=importPage";
                    }
                } else if (fileName.endsWith(".xlsx")) {

                    InputStream inp = filePart.getInputStream();
                    XSSFWorkbook wb = new XSSFWorkbook(inp);
                    XSSFSheet sheet = wb.getSheetAt(0);
                    try {
                        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                            Row row = sheet.getRow(i);

                            String userID = row.getCell(1).getStringCellValue();
                            String userName = row.getCell(2).getStringCellValue();
                            String userEmail = row.getCell(3).getStringCellValue();
                            int userStatus = (int) row.getCell(4).getNumericCellValue();
                            if (userStatus >= 0 && userStatus < 5) {
                                int roleid = (int) row.getCell(5).getNumericCellValue();
                                if (roleid >= 0 && roleid < 5) {
                                    String roleID = String.valueOf(roleid);
                                    int passWord = (int) (Math.random() * 1000000) % 1000 + 10000;
                                    String password = String.valueOf(passWord);
                                    UserDTO existed = UserDAO.getUserByID(userID);
                                    if (existed != null) {
                                        continue;
                                    }
                                    UserDTO users = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                                    UserDAO.ImportExcelUsers(users);
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Import Successfully");
                                    URL = "MainController?action=importPage";
                                } else {
                                    
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Error role ID at line: " + i);
                                    URL = "MainController?action=importPage";
                                    break;
                                }
                            } else {
                                wb.close();
                                request.setAttribute("EXCSERVLET", "Error status at line: " + i);
                                URL = "MainController?action=importPage";
                                break;
                            }
                        }
//                        wb.close();
//                        request.setAttribute("EXCSERVLET", "Import Successfully");
//                        URL = "MainController?action=importPage";
                    } catch (IllegalStateException e) {
                        wb.close();
                        request.setAttribute("EXCSERVLET", "Wrong format data");
                        URL = "MainController?action=importPage";
                    }
                } else {
                    request.setAttribute("EXCSERVLET", "Error: Incorrect file format");
                    URL = "MainController?action=importPage";
                }
            } else {
                request.setAttribute("EXCSERVLET", "Error: Null file");
                URL = "MainController?action=importPage";
            }
            request.getRequestDispatcher(URL).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
