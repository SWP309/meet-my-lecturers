/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author CHIBAO
 */
public class DBUtils {

    private static final String USERNAME = "sa";
    private static final String PASSWORD = "1234";    
    public static Connection getConnection() 
            throws ClassNotFoundException, SQLException{
        Connection con = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=MeetMyLecturer2";
        con = DriverManager.getConnection(url, USERNAME, PASSWORD);
        return con;
    }
    
//    public static void main(String[] args) throws ClassNotFoundException, SQLException {
//        DBUtils.getConnection();
//        System.out.println(DBUtils.getConnection());
//    }
}
