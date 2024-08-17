<%@ page import="java.sql.*" %>


<% 
try {
    // Get the form data
    Class.forName("com.mysql.jdbc.Driver");
    String regulation = request.getParameter("regulation");
    int  num_std = Integer.parseInt(request.getParameter("num_std"));
    String AcademicYear = request.getParameter("AcademicYear");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    int num_subjects = Integer.parseInt(request.getParameter("num_subjects"));
    
    String section = request.getParameter("section");

    // Create a connection to the database
    String url = "jdbc:mysql://localhost:3306/student";
    String user = "root";
    String password = "system@123";
    Connection conn = DriverManager.getConnection(url, user, password);

    // Create a PreparedStatement to insert the regulation data
   String subjectSql = "INSERT INTO subject_data(regulation, branch, year, semester, subject_name, Academicyear, section, subject_faculty,num_std) VALUES ( ?,?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement subjectStmt = conn.prepareStatement(subjectSql);

    for (int i = 1; i <= num_subjects; i++) {
        String subject_name = request.getParameter("subject" + i + "_name");
        String subjectCode = regulation + year + semester + branch + i;
        String subject_faculty = request.getParameter("subject" + i + "_faculty");

        subjectStmt.setString(1, regulation);
        subjectStmt.setString(2, branch);
        subjectStmt.setInt(3, year);
        subjectStmt.setInt(4, semester);
        subjectStmt.setString(5, subject_name);
        subjectStmt.setString(6, AcademicYear);
        subjectStmt.setString(7, section);
        subjectStmt.setString(8, subject_faculty);
        subjectStmt.setInt(9, num_std);
        subjectStmt.executeUpdate();
    }

    // Close the connection and statements
    subjectStmt.close();
    conn.close();
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
    e.printStackTrace();
}
%>