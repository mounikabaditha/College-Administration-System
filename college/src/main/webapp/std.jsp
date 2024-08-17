<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String loginId = request.getParameter("loginId");
    String password = request.getParameter("password");

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student";
        String usernameDB = "root";
        String passwordDB = "system@123";
        Connection con = DriverManager.getConnection(url, usernameDB, passwordDB);

        // Query to check if the login details exist in the database
        String query = "SELECT * FROM student_registration WHERE id= ? AND password = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, loginId);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // If the login details exist, redirect to dfeed.html with loginId as a query parameter
            response.sendRedirect("show.html?loginId=" + loginId);
        } else {
            // If the login details are incorrect, show an error message
            out.println("<script>alert('Incorrect login details. Please try again.'); window.location.href='slogin.html';</script>");
        }

        // Close the database connection
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
