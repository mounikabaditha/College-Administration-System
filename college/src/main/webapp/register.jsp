<%@page import="java.sql.*"%>
<%@ page language="java" %>

<%
	String firstName = request.getParameter("fname");
	String lastName = request.getParameter("lname");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String gender = request.getParameter("gender");

	
	try {
        // Connect to database
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student";
        String usernameDB = "root";
        String passwordDB = "system@123";
        Connection con = DriverManager.getConnection(url, usernameDB, passwordDB);
        
        // Insert user data into database
        String query = "INSERT INTO user1 (first_name, last_name, username, password, gender) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, gender);
       
        ps.executeUpdate();
        out.println("registered successfully");
        // Close database connection
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
