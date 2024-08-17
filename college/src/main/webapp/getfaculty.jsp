
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
    
   .submit-button-container {
            display: flex;
            justify-content: center;
            margin-bottom: 180px;
            height:40px;
  </style>
</head>
<body>

<%
   String dbURL = "jdbc:mysql://localhost:3306/student";
   String dbUsername = "root";
   String dbPassword = "system@123";

   String selectedSubject = request.getParameter("subject");
   String regulation = request.getParameter("regulation");
   String branch = request.getParameter("branch");
   int year = Integer.parseInt(request.getParameter("year"));
   int semester = Integer.parseInt(request.getParameter("semester"));
   String AcademicYear = request.getParameter("AcademicYear");
   String section = request.getParameter("section");
   int feedbackNo = Integer.parseInt(request.getParameter("feedbackNo"));

   Connection conn = null;
   PreparedStatement preparedStatement = null;
   ResultSet rs = null;

   try {
       Class.forName("com.mysql.jdbc.Driver");
       conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

       String sql = "SELECT num_std,subject_faculty FROM subject_data WHERE subject_name = ? AND regulation = ? AND branch = ? AND year = ? AND semester = ? AND Academicyear = ? AND section = ?";
       preparedStatement = conn.prepareStatement(sql);
       preparedStatement.setString(1, selectedSubject);
       preparedStatement.setString(2, regulation);
       preparedStatement.setString(3, branch);
       preparedStatement.setInt(4, year);
       preparedStatement.setInt(5, semester);
       preparedStatement.setString(6, AcademicYear);
       preparedStatement.setString(7, section);
       rs = preparedStatement.executeQuery();

       if (rs.next()) {
           String facultyName = rs.getString("subject_faculty");
           int num_std=rs.getInt("num_std");
    %>
    <!-- Create a form to pass values to another form -->
    <form action="ratingDisplay.jsp" method="post">
        <!-- Hidden input fields for passing values -->
        <input type="hidden" name="facultyName" value="<%= facultyName %>">
        <input type="hidden" name="regulation" value="<%= regulation %>">
        <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
        <input type="hidden" name="branch" value="<%= branch %>">
        <input type="hidden" name="year" value="<%= year %>">
        <input type="hidden" name="semester" value="<%= semester %>">
        <input type="hidden" name="section" value="<%= section %>">
         <input type="hidden" name="feedbackNo" value="<%= feedbackNo %>">
         <input type="hidden" name="selectedSubject" value="<%= selectedSubject %>">
         <input type="hidden" name="num_std" value="<%= num_std %>">
        
        <!-- Submit button to trigger redirection to the second form -->
<div class="submit-button-container">
                    <input class="submit-button" type="submit" value="Generate Feedback Report">
                </div>
                    </form>
    <%
       } else {
           out.println("Faculty Not Found");
       }
   } catch (Exception e) {
       e.printStackTrace();
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
</form>
        </div>
    </div>
</body>
</html>
