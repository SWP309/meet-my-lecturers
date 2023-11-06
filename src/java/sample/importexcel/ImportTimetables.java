package sample.importexcel;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import sample.timetables.TimetableDAO;
import sample.timetables.TimetableDTO;

/**
 *
 * @author Minh Khang
 */
public class ImportTimetables extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            TimetableDAO tb = new TimetableDAO();
            String URL = "";
            Part filePart = request.getPart("txtexcel");
            String fileName = filePart.getSubmittedFileName();
            String lecID = request.getParameter("lecID").toUpperCase();
            String semesID = request.getParameter("semesID").toUpperCase();
            boolean flag = true;
            if (fileName != null) {
                if (fileName.endsWith(".xls")) {

                    InputStream inp = filePart.getInputStream();
                    HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(inp));
                    HSSFSheet sheet = wb.getSheetAt(0);
                    try {
                        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                            Row row = sheet.getRow(i);

                            String subjectCode = row.getCell(1).getStringCellValue();
                            String slotID = row.getCell(2).getStringCellValue();
                            String lecturerID = row.getCell(3).getStringCellValue();
                            String semesterID = row.getCell(4).getStringCellValue();

                            if ((!lecID.equalsIgnoreCase(lecturerID) && !semesterID.equalsIgnoreCase(semesID))
                                    || (!lecID.equalsIgnoreCase(lecturerID)) || (!semesterID.equalsIgnoreCase(semesID))) {
                                flag = false;
                                request.setAttribute("TIMESERVLET", "Error data in Excel: Data must be correct with the given");
                                URL = "MainController?action=importPage";
                            }
                        }
                        if (flag) {
                            tb.removeTimetable(lecID, semesID);
                            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                Row row = sheet.getRow(i);

                                String subjectCode = row.getCell(1).getStringCellValue();
                                String slotID = row.getCell(2).getStringCellValue();
                                String lecturerID = row.getCell(3).getStringCellValue();
                                String semesterID = row.getCell(4).getStringCellValue();

                                TimetableDTO time = new TimetableDTO(subjectCode, slotID, lecturerID, semesterID);
                                TimetableDTO check = tb.getTimtables(subjectCode, slotID, lecturerID, semesterID);
                                if (check == null) {
                                    request.setAttribute("TIMESERVLET", "Import Successfully");
                                    TimetableDAO.ImportExcelTimetables(time);
                                } else {
                                    request.setAttribute("TIMESERVLET", "Duplicate data defected");
                                }
                            }
                            wb.close();
                            URL = "MainController?action=importPage";
                        }
                    } catch (IllegalStateException e) {
                        wb.close();
                        request.setAttribute("TIMESERVLET", "Error: Wrong format data");
                        URL = "MainController?action=importPage";
                    }
                } else if (fileName.endsWith(".xlsx")) {
                    InputStream inp = filePart.getInputStream();
                    XSSFWorkbook wb = new XSSFWorkbook(inp);
                    XSSFSheet sheet = wb.getSheetAt(0);
                    try {
                        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                            Row row = sheet.getRow(i);

                            String subjectCode = row.getCell(1).getStringCellValue();
                            String slotID = row.getCell(2).getStringCellValue();
                            String lecturerID = row.getCell(3).getStringCellValue();
                            String semesterID = row.getCell(4).getStringCellValue();

                            if ((!lecID.equalsIgnoreCase(lecturerID) && !semesterID.equalsIgnoreCase(semesID))
                                    || (!lecID.equalsIgnoreCase(lecturerID)) || (!semesterID.equalsIgnoreCase(semesID))) {
                                flag = false;
                                request.setAttribute("TIMESERVLET", "Error data in Excel: Data must be correct with the given");
                                URL = "MainController?action=importPage";
                            }
                        }
                        if (flag) {
                            tb.removeTimetable(lecID, semesID);
                            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                                Row row = sheet.getRow(i);

                                String subjectCode = row.getCell(1).getStringCellValue();
                                String slotID = row.getCell(2).getStringCellValue();
                                String lecturerID = row.getCell(3).getStringCellValue();
                                String semesterID = row.getCell(4).getStringCellValue();

                                TimetableDTO time = new TimetableDTO(subjectCode, slotID, lecturerID, semesterID);
                                TimetableDTO check = tb.getTimtables(subjectCode, slotID, lecturerID, semesterID);
                                if (check == null) {
                                    request.setAttribute("TIMESERVLET", "Import Successfully");
                                    TimetableDAO.ImportExcelTimetables(time);
                                } else {
                                    request.setAttribute("TIMESERVLET", "Duplicate data defected");
                                }
                            }
                        }
                        wb.close();

                        URL = "MainController?action=importPage";
                    } catch (IllegalStateException e) {
                        wb.close();
                        request.setAttribute("TIMESERVLET", "Error: Wrong format data");
                        URL = "MainController?action=importPage";
                    }

                } else {
                    request.setAttribute("TIMESERVLET", "Error: Incorrect file format");
                    URL = "MainController?action=importPage";

                }
            } else {
                request.setAttribute("TIMESERVLET", "Error: Null file");
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ImportTimetables.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ImportTimetables.class.getName()).log(Level.SEVERE, null, ex);
        }
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
