<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: left;
    }
    .feedback-container {
      text-align: center;
    }
    
    .feedback-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px;
      
    }
    
   
    .feedback-details {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    
     @media print {
      button {
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
        <h4>(Approved By AICTE-New Delhi and Affliated to JNTU-Kakinada)</h4>
        <h5>On NH5-Bypass Duggirala, (v),Eluru-534004,A.P,India</h5>
     
    </center>
    </div>
    
    <div>
      <img src="https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj" alt="Logo" style="width: 100px; height: 100px;">
    </div>
  </div>
  </div>


  <%
    // Retrieve data from the form
    String regulation = request.getParameter("regulation");
    String AcademicYear = request.getParameter("AcademicYear");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    String section = request.getParameter("section");
    int feedbackNo = Integer.parseInt(request.getParameter("feedbackNo"));
    String selectedSubject = request.getParameter("selectedSubject");
    String facultyName = request.getParameter("facultyName");
    int num_std = Integer.parseInt(request.getParameter("num_std"));
   
   

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/student";
    String dbUsername = "root";
    String dbPassword = "system@123";

    Connection conn = null;
    PreparedStatement preparedStatement = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        // Retrieve sum of each individual rating value based on criteria
        String selectQuery = "SELECT COUNT(*) AS countRating1,SUM(rating1) AS sumRating1, SUM(rating2) AS sumRating2, SUM(rating3) AS sumRating3, SUM(rating4) AS sumRating4, SUM(rating5) AS sumRating5, SUM(rating6) AS sumRating6, SUM(rating7) AS sumRating7, SUM(rating8) AS sumRating8, SUM(rating9) AS sumRating9, SUM(rating10) AS sumRating10 FROM feedback_data1 WHERE regulation = ? AND AcademicYear = ? AND branch = ? AND year = ? AND semester = ? AND section = ? AND feedbackNo = ? AND selectedSubject = ?";
        preparedStatement = conn.prepareStatement(selectQuery);
        
        preparedStatement.setString(1, regulation);
        preparedStatement.setString(2, AcademicYear);
        preparedStatement.setString(3, branch);
        preparedStatement.setInt(4, year);
        preparedStatement.setInt(5, semester);
        preparedStatement.setString(6, section);
        preparedStatement.setInt(7, feedbackNo);
        preparedStatement.setString(8, selectedSubject);
        rs = preparedStatement.executeQuery();

        // Display the sum of each individual rating in a table
        if (rs.next()) {
            int countRating1 = rs.getInt("countRating1");
            int sumRating1 = rs.getInt("sumRating1");
            int sumRating2 = rs.getInt("sumRating2");
            int sumRating3 = rs.getInt("sumRating3");
            int sumRating4 = rs.getInt("sumRating4");
            int sumRating5 = rs.getInt("sumRating5");
            int sumRating6 = rs.getInt("sumRating6");
            int sumRating7 = rs.getInt("sumRating7");
            int sumRating8 = rs.getInt("sumRating8");
            int sumRating9 = rs.getInt("sumRating9");
            int sumRating10 = rs.getInt("sumRating10");
            
            double avgRating1 = (double) sumRating1 / countRating1;
            double avgRating2 = (double) sumRating2 / countRating1;
            double avgRating3 = (double) sumRating3 / countRating1;
            double avgRating4 = (double) sumRating4 / countRating1;
            double avgRating5 = (double) sumRating5 / countRating1;
            double avgRating6 = (double) sumRating6 / countRating1;
            double avgRating7 = (double) sumRating7 / countRating1;
            double avgRating8 = (double) sumRating8 / countRating1;
            double avgRating9 = (double) sumRating9 / countRating1;
            double avgRating10 = (double) sumRating10 / countRating1;
            
            double percentageOfStudents = ((double) countRating1 / num_std) * 100;

            double percentRating1 = (sumRating1 * 100.0) / (countRating1 * 5);
            double percentRating2 = (sumRating2 * 100.0) / (countRating1 * 5);
            double percentRating3 = (sumRating3 * 100.0) / (countRating1 * 5);
            double percentRating4 = (sumRating4 * 100.0) / (countRating1 * 5);
            double percentRating5 = (sumRating5 * 100.0) / (countRating1 * 5);
            double percentRating6 = (sumRating6 * 100.0) / (countRating1 * 5);
            double percentRating7 = (sumRating7 * 100.0) / (countRating1 * 5);
            double percentRating8 = (sumRating8 * 100.0) / (countRating1 * 5);
            double percentRating9 = (sumRating9 * 100.0) / (countRating1 * 5);
            double percentRating10 = (sumRating10 * 100.0) / (countRating1 * 5);
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
  

  <div class="feedback-details">
    <div>
      <h4>Feedback Report for Subject: <%= selectedSubject %></h4>
      <h4>Faculty Name: <%= facultyName %></h4>
      <h4>Department: <%= branchFullName %></h4>
    </div>
    <div>
      <h4>Total number of students: <%= num_std %></h4>
      <h4>Percentage of Students: <%= String.format("%.2f%%", percentageOfStudents) %></h4>
    </div>
  </div>
  <table>
  
    <tr>
      <th>Rating Criteria</th>
      <th>Aggregates</th>
      <th>Percentage</th>
    </tr>
    <!-- Continue with the rest of the table rows -->
    <!-- ... -->
    <tr>
      <td>Lectures were well prepared and organized</td>
      <td><%= String.format("%.2f", avgRating1)%></td>
      <td><%= String.format("%.2f%%", percentRating1) %></td>
    </tr>
    <tr>
      <td>Blackboard writing/visual aids are clear and organized</td>
      <td><%= String.format("%.2f", avgRating2)%></td>
      <td><%= String.format("%.2f%%", percentRating2) %></td>
    </tr>
     <tr>
      <td>Lectures delivered with an emphasis on fundamental concepts/examples</td>
      <td><%= String.format("%.2f", avgRating3)%></td>
      <td><%= String.format("%.2f%%", percentRating3) %></td>
    </tr>
     <tr>
      <td>Teachers engage classes regularly and maintain discipline</td>
      <td><%= String.format("%.2f", avgRating4)%></td>
      <td><%= String.format("%.2f%%", percentRating4) %></td>
    </tr>
     <tr>
      <td>Difficult topics were taught with adequate attention and ease</td>
      <td><%= String.format("%.2f", avgRating5)%></td>
      <td><%= String.format("%.2f%%", percentRating5) %></td>
    </tr>
     <tr>
      <td>Faculty able to deliver lectures with good communication skills</td>
      <td><%= String.format("%.2f", avgRating6)%></td>
      <td><%= String.format("%.2f%%", percentRating6) %></td>
    </tr>
     <tr>
      <td>Students were encouraged to ask questions, making lectures interactive and lively</td>
      <td><%= String.format("%.2f", avgRating7)%></td>
      <td><%= String.format("%.2f%%", percentRating7) %></td>
    </tr>
     <tr>
      <td>The teacher is effective in preparing students for exams</td>
      <td><%= String.format("%.2f", avgRating8)%></td>
      <td><%= String.format("%.2f%%", percentRating8) %></td>
    </tr>
     <tr>
      <td>Evaluation is fair and impartial, helping students improve</td>
      <td><%= String.format("%.2f", avgRating9)%></td>
      <td><%= String.format("%.2f%%", percentRating9) %></td>
    </tr>
     <tr>
      <td>Faculty is accessible to students for guidance and solving queries</td>
      <td><%= String.format("%.2f", avgRating1)%></td>
      <td><%= String.format("%.2f%%", percentRating10) %></td>
    </tr>

  </table>
  <p>No. of students: <%= countRating1 %></p>
  <button onclick="printFeedbackReport()">Print Report</button>

<script>
  // JavaScript function to trigger printing
  function printFeedbackReport() {
      // Trigger printing
      window.print();
    }
</script>
  
  <%
        } else {
            out.println("No data found.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        // Handle the exception (e.g., show an error message)
    } finally {
        try {
            if (rs != null) rs.close();
            if (preparedStatement != null) preparedStatement.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
  %>
 
</body>
</html>
