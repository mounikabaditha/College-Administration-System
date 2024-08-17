<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Student Details</title>
    <style>
        /* Add your CSS styling here */
    </style>
</head>
<body>
    <!-- Your header and navigation here -->

    <div class="center">
        <h1>Update Student Details</h1>

        <%
            String studentId = request.getParameter("id");
            String password = request.getParameter("password");
            String regulation = request.getParameter("regulation");
            String academicYear = request.getParameter("academicYear");
            String branch = request.getParameter("branch");
            String year = request.getParameter("year");
            String semester = request.getParameter("semester");
            String section = request.getParameter("section");

            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/student";
            String dbUsername = "root";
            String dbPassword = "system@123";

            try {
                Class.forName(driver);
                Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);

                String query = "UPDATE student_registration SET Password=?, Regulation=?, AcademicYear=?, branch=?, Year=?, Semester=?, Section=? WHERE Id=?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, password);
                pstmt.setString(2, regulation);
                pstmt.setString(3, academicYear);
                pstmt.setString(4, branch);
                pstmt.setString(5, year);
                pstmt.setString(6, semester);
                pstmt.setString(7, section);
                pstmt.setString(8, studentId);

                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<h2>Student Details Updated Successfully</h2>");
                } else {
                    out.println("<h2>Update Failed</h2>");
                }

                pstmt.close();
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>
    </div>

    <!-- Your footer here -->
</body>
</html>
