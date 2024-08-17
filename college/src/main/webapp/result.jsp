<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
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
  </style>
</head>
<body>
  <%
    // Retrieve data from the form
    String loginId = request.getParameter("loginId");
    String regulation = request.getParameter("regulation");
    String AcademicYear = request.getParameter("AcademicYear");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    String section = request.getParameter("section");
    int feedbackNo = Integer.parseInt(request.getParameter("feedbackNo"));
    String selectedSubject = request.getParameter("selectedSubject");
    
    // Array to store the ratings
    int[] ratings = new int[10];
    for (int i = 1; i <= 10; i++) {
        String ratingParam = request.getParameter("q" + i);
        ratings[i - 1] = (ratingParam != null && !ratingParam.isEmpty()) ? Integer.parseInt(ratingParam) : 0;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/student";
    String dbUsername = "root";
    String dbPassword = "system@123";

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        // Insert data into the database
        String insertQuery = "INSERT INTO feedback_data1 (loginId, regulation, AcademicYear, branch, year, semester, section, feedbackNo, rating1, rating2, rating3, rating4, rating5, rating6, rating7, rating8, rating9, rating10, selectedSubject) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = conn.prepareStatement(insertQuery);

        preparedStatement.setString(1, loginId);
        preparedStatement.setString(2, regulation);
        preparedStatement.setString(3, AcademicYear);
        preparedStatement.setString(4, branch);
        preparedStatement.setInt(5, year);
        preparedStatement.setInt(6, semester);
        preparedStatement.setString(7, section);
        preparedStatement.setInt(8, feedbackNo);
        for (int i = 0; i < 10; i++) {
            preparedStatement.setInt(i + 9, ratings[i]);
        }
        preparedStatement.setString(19, selectedSubject);

        preparedStatement.executeUpdate();
       

        // Close the database connection
        preparedStatement.close();
        conn.close();

        out.println("<div class=\"message\"><h1>Feedback submitted successfully!<h1></div>");
        
    } catch (Exception e) {
        e.printStackTrace();
       
    }
    
  %>
  <div class="button-container">
    <form action="shrating.jsp" method="get">
      <input type="hidden" name="loginId" value="<%= loginId %>">
      <input type="hidden" name="regulation" value="<%= regulation %>">
      <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
      <input type="hidden" name="branch" value="<%= branch %>">
      <input type="hidden" name="year" value="<%= year %>">
      <input type="hidden" name="semester" value="<%= semester %>">
      <input type="hidden" name="section" value="<%= section %>">
      <input type="hidden" name="feedbackNo" value="<%= feedbackNo %>">
      <button type="submit">Go back</button>
    </form>
    
    <form action="std.html" method="get">
      <button type="submit">Logout</button>
    </form>
  </div>
 
  
</body>
</html>
