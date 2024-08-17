<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message {
            text-align: center;
            font-size: 24px; /* Larger font size */
            font-weight: bold; /* Bold font */
            margin-bottom: 160px; /* Add some top margin */
        }
    </style>
</head>
<body>
<div class="message">
    <%
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "system@123";
        
        String selectedSubject = request.getParameter("selectedSubject");
        String selectedType = request.getParameter("selectedType");
        String regulation = request.getParameter("regulation");
        String AcademicYear = request.getParameter("AcademicYear");
        String branch = request.getParameter("branch");
        int year = Integer.parseInt(request.getParameter("year"));
        int semester = Integer.parseInt(request.getParameter("semester"));
        String section = request.getParameter("section");
        String[] marks = request.getParameterValues("marks");
        String[] types = request.getParameterValues("type");
        String[] Ids = request.getParameterValues("Id"); // Assuming you're sending multiple Ids
        
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
            con.setAutoCommit(false); // Start a transaction
            
            // Iterate through the marks, types, and Ids arrays
            for (int i = 0; i < marks.length; i++) {
                int mark = Integer.parseInt(marks[i]);
                String type = types[i];
                String Id = Ids[i];
                
                String insertQuery = "INSERT INTO " + selectedSubject + " (Id, marks, type, AcademicYear, branch, year, semester, section,regulation) VALUES (?, ?, ?, ?, ?, ?,?, ?, ?)";
                PreparedStatement pstmt = con.prepareStatement(insertQuery);
                pstmt.setString(1, Id);
                pstmt.setInt(2, mark);
                pstmt.setString(3, type);
                pstmt.setString(4, AcademicYear);
                pstmt.setString(5, branch);
                pstmt.setInt(6, year);
                pstmt.setInt(7, semester);
                pstmt.setString(8, section);
                pstmt.setString(9, regulation);
                pstmt.executeUpdate();
                pstmt.close();
            }
            
            con.commit(); // Commit the transaction
            con.close();
            
            out.println("Data inserted successfully!");
        } catch (SQLException e) {
            out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</div>
</body>
</html>
