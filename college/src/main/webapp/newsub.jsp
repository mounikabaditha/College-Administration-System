<%@ page import="java.sql.*" %>


<% 
try {
    // Get the form data
    Class.forName("com.mysql.jdbc.Driver");
    String regulation = request.getParameter("regulation");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    int num_subjects = Integer.parseInt(request.getParameter("num_subjects"));
    
   

    // Create a connection to the database
    String url = "jdbc:mysql://localhost:3306/student";
    String user = "root";
    String password = "system@123";
    Connection conn = DriverManager.getConnection(url, user, password);

    // Create a PreparedStatement to insert the regulation data
   String subjectSql = "INSERT INTO subject_data1(regulation, branch, year, semester, subject_name) VALUES ( ?,?, ?, ?, ?)";
    PreparedStatement subjectStmt = conn.prepareStatement(subjectSql);

    for (int i = 1; i <= num_subjects; i++) {
        String subject_name = request.getParameter("subject" + i + "_name");
        String subjectCode = regulation + year + semester + branch + i;
        

        subjectStmt.setString(1, regulation);
        subjectStmt.setString(2, branch);
        subjectStmt.setInt(3, year);
        subjectStmt.setInt(4, semester);
        subjectStmt.setString(5, subject_name);
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