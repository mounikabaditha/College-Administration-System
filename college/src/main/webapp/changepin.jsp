<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("Id");
    
    String newPassword = request.getParameter("newPassword");

    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/student";
    String dbUsername = "root";
    String dbPassword = "system@123";

    try {
        Class.forName(driver);
        Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);

        String selectQuery = "SELECT * FROM student_registration WHERE Id = ? ";
        PreparedStatement selectPstmt = con.prepareStatement(selectQuery);
        selectPstmt.setString(1, id);
        
        ResultSet resultSet = selectPstmt.executeQuery();

        if (resultSet.next()) {
            String updateQuery = "UPDATE student_registration SET Password = ? WHERE Id = ?";
            PreparedStatement updatePstmt = con.prepareStatement(updateQuery);
            updatePstmt.setString(1, newPassword);
            updatePstmt.setString(2, id);
            int rowsUpdated = updatePstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<h2>Password updated successfully</h2>");
            } else {
                out.println("<h2>Password update failed</h2>");
            }

            updatePstmt.close();
        } else {
            out.println("<h2>Invalid Id or Old Password</h2>");
        }

        selectPstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>
