<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your head content -->
</head>
<body>
    <%
        // Get the loginId from the URL
        String loginId = request.getParameter("loginId");

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "system@123";

        // Initialize variables for student details
        String password = "";
        String regulation = "";
        String academicYear = "";
        String year = "";
        String semester = "";
        String section = "";
        String branch = "";

        // Fetch student details from the database based on loginId
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            String query = "SELECT * FROM student_details WHERE Id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, loginId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                password = resultSet.getString("Password");
                regulation = resultSet.getString("Regulation");
                academicYear = resultSet.getString("AcademicYear");
                year = resultSet.getString("Year");
                semester = resultSet.getString("Semester");
                section = resultSet.getString("Section");
                branch = resultSet.getString("branch");
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <form id="studentForm" action="shrating.jsp" method="post">
        <div class="form-group">
            <label for="regulation">Regulation:</label>
            <input type="text" name="regulation" id="regulation" value="<%= regulation %>" required>
        </div>
        <div class="form-group">
            <label for="AcademicYear">Academic Year:</label>
            <select name="AcademicYear" id="AcademicYear" required>
                <option value="2021" <%= academicYear.equals("2021") ? "selected" : "" %>>20-21</option>
                <!-- Add other options with similar checks -->
            </select>
        </div>
        <!-- Add other form fields similarly -->

        <input type="hidden" name="loginId" id="loginId" value="<%= loginId %>" >

        <button type="submit">Submit</button>
    </form>

</body>
</html>
