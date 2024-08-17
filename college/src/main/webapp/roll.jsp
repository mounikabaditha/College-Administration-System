<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject Backlogs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            padding: 20px 0;
        }

        h3 {
            text-align: center;
            color: black;
            padding: 10px 0;
            margin-top: 10px;
        }

        table {
            border-collapse: collapse;
            width: 20%;
            margin: 20px auto;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        String selectedSubject = request.getParameter("subject");

        String dbUrl = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "system@123";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        int rowCount = 0; // Variable to count the rows

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Define the SQL query to select roll numbers of students with the selected subject as backlog
            String selectQuery = "SELECT rollNo FROM student_data1 WHERE selectedSubjects LIKE ?";
            pstmt = conn.prepareStatement(selectQuery);
            pstmt.setString(1, "%" + selectedSubject + "%");

            resultSet = pstmt.executeQuery();
    %>

    <h1>Backlogs for Subject: <%= selectedSubject %></h1>

    <table>
        <thead>
            <tr>
                <th>Roll Numbers</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (resultSet.next()) {
                    String rollNo = resultSet.getString("rollNo");
                    rowCount++; // Increment the row count inside the loop
            %>
            <tr>
                <td><%= rollNo %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <h3>Total Count of Roll Numbers: <%= rowCount %></h3> <!-- Display the total count -->

    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</body>
</html>
