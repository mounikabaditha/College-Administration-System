<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <!-- ... your existing head content ... -->
</head>
<body>
<div>
    <h1><center>Attendance Calculator Results</h1>
    <table>
        <tr>
            <th>Roll Number</th>
            <%
                // Get form data
                String regulation = request.getParameter("regulation");
                String academicYear = request.getParameter("AcademicYear");
                String branch = request.getParameter("branch");
                String year = request.getParameter("year");
                String semester = request.getParameter("semester");
                String section = request.getParameter("section");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");

                Connection con = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver"); // Use the appropriate JDBC driver
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "system@123"); // Replace with your DB info

                    // Query to retrieve subjects based on the selected criteria from subject_data
                    String subjectQuery = "SELECT subject_name FROM subject_data " +
                            "WHERE regulation = ? AND branch = ? AND year = ? AND semester = ? AND AcademicYear = ? AND section = ?";
                    PreparedStatement subjectStmt = con.prepareStatement(subjectQuery);
                    subjectStmt.setString(1, regulation);
                    subjectStmt.setString(2, branch);
                    subjectStmt.setString(3, year);
                    subjectStmt.setString(4, semester);
                    subjectStmt.setString(5, academicYear);
                    subjectStmt.setString(6, section);
                    ResultSet subjectResult = subjectStmt.executeQuery();
                   
                    // Dynamically generate columns for subjects as table headers
                    while (subjectResult.next()) {
                        String subjectName = subjectResult.getString("subject_name");
                        
                    %>
                        <!-- Generate columns for subjects as headings -->
                        <th><%= subjectName %></th>
                        
                            
                        
                    <%
                    }
                    %>
                    
                </tr>
                
                <%
                // Query to retrieve roll numbers based on the selected criteria from student_registration
                String rollNumberQuery = "SELECT Id FROM student_registration " +
                        "WHERE regulation = ? AND branch = ? AND year = ? AND semester = ? AND AcademicYear = ? AND section = ?";
                PreparedStatement rollNumberStmt = con.prepareStatement(rollNumberQuery);
                rollNumberStmt.setString(1, regulation);
                rollNumberStmt.setString(2, branch);
                rollNumberStmt.setString(3, year);
                rollNumberStmt.setString(4, semester);
                rollNumberStmt.setString(5, academicYear);
                rollNumberStmt.setString(6, section);
                ResultSet rollNumberResult = rollNumberStmt.executeQuery();

                // Dynamically generate rows for roll numbers
                while (rollNumberResult.next()) {
                    String rollNumber = rollNumberResult.getString("Id");
                %>
                    <!-- Generate rows for roll numbers -->
                    <tr>
                        <td><%= rollNumber %></td>
                <%
                    // Loop through the subjects to calculate and display attendance
                    subjectResult.beforeFirst(); // Reset the subjectResult cursor
                    while (subjectResult.next()) {
                        String subjectName = subjectResult.getString("subject_name");

                        // Query to retrieve attendance for the current student and subject
                        String attendanceQuery = "SELECT attendance FROM attendance_data " +
                                "WHERE studentId = ? AND subject = ? " +
                                "AND date BETWEEN ? AND ?";
                        PreparedStatement attendanceStmt = con.prepareStatement(attendanceQuery);
                        attendanceStmt.setString(1, rollNumber);
                        attendanceStmt.setString(2, subjectName);
                        attendanceStmt.setString(3, startDate);
                        attendanceStmt.setString(4, endDate);
                        ResultSet attendanceResult = attendanceStmt.executeQuery();
                        int tot=0;
                        while (attendanceResult.next())
                        {
                           tot++;
                           }
                        out.print(tot);

                        int absentDays = 0; 

                        // Calculate attendance for the subject
                        int totalDays = 0;
                        int presentDays = 0;
                        while (attendanceResult.next()) {
                            
                            if (attendanceResult.getString("attendance").equals("1")) {
                                presentDays++;
                            }
                        }
                        int attendancePercentage = presentDays;
                        
                %>
                    <!-- Display attendance for the subject -->
                    <td><%= attendancePercentage %></td>
                   
                    
                <%
                    }
                %>
                    </tr>
                <%
                }
            } catch (Exception e) {
                out.println("Error: " + e);
            } finally {
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.println("Error closing database connection: " + e);
                }
            }
            %>
        </tr>
        <!-- Continue building your table with student attendance data -->
    </table>
    <div class="print-button-container">
        <button class="print-button" onclick="printFeedbackReport()">Print</button>
    </div>
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
