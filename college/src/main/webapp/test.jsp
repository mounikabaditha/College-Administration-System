<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Save Subjects</title>
</head>
<body>
    <%
        String rollNo = request.getParameter("rollNo");
        String name = request.getParameter("name");
        String fatherName = request.getParameter("fatherName");
        String contact = request.getParameter("contact");
        
        int currentYear = Integer.parseInt(request.getParameter("currentYear"));

 String[] backlogs = new String[8];
        
        // Process and populate backlog data based on selected year
        for (int i = 1; i <= 4; i++) {
        if (currentYear >= i) {
            String backlog1 = request.getParameter(i + "-1");
            String backlog2 = request.getParameter(i + "-2");
            
            // Set value to null if not entered
            backlogs[i * 2 - 2] = (backlog1.isEmpty()) ? null : backlog1;
            backlogs[i * 2 - 1] = (backlog2.isEmpty()) ? null : backlog2;
        } else {
            backlogs[i * 2 - 2] = null;
            backlogs[i * 2 - 1] = null;
        }
    }


        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/student";
            String dbUser = "root";
            String dbPass = "systen@123";
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

            String insertQuery = "INSERT INTO student_backlogs (roll_no, name, father_name, contact, current_year, year1_sem1, year1_sem2, year2_sem1, year2_sem2, year3_sem1, year3_sem2, year4_sem1, year4_sem2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);

            pstmt.setString(1, rollNo);
            pstmt.setString(2, name);
            pstmt.setString(3, fatherName);
            pstmt.setString(4, contact);
            
            pstmt.setInt(5, currentYear);
            for (int i = 0; i < 8; i++) {
                pstmt.setString(6 + i, backlogs[i]);
            }

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
    <h1><center>Data has been saved successfully!</h1>
</body>
</html>