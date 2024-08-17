<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- ... Rest of your imports ... -->

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Selected Subject Feedback</title>
  <!-- Your CSS styles -->
  <style>
    <!-- ... Your CSS styles ... -->
  </style>
</head>
<body>
  <!-- Your existing HTML structure ... -->

  <%
    // Retrieve form data from the previous page
    String selectedSubject = request.getParameter("selectedSubject");
    String regulation = request.getParameter("regulation");
    String AcademicYear = request.getParameter("AcademicYear");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    String section = request.getParameter("section");
    
    // Establish a connection to the database
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String dbUrl = "jdbc:mysql://localhost:3306/student";
    String dbUsername = "root";
    String dbPassword = "system@123";

    try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
      stmt = conn.createStatement();

      String sql = "SELECT * FROM selectedsubject ";

      rs = stmt.executeQuery(sql);
  %>

  <table border="1">
    <tr>
      <th>Subject</th>
      <th>Marks</th>
      <th>Type</th>
    </tr>
    <% while (rs.next()) { %>
      <tr>
        <td><%= selectedSubject %></td>
        <td><%= rs.getInt("marks") %></td>
        <td><%= rs.getString("type") %></td>
      </tr>
    <% } %>
  </table>

  <!-- ... Your existing HTML structure ... -->

  <%
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
      } catch (SQLException se) {
        se.printStackTrace();
      }
    }
  %>

</body>
</html>
