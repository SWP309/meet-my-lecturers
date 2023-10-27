/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.freeslots.FreeSlotsDAO;
import sample.freeslots.FreeSlotsDTO;
import sample.semester.SemesterDAO;
import sample.semester.SemesterDTO;

/**
 * c
 *
 * @author ASUS
 */
public class SearchFreeSlot {

    public SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-yyyy");

    protected void search(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException, ParseException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession();
        String select = request.getParameter("select");
        System.out.println("Select:" + select);
        switch (select) {
            case "subjectCode": {
                try {

                    String semester = (String) request.getParameter("semester");
                    String subjectCode = (String) request.getParameter("ID");
                    FreeSlotsDAO rf = new FreeSlotsDAO();
                    SemesterDAO sr = new SemesterDAO();
                    List<FreeSlotsDTO> listSearch = rf.searchBySubjectCode(subjectCode);
                    List<FreeSlotsDTO> listSearchBySC = new ArrayList<>();
                    List<SemesterDTO> listSemester = sr.select();
                    Date start = null, end = null;

                    for (SemesterDTO s : listSemester) {

                        if (semester.equals(s.getSemesterID())) {
                            for (FreeSlotsDTO rs : listSearch) {
                                start = sdf.parse(rs.getStartTime());
                                end = sdf.parse(rs.getEndTime());
                                if (start.compareTo(s.getStartDay()) >= 0 && end.compareTo(s.getEndDay()) <= 0) {
                                    listSearchBySC.add(rs);
                                    session.setAttribute("listSearch", listSearchBySC);
                                    System.out.println(rs.getStartTime());
                                } else {
                                    System.out.println("no");
                                }
                            }
                        } else {
                            System.out.println("NO RESULTS");
                        }
                    }
                    if (listSearchBySC.isEmpty()) {
                        System.out.println("Empty");
                        request.setAttribute("msg", "NO RESULTS");
                        request.getRequestDispatcher("").forward(request, response);
                    } else {
                        System.out.println("listSearch" + listSearchBySC);

                    }

                } catch (Exception ex) {
                    ex.printStackTrace();
                    request.setAttribute("message", ex.getMessage());

                }
                break;
            }

            case "student": {
                try {
                    String studentID = (String) request.getParameter("ID");
                    String semester = (String) request.getParameter("semester");
                    FreeSlotsDAO rf = new FreeSlotsDAO();
                    SemesterDAO sr = new SemesterDAO();
                    List<FreeSlotsDTO> listSearch = rf.searchByStudentID(studentID);
                    List<FreeSlotsDTO> listSearchByS = new ArrayList<>();
                    List<SemesterDTO> listSemester = sr.select();
                    Date start = null, end = null;
                    for (SemesterDTO s : listSemester) {
                        if (semester.equals(s.getSemesterID())) {
                            for (FreeSlotsDTO rs : listSearch) {
                                start = sdf.parse(rs.getStartTime());
                                end = sdf.parse(rs.getEndTime());
                                if (start.compareTo(s.getStartDay()) >= 0 && end.compareTo(s.getEndDay()) <= 0) {
                                    listSearchByS.add(rs);
                                    session.setAttribute("listSearch", listSearchByS);

                                } else {
                                    System.out.println("OTP");
                                }
                            }
                        } else {
                            System.out.println("PLE");
                        }
                    }
                    if (listSearchByS.isEmpty()) {
                        System.out.println("Empty");
                        request.setAttribute("msg", "NO RESULTS");
                        request.getRequestDispatcher("/requests/list.do").forward(request, response);
                    } else {
                        System.out.println("listSearch" + listSearchByS);
                        response.sendRedirect(request.getContextPath() + "/requests/list.do");
                    }

                } catch (SQLException ex) {
                    ex.printStackTrace();
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            }

            case "lecturer": {
                try {
                    String lecturerID = (String) request.getParameter("ID");
                    String semester = (String) request.getParameter("semester");
                    SemesterDAO sr = new SemesterDAO();
                    FreeSlotsDAO rf = new FreeSlotsDAO();
                    List<FreeSlotsDTO> listSearch = rf.searchByLecturerID(lecturerID);
                    List<FreeSlotsDTO> listSearchByL = new ArrayList<>();
                    List<SemesterDTO> listSemester = sr.select();
                    Date start = null, end = null;

                    for (SemesterDTO s : listSemester) {
                        if (semester.equals(s.getSemesterID())) {
                            for (FreeSlotsDTO rs : listSearch) {
                                start = sdf.parse(rs.getStartTime());
                                end = sdf.parse(rs.getEndTime());
                                if (start.compareTo(s.getStartDay()) >= 0 && end.compareTo(s.getEndDay()) <= 0) {
                                    listSearchByL.add(rs);
                                    session.setAttribute("listSearch", listSearchByL);

                                } else {
                                }
                            }
                        } else {
                        }
                    }
                    if (listSearchByL.isEmpty()) {
                        System.out.println("Empty");
                        request.setAttribute("msg", "NO RESULTS");
                        request.getRequestDispatcher("").forward(request, response);
                    } else {
                        System.out.println("listSearch" + listSearchByL);

                    }

                } catch (SQLException ex) {
                    //Hien trang thong bao loi
                    ex.printStackTrace();//In thông báo chi tiết cho developer
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            }
            default: {
            }
            break;
        }
        request.setAttribute("select", select);

    }

}
