/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author CHIBAO
 */
public class DBUtils {

    private static final String USERNAME = "sa";
    private static final String PASSWORD = "12345";
    public static Connection getConnection()
            throws ClassNotFoundException, SQLException {
        Connection con = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=MeetMyLecturer3;characterEncoding=UTF-8;useUnicode=true";
        con = DriverManager.getConnection(url, USERNAME, PASSWORD);
        return con;
    }
}
