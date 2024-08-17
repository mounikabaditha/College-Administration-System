<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Display Filtered Table Contents</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    .feedback-header {
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 20px;
      
    }

    .feedback-header h2 {
      margin: 0;
      font-size: 24px;
    }

    .feedback-header h4,
    .feedback-header h5 {
      margin: 5px 0;
      font-size: 14px;
    }

   .feedback-header img {
  width: 100px;
  height: 100px;
  margin-left: auto;
  margin-top: -80px;
  margin-right: 650px;
}
    table {
      border-collapse: collapse;
      width: 80%;
      margin: 20px auto;
    }

    th, td {
      border: 1px solid #dddddd;
      text-align: center;
      padding: 8px;
    }

    th {
      background-color: #f2f2f2;
    }

    tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    .print-button {
      text-align: center;
      margin-top: 20px;
    }

    .print-button button {
      padding: 10px 20px;
      font-size: 16px;
      background-color: #007bff;
      color: white;
      border: none;
      cursor: pointer;
      border-radius: 4px;
    }

    .print-button button:hover {
      background-color: #0056b3;
    } 
     
     @media print {
      button {
        display: none;
      }
    }
     </style>
  
  </head>
<body>
<!-- Scrolling text at the top of the page -->
   <div class="feedback-header">
  <div style="flex: 1; text-align: center;">
  <center>
      
        <h2>Eluru College Of Engineering and Technology</h2>
        <h4>(Approved By AICTE-New Delhi and Affliated to JNTU-Kakinada)</h4>
        <h5>On NH5-Bypass Duggirala, (v),Eluru-534004,A.P,India</h5>
     
    </center>
    </div>
    
    <div>
      <img src="https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj" alt="Logo" >
    </div>

<div style="text-align: center;">
  
  <table border="1">
    <tr>
      <th>ID</th>
      <th>Marks</th>
      <th>Type</th>
    </tr>
    <%
      // Retrieve filter criteria from the previous form's data
      String selectedSubject = request.getParameter("selectedSubject");
      String regulation = request.getParameter("regulation");
      String academicYear = request.getParameter("AcademicYear");
      int year = Integer.parseInt(request.getParameter("year")); // Convert to int
      int semester = Integer.parseInt(request.getParameter("semester")); // Convert to int
      String branch = request.getParameter("branch");
      String section = request.getParameter("section");
      String type = request.getParameter("type");
      
      // Establish a connection to the database
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String dbUrl = "jdbc:mysql://localhost:3306/student";
      String dbUsername = "root";
      String dbPassword = "system@123";

      try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        // Create a parameterized SQL query with filter criteria
        String sql = "SELECT id, marks, type FROM snsw " +
                     "WHERE Regulation = ? AND academicyear = ? AND year = ? AND semester = ? AND branch = ? AND section = ? AND type = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, regulation);
        pstmt.setString(2, academicYear);
        pstmt.setInt(3, year);
        pstmt.setInt(4, semester);
        pstmt.setString(5, branch);
        pstmt.setString(6, section);
        pstmt.setString(7, type);
       
        rs = pstmt.executeQuery();

        // Loop through the result set and display filtered table contents
        while (rs.next()) {
    %>
    <%
  String branchFullName = "";
  if (branch.equals("cse")) {
      branchFullName = "Computer Science and Engineering";
  } else if (branch.equals("ece")) {
      branchFullName = "Electronics and Communication Engineering";
  } else if (branch.equals("eee")) {
      branchFullName = "Electrical and Electronics Engineering";
  } else if (branch.equals("mech")) {
      branchFullName = "Mechanical Engineering";
  } else if (branch.equals("cse_aids")) {
      branchFullName = "Artificial Intelligence and Data Science";
  } else if (branch.equals("mba")) {
      branchFullName = "MBA";
  } else if (branch.equals("mtech")) {
      branchFullName = "M.Tech";
  }
%>
          <tr>
            <td><%= rs.getString("id") %></td>
            <td><%= rs.getInt("marks") %></td>
            <td><%= rs.getString("type") %></td>
          </tr>
    <%
        }
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        try {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        } catch (SQLException se) {
          se.printStackTrace();
        }
      }
    %>
  </table>
  </div>
  <div class="print-button">
      <button onclick="printFeedbackReport()">Print Report</button>
      </div>

<script>
  // JavaScript function to trigger printing
  function printFeedbackReport() {
      // Trigger printing
      window.print();
    }
</script>
  
</body>
</html>
