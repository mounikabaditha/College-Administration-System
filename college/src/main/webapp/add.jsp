<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Data Insertion</title>
    <style>
         body {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }
    
    .message {
      text-align: center;
      margin-bottom: 20px;
    }
    
    .button-container {
      display: flex;
      gap: 20px;
      
    }
    .button-container button {
      padding: 10px 20px;
      font-size: 16px;
    }
    }
    </style>
</head>
<body>
    <%
        // Retrieve parameters sent from the previous page
        String rollNo = request.getParameter("rollNo");
        String name = request.getParameter("name");
        String fatherName = request.getParameter("fatherName");
        String contact = request.getParameter("contact");
        String currentYear = request.getParameter("currentYear");
        String year = request.getParameter("year");
        String semester = request.getParameter("semester");
        String regulation = request.getParameter("regulation");
        String branch = request.getParameter("branch");

        // Retrieve the selected subjects as a JSON string
        String selectedSubjectsJson = request.getParameter("selectedSubjects");

        // Convert the JSON string to a Java array
        String[] selectedSubjects = new String[]{};
        if (selectedSubjectsJson != null && !selectedSubjectsJson.isEmpty()) {
            selectedSubjects = selectedSubjectsJson.replace("[", "").replace("]", "").split(",");
        }

        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "system@123";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Define the SQL query to insert data into the database
            String insertQuery = "INSERT INTO student_data1 (rollNo, name, fatherName, contact, currentYear, year, semester, regulation, branch, selectedSubjects) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // Create a PreparedStatement to prevent SQL injection
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, rollNo);
            pstmt.setString(2, name);
            pstmt.setString(3, fatherName);
            pstmt.setString(4, contact);
            pstmt.setString(5, currentYear);
            pstmt.setString(6, year);
            pstmt.setString(7, semester);
            pstmt.setString(8, regulation);
            pstmt.setString(9, branch);
            
            // Convert the selected subjects array back to a comma-separated string
            String selectedSubjectsString = String.join(",", selectedSubjects);
            pstmt.setString(10, selectedSubjectsString);

            // Execute the insert query
            pstmt.executeUpdate();
    %>
    <h1><center>Data Inserted Successfully</h1>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
    
    <div class="button-container">
        <form action="second-page.html">
            <input type="hidden" name="rollNo" value="<%= rollNo %>">
            <input type="hidden" name="name" value="<%= name %>">
            <input type="hidden" name="fatherName" value="<%= fatherName %>">
            <input type="hidden" name="contact" value="<%= contact %>">
            <input type="hidden" name="currentYear" value="<%= currentYear %>">
            <input type="hidden" name="year" value="<%= year %>">
            <input type="hidden" name="semester" value="<%= semester %>">
            <input type="hidden" name="regulation" value="<%= regulation %>">
            <input type="hidden" name="branch" value="<%= branch %>">
            <button type="submit">Go Back</button>
        </form>
         <form action="backlog.html">
           <button type="submit">logout</button>
           </form>
    </div>
</body>
</html>
