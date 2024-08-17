<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Table and Fill Data</title>
</head>
<body>
<%
  String selectedSubject = request.getParameter("selectedSubject");
  String regulation = request.getParameter("regulation");
  String AcademicYear = request.getParameter("AcademicYear");
  String branch = request.getParameter("branch");
  int year = Integer.parseInt(request.getParameter("year"));
  int semester = Integer.parseInt(request.getParameter("semester"));
  String section = request.getParameter("section");

  if (selectedSubject != null && !selectedSubject.isEmpty()) {
      String createTableSQL = "CREATE TABLE IF NOT EXISTS " + selectedSubject +
              " (id varchar(10) , Regulation varchar(50), Academicyear varchar(10), Year Int, Semester int, Section varchar(10), branch varchar(10), marks varchar(20), type varchar(30))";
      Connection conn = null;
      Statement stmt = null;
      String dbUrl = "jdbc:mysql://localhost:3306/student";
      String dbUsername = "root";
      String dbPassword = "system@123";

      try {
          Class.forName("com.mysql.jdbc.Driver");
          conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
          stmt = conn.createStatement();
          stmt.executeUpdate(createTableSQL);

          // Automatically fill the subject_name table's id column from the student_registration table
          String fillTableSQL = "INSERT INTO " + selectedSubject + " ( Regulation, Academicyear, Year, Semester, Section, branch) " +
                                "SELECT Id, Regulation, Academicyear, year, Semester, Section, branch FROM student_registration " +
                                "WHERE Regulation = '" + regulation + "' AND Academicyear = '" + AcademicYear + "' " +
                                "AND Year = " + year + " AND Semester = " + semester + " AND Section = '" + section + "' AND branch = '" + branch + "'";
          stmt.executeUpdate(fillTableSQL);
      } catch (SQLException se) {
          se.printStackTrace();
      } catch (ClassNotFoundException e) {
          e.printStackTrace();
      } finally {
          try {
              if (stmt != null) stmt.close();
              if (conn != null) conn.close();
          } catch (SQLException se) {
              se.printStackTrace();
          }
      }
      
      // Redirect to marks.jsp form after inserting data and pass selectedSubject as a query parameter
      response.sendRedirect("marks.jsp?selectedSubject=" + selectedSubject + "&regulation=" + regulation + "&AcademicYear=" + AcademicYear + "&branch=" + branch + "&year=" + year + "&semester=" + semester + "&section=" + section);
  }
%>
</body>
</html>
