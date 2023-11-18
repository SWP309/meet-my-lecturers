/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.importexcel;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sample.subjects.SubjectDAO;
import sample.subjects.SubjectDTO;

/**
 *
 * @author Minh Khang
 */
public class ImportSubjects extends HttpServlet {

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
            SubjectDAO sj = new SubjectDAO();
            String URL = "MainController?action=importPage";
            Part filePart = request.getPart("txtexcel");
            String fileName = filePart.getSubmittedFileName();
            boolean flag = true;
            if (fileName != null) {
                if (fileName.endsWith(".xls")) {

                    InputStream inp = filePart.getInputStream();
                    HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(inp));
                    String sheetName = wb.getSheetName(0);
                    HSSFSheet sheet = wb.getSheetAt(0);
                    if (sheetName.equals("ImportSubjectsMMLT")) {
                        try {
                            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                Row row = sheet.getRow(i);

                                String subjectCode = row.getCell(1).getStringCellValue();
                                String Description = row.getCell(2).getStringCellValue();

                                if (subjectCode.equals("") || Description.equals("")) {
                                    flag = false;
                                    request.setAttribute("SUBJECTSERVLET", "Error data in Excel: Data is null");
                                    URL = "MainController?action=importPage";
                                }
                            }
                            if (flag) {
                                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                    Row row = sheet.getRow(i);

                                    String subjectCode = row.getCell(1).getStringCellValue();
                                    String Description = row.getCell(2).getStringCellValue();

                                    SubjectDTO subject = new SubjectDTO(subjectCode, Description);
                                    SubjectDTO check = sj.getSubject(subjectCode);
                                    if (check == null) {
                                        continue;
                                    }
                                    SubjectDAO.ImportExcelSubject(subject);
                                }
                                wb.close();
                                request.setAttribute("SUBJECTSERVLET", "Import successfully");
                                URL = "MainController?action=importPage";
                            }
                        } catch (IllegalStateException e) {
                            wb.close();
                            request.setAttribute("SUBJECTSERVLET", "Error: Wrong format data");
                            URL = "MainController?action=importPage";
                        }
                    } else {
                        request.setAttribute("SUBJECTSERVLET", "Error: Incorrect sheet name");
                        URL = "MainController?action=importPage";
                    }
                } else if (fileName.endsWith(".xlsx")) {
                    InputStream inp = filePart.getInputStream();
                    XSSFWorkbook wb = new XSSFWorkbook(inp);
                    XSSFSheet sheet = wb.getSheetAt(0);
                    String sheetName = wb.getSheetName(0);
                    if (sheetName.equals("ImportSubjectsMMLT")) {
                        try {
                            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                Row row = sheet.getRow(i);

                                String subjectCode = row.getCell(1).getStringCellValue();
                                String Description = row.getCell(2).getStringCellValue();

                                if (subjectCode.equals("") || Description.equals("")) {
                                    flag = false;
                                    request.setAttribute("SUBJECTSERVLET", "Error data in Excel: Data is null");
                                    URL = "MainController?action=importPage";
                                }
                            }
                            if (flag) {
                                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                    Row row = sheet.getRow(i);

                                    String subjectCode = row.getCell(1).getStringCellValue();
                                    String Description = row.getCell(2).getStringCellValue();
                                    System.out.println(subjectCode);
                                    SubjectDTO subject = new SubjectDTO(subjectCode, Description);
                                    SubjectDTO check = sj.getSubject(subjectCode);
                                    if (check != null) {
                                        continue;
                                    }
                                    SubjectDAO.ImportExcelSubject(subject);
                                }
                                wb.close();
                                request.setAttribute("SUBJECTSERVLET", "Import successfully");
                                URL = "MainController?action=importPage";
                            }
                        } catch (IllegalStateException e) {
                            wb.close();
                            request.setAttribute("SUBJECTSERVLET", "Error: Wrong format data");
                            URL = "MainController?action=importPage";
                        }
                    } else {
                        request.setAttribute("SUBJECTSERVLET", "Error: Incorrect sheet name");
                        URL = "MainController?action=importPage";
                    }
                } else {
                    request.setAttribute("SUBJECTSERVLET", "Error: Incorrect file format");
                    URL = "MainController?action=importPage";
                }
            } else {
                request.setAttribute("SUBJECTSERVLET", "Error: Null file");
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
