<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://t3.ftcdn.net/jpg/04/40/28/66/360_F_440286633_bvNYX5I6HRa7swCorzWCId6YYGJhMMgo.jpg');
            background-size: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
    </style>
</head>
<%
    String id = request.getParameter("Id");
    String password = request.getParameter("password");
    String regulation = request.getParameter("regulation");
    String academicYear = request.getParameter("academic_year");
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

        String query = "INSERT INTO student_registration (Id, Password, Regulation, AcademicYear, Year, Semester, Section,branch) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, regulation);
        pstmt.setString(4, academicYear);
        pstmt.setString(5, year);
        pstmt.setString(6, semester);
        pstmt.setString(7, section);
        pstmt.setString(8, branch);

        int rowsInserted = pstmt.executeUpdate();

        if (rowsInserted > 0) {
        	request.setAttribute("success", true);
        } else {
        	request.setAttribute("success", false);
        }

        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Alredy registered");
    }
%>
<body>
    <% if (request.getAttribute("success") != null && (Boolean) request.getAttribute("success")) { %>
        <h2>Registration Successful</h2>
    <% } else { %>
        <h2>Registration Failed</h2>
    <% } %>
    <a href="std.html">Go Back to Login Form</a>
</body>
