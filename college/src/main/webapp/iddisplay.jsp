<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student IDs</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0;
    }
    .feedback-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px;
    }
    .student-list {
      text-align: center;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      margin-top: 20px;
    }
    .student-id {
      margin: 5px;
      padding: 10px;
      background-color: #f2f2f2;
      border-radius: 3px;
    }
    .button {
      margin-top: 20px;
    }
    @media print {
      .button {
        display: none;
      }
    }
  </style>
</head>
<body>
<div class="feedback-header">
  <div style="flex: 1; text-align: center;">
    <center>
      <h2>Eluru College Of Engineering and Technology</h2>
      <h4>(Approved By AICTE-New Delhi and Affiliated to JNTU-Kakinada)</h4>
      <h5>On NH5-Bypass Duggirala, (v), Eluru-534004, A.P, India</h5>
    </center>
  </div>
  <div>
    <img src="https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj" alt="Logo" style="width: 100px; height: 100px;">
  </div>
</div>

<%
  // ... (rest of your Java code)
String Regulation = request.getParameter("regulation");
  String AcademicYear = request.getParameter("AcademicYear");
  String branch = request.getParameter("branch");
  String Year = request.getParameter("year");
  String Semester = request.getParameter("semester");
  String Section = request.getParameter("section");

  // Database connection parameters
  String jdbcUrl = "jdbc:mysql://localhost:3306/student";
  String dbUser = "root";
  String dbPass = "system@123";

  // Initialize variables for database connection and statement
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;

  try {
    // Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

    // Prepare SQL statement to retrieve student IDs based on criteria
    String sql = "SELECT Id FROM student_registration " +
                 "WHERE Regulation = ? AND Academicyear = ? AND branch = ? " +
                 "AND Year = ? AND Semester = ? AND Section = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, Regulation);
    stmt.setString(2, AcademicYear);
    stmt.setString(3, branch);
    stmt.setString(4, Year);
    stmt.setString(5, Semester);
    stmt.setString(6, Section);

    // Execute query
    rs = stmt.executeQuery();
%>

<div class="student-list">
  <h2>Student IDs</h2>
  <% while (rs.next()) { %>
    <div class="student-id"><%= rs.getString("Id") %></div>
  <% } %>
</div>
<button class="button" onclick="printFeedbackReport()">Print Report</button>

<script>
  // JavaScript function to trigger printing
  function printFeedbackReport() {
    // Trigger printing
    window.print();
  }
</script>

<%
  // ... (rest of your Java code)
 } catch (Exception e) {
    e.printStackTrace();
  } finally {
    // Close resources
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
  }
%>

</body>
</html>
