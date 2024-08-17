<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Form</title>
    <!-- Add your CSS styles here -->
</head>
<body>
<%
    String username = request.getParameter("username"); // Update parameter name
    String password = request.getParameter("password"); // Update parameter name

    try {
        // Connect to database
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student";
        String usernameDB = "root";
        String passwordDB = "system@123";
        Connection con = DriverManager.getConnection(url, usernameDB, passwordDB);

        // Query to check if the login details exist in the database
        String query = "SELECT * FROM student_registration WHERE ID = ? AND password = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // If the login details exist, redirect to the admin page or another desired page
            response.sendRedirect(".html"); // Replace "admin.html" with the appropriate page
        } else {
            // If the login details are incorrect, show an error message
            out.println("<script>alert('Invalid login details. Please try again.'); window.location.href='login.html';</script>");
        }

        // Close database connection
        con.close();
    } catch (ClassNotFoundException e) {
        out.println("Error: MySQL JDBC Driver not found.");
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>
