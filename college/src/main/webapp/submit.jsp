<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
// Database connection parameters
String url = "jdbc:mysql://localhost:3306/student";
String username = "root";
String password = "system@123";
String selectedSubject = request.getParameter("selectedSubject");
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(url, username, password);
    Statement statement = connection.createStatement();

    // Check if the table exists
    String checkTableQuery = "SHOW TABLE "+selectedSubject;
    ResultSet tables = statement.executeQuery(checkTableQuery);
    boolean tableExists = tables.next();

    if (!tableExists) {
        // Create the table if it doesn't exist
        String createTableQuery = "CREATE TABLE " + selectedSubject + " (" +
        "id varchar(10), " +
        "regulation VARCHAR(255), " +
        "branch VARCHAR(255), " +
        "year INT, " +
        "sem INT, " +
        "academicyear VARCHAR(255), " +
        "marks INT, " +
        "type VARCHAR(255))";
        statement.executeUpdate(createTableQuery);
    }

    // Get form data
    String regulation = request.getParameter("regulation");
    // Get other form fields similarly

    // Insert data into the table
    String insertQuery = "INSERT INTO " + selectedSubject + " (Id,regulation, branch, year, sem, academicyear, marks, type) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
    preparedStatement.setString(1, regulation);
    // Set other parameters similarly
    preparedStatement.executeUpdate();

    // Close resources
    preparedStatement.close();
    statement.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Submission Result</title>
</head>
<body>
    <h1>Form Submission Result</h1>
    <p>Data submitted successfully.</p>
</body>
</html>
