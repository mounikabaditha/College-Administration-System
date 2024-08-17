<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Map" %> <!-- Import java.util.Map -->

<%
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/student";
String dbUsername = "root";
String dbPassword = "system@123";

// Get form data
String date = request.getParameter("date");
String selectedSubject = request.getParameter("selectedSubject");
String period = request.getParameter("period");
String month = request.getParameter("month");
String regulation = request.getParameter("regulation");
String AcademicYear = request.getParameter("AcademicYear");
String branch = request.getParameter("branch");
int year = Integer.parseInt(request.getParameter("year"));
int semester = Integer.parseInt(request.getParameter("semester"));
String section = request.getParameter("section");
String[] studentIds = request.getParameterValues("studentIds[]");
Map<String, String[]> attendanceMap = request.getParameterMap();

try {
    Class.forName(driver);
    Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);

    for (String studentId : studentIds) {
        String attendanceValue = request.getParameter("attendance[" + studentId + "]");

        // Check if attendanceValue is empty and set a default value
        if (attendanceValue == null || attendanceValue.isEmpty()) {
            attendanceValue = "0"; // Set a default value of 0 (Absent) when it's empty
        }

        // Insert attendance data into the database
        String insertQuery = "INSERT INTO attendance_data (subject, regulation, AcademicYear, branch, year, semester, section, studentId, attendance,period,month,date) VALUES (?,?,?, ?, ?,?, ?, ?, ?, ?, ?,?)";
        PreparedStatement insertStmt = con.prepareStatement(insertQuery);
        insertStmt.setString(1, selectedSubject);
        insertStmt.setString(2, regulation);
        insertStmt.setString(3, AcademicYear);
        insertStmt.setString(4, branch);
        insertStmt.setInt(5, year);
        insertStmt.setInt(6, semester);
        insertStmt.setString(7, section);
        insertStmt.setString(8, studentId);
        insertStmt.setInt(9, Integer.parseInt(attendanceValue));
        insertStmt.setString(10, period);
        insertStmt.setString(11, month);
        insertStmt.setString(12, date);// Parse attendanceValue as an integer

        int rowsAffected = insertStmt.executeUpdate();

        if (rowsAffected > 0) {
            //out.println("SUBMITTED SUCCESSFULLY!");
        } else {
            out.println("Failed to add attendance for student ID: " + studentId);
        }

        insertStmt.close();
    }
    out.println("SUBMITTED SUCCESSFULLY!");

    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
