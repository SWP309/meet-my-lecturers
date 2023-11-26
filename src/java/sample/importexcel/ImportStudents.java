package sample.importexcel;

import sample.mail.EmailDAO;
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
            String URL = "MainController?action=importPage";
            String subject = "Password";
            int existingUserCounter = 0;
            int MAX_EXISTING_USER_CHECKS; // Set a threshold based on your needs
            boolean flag = true;

            if (fileName != null) {

                if (fileName.endsWith(".xls")) {
                    InputStream inp = filePart.getInputStream();
                    HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(inp));
                    HSSFSheet sheet = wb.getSheetAt(0);
                    String sheetName = wb.getSheetName(0);
                    MAX_EXISTING_USER_CHECKS = sheet.getLastRowNum();
                    if (sheetName.equals("ImportUserMMLT")) {
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
                                            existingUserCounter += 1;
                                            if (existingUserCounter >= MAX_EXISTING_USER_CHECKS) {
                                                flag = false;
                                                request.setAttribute("EXCSERVLET", "Import fail, the data are existed in database");
                                                break;
                                            }
                                            continue;
                                        }
                                        existingUserCounter = 0;
                                        UserDTO users = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                                        UserDAO.ImportExcelUsers(users);
                                        String content = String.format("<!DOCTYPE html>%n"
                                                + "<html>%n"
                                                + "<head>%n"
                                                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">%n"
                                                + "</head>%n"
                                                + "<body style=\"background-color: #f2f2f2;\">%n"
                                                + "    <div style=\"background-color: #0078d4; color: white; padding: 10px;\">%n"
                                                + "        <h1>%s</h1>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"padding: 10px;\">%n"
                                                + "        <p>Hello,</p>%n"
                                                + "        <p>%s</p>%n"
                                                + "        <p>Cảm ơn bạn đã đọc email này.</p>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"background-color: #f2f2f2; padding: 10px;\">%n"
                                                + "        <p>Đây là phần chân trang của email.</p>%n"
                                                + "        <p>Liên hệ: example@example.com</p>%n"
                                                + "    </div>%n"
                                                + "</body>%n"
                                                + "</html>",
                                                userEmail, password);
                                        EmailDAO.sendMail(userEmail, subject, content);

                                    } else {
                                        wb.close();
                                        request.setAttribute("EXCSERVLET", "Error role ID at line: " + i);
                                        flag = false;
                                        break;
                                    }
                                } else {
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Error status at line: " + i);
                                    flag = false;
                                    break;
                                }
                            }
                            if (flag) {
                                wb.close();
                                request.setAttribute("EXCSERVLET", "Import Successfully");
                            }
                        } catch (IllegalStateException e) {
                            wb.close();
                            request.setAttribute("EXCSERVLET", "Wrong format data ");
                            URL = "MainController?action=importPage";
                        } catch (NullPointerException e) {
                            wb.close();
                            request.setAttribute("EXCSERVLET", "Wrong format data ");
                            URL = "MainController?action=importPage";
                        }
                    }
                } else if (fileName.endsWith(".xlsx")) {

                    InputStream inp = filePart.getInputStream();
                    XSSFWorkbook wb = new XSSFWorkbook(inp);
                    XSSFSheet sheet = wb.getSheetAt(0);
                    String sheetName = wb.getSheetName(0);
                    MAX_EXISTING_USER_CHECKS = sheet.getLastRowNum();
                    if (sheetName.equals("ImportUserMMLT")) {
                        try {
                            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                Row row = sheet.getRow(i);

                                String userID = row.getCell(1).getStringCellValue();
                                System.out.println(userID);
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
                                            existingUserCounter += 1;
                                            if (existingUserCounter >= MAX_EXISTING_USER_CHECKS) {
                                                flag = false;
                                                request.setAttribute("EXCSERVLET", "Import fail, the data are existed in database");
                                                break;
                                            }
                                            continue;
                                        }
                                        existingUserCounter = 0;
                                        UserDTO users = new UserDTO(userID, userName, userEmail, userStatus, roleID, password);
                                        UserDAO.ImportExcelUsers(users);
                                        String content = String.format("<!DOCTYPE html>%n"
                                                + "<html>%n"
                                                + "<head>%n"
                                                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">%n"
                                                + "</head>%n"
                                                + "<body style=\"background-color: #f2f2f2;\">%n"
                                                + "    <div style=\"background-color: #0078d4; color: white; padding: 10px;\">%n"
                                                + "        <h1>%s</h1>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"padding: 10px;\">%n"
                                                + "        <p>Hello,</p>%n"
                                                + "        <p>%s</p>%n"
                                                + "        <p>Cảm ơn bạn đã đọc email này.</p>%n"
                                                + "    </div>%n"
                                                + "    <div style=\"background-color: #f2f2f2; padding: 10px;\">%n"
                                                + "        <p>Đây là phần chân trang của email.</p>%n"
                                                + "        <p>Liên hệ: example@example.com</p>%n"
                                                + "    </div>%n"
                                                + "</body>%n"
                                                + "</html>",
                                                userEmail, password);
                                        EmailDAO.sendMail(userEmail, subject, content);

                                    } else {
                                        wb.close();
                                        request.setAttribute("EXCSERVLET", "Error role ID at line: " + i);
                                        flag = false;
                                        break;
                                    }
                                } else {
                                    wb.close();
                                    request.setAttribute("EXCSERVLET", "Error status at line: " + i);
                                    flag = false;
                                    break;
                                }
                            }
                            if (flag) {
                                wb.close();
                                request.setAttribute("EXCSERVLET", "Import Successfully");
                            }
//                        wb.close();
//                        request.setAttribute("EXCSERVLET", "Import Successfully");
//                        URL = "MainController?action=importPage";
                        } catch (IllegalStateException e) {
                            wb.close();
                            request.setAttribute("EXCSERVLET", "Wrong format data");
                            URL = "MainController?action=importPage";
                        } catch (NullPointerException e) {
                            wb.close();
                            request.setAttribute("EXCSERVLET", "Wrong format data");
                            URL = "MainController?action=importPage";
                        }
                    } else {
                        request.setAttribute("EXCSERVLET", "Error: Incorrect sheet name");
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
