<%@ page import="java.sql.*" %>

<%
try {
    // Get the form data
    String subjectCode = request.getParameter("subjectCode");
    String studentRegistration = request.getParameter("student_registration");
    int internalMarks = Integer.parseInt(request.getParameter("internal_marks"));
    int externalMarks = Integer.parseInt(request.getParameter("external_marks"));

    // Create a connection to the databaseClass.forName("com.mysql.jdbc.Driver");
    Class.forName("com.mysql.jdbc.Driver");
    
    String url = "jdbc:mysql://localhost:3306/student";
    String user = "root";
    String password = "system@123";
    Connection conn = DriverManager.getConnection(url, user, password);

    // Prepare and execute the insert statement for the subject data
    String insertSql = "INSERT INTO " + subjectCode + " (student_registration, subject_code, branch, year, semester, internal_marks, external_marks) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement insertStmt = conn.prepareStatement(insertSql);
    insertStmt.setString(1, studentRegistration);
    insertStmt.setString(2, subjectCode);
    insertStmt.setString(3, request.getParameter("branch"));
    insertStmt.setInt(4, Integer.parseInt(request.getParameter("year")));
    insertStmt.setInt(5, Integer.parseInt(request.getParameter("semester")));
    insertStmt.setInt(6, internalMarks);
    insertStmt.setInt(7, externalMarks);
    insertStmt.executeUpdate();

    // Close the connection and statement
    insertStmt.close();
    conn.close();

    out.println("Subject data inserted successfully");
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
    e.printStackTrace();
}
%>
