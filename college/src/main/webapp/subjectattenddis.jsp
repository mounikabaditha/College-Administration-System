<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Details</title>
</head>
<body>
    <h1>Attendance Details</h1>
    
    <%
        // Retrieve parameters from the form
        String selectedSubject = request.getParameter("selectedSubject");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "Bmounika@063";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            
            // Parse start and end dates as Date objects
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);
            
            // Query to retrieve attendance data
           // Query to retrieve attendance data
String sql = "SELECT studentId, " +
             "SUM(CASE WHEN attendance = 1 THEN 1 ELSE 0 END) AS present_days " +
             "FROM attendance_data " +
             "WHERE subject = ? AND date BETWEEN ? AND ? " +
             "GROUP BY studentId";


            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, selectedSubject);
            pstmt.setDate(2, new java.sql.Date(startDate.getTime()));
            pstmt.setDate(3, new java.sql.Date(endDate.getTime()));
            
            rs = pstmt.executeQuery();
            
            // Calculate total days
            long totalDays = ((endDate.getTime() - startDate.getTime()) / (24 * 60 * 60 * 1000)) + 1;
            
            // Display attendance details in a table
    %>
    <table border="1">
        <tr>
            <th>Roll Number</th>
            <th>Total Present Days</th>
            <th>Total Absent Days</th>
            <th>Percentage</th>
        </tr>
        <%
            while (rs.next()) {
                int rollNumber = rs.getInt("roll_number");
                int presentDays = rs.getInt("present_days");
                
                int absentDays = (int)(totalDays - presentDays);
                double percentage = (presentDays * 100.0) / totalDays;
        %>
        <tr>
            <td><%= rollNumber %></td>
            <td><%= presentDays %></td>
            <td><%= absentDays %></td>
            <td><%= percentage %> %</td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</body>
</html>
