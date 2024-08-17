<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Marks and Type - Result</title>
    <!-- Your CSS styles -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('your-background-image-url.jpg'); /* Replace with your image URL */
            background-size: 100%;
        }

        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .result-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #009688;
        }

        p.success {
            color: #4caf50;
        }

        p.error {
            color: #f44336;
        }
    </style>
</head>
<body>
<div class="center">
    <div class="result-container">
        <%
        String selectedSubject = request.getParameter("selectedSubject");
        String studentId = request.getParameter("studentId");
        int newMarks = Integer.parseInt(request.getParameter("newMarks"));
        String newType = request.getParameter("newType");

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/student";
        String dbUser = "root";
        String dbPass = "system@123";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

            // Prepare SQL statement to update student marks and type
            String sql = "UPDATE " + selectedSubject + " SET marks = ? WHERE Id = ? AND  type= ? ";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, newMarks);
            pstmt.setString(2, studentId);
            pstmt.setString(3, newType);

            // Execute the update query
            int rowsUpdated = pstmt.executeUpdate();

            // Display a success message
            if (rowsUpdated > 0) {
        %>
            <h2>Marks and Type for Student ID <%= studentId %> updated successfully!</h2>
            <p class="success">Rows updated: <%= rowsUpdated %></p>
        <%
            } else {
        %>
            <h2>No rows updated. Student ID <%= studentId %> not found.</h2>
            <p class="error">Rows updated: <%= rowsUpdated %></p>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
            <h2>Error updating marks and type for Student ID <%= studentId %></h2>
            <p class="error">Error: <%= e.getMessage() %></p>
        <%
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        %>
    </div>
</div>
</body>
</html>
