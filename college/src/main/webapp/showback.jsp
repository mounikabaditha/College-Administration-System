<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display All Students</title>
</head>
<body>
<%
String rollNo = request.getParameter("rollNo");
%>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/student";
            String dbUser = "root";
            String dbPass = "system@123";
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

            String selectQuery = "SELECT * FROM student_backlogs where roll_no=?";
            PreparedStatement preparedStatement = conn.prepareStatement(selectQuery);
            preparedStatement.setString(1, rollNo); // Set the roll number parameter
            rs = preparedStatement.executeQuery();
           
            

            %>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Father's Name</th>
                    <th>Contact</th>
                    <th>Current Year</th>
                    <th>Total Backlogs</th>
                    <th>Year 1 Sem 1</th>
                    <th>Year 1 Sem 2</th>
                    <th>Year 2 Sem 1</th>
                    <th>Year 2 Sem 2</th>
                    <th>Year 3 Sem 1</th>
                    <th>Year 3 Sem 2</th>
                    <th>Year 4 Sem 1</th>
                    <th>Year 4 Sem 2</th>
                </tr>
                <%
                while (rs.next()) {
                    String year1Sem1 = rs.getString("year1_sem1");
                    String year1Sem2 = rs.getString("year1_sem2");
                    String year2Sem1 = rs.getString("year2_sem1");
                    String year2Sem2 = rs.getString("year2_sem2");
                    String year3Sem1 = rs.getString("year3_sem1");
                    String year3Sem2 = rs.getString("year3_sem2");
                    String year4Sem1 = rs.getString("year4_sem1");
                    String year4Sem2 = rs.getString("year4_sem2");
                    int notNullCountYear1Sem1 = 0;
                    int notNullCountYear1Sem2 = 0;
                    int notNullCountYear2Sem1 = 0;
                    int notNullCountYear2Sem2 = 0;
                    int notNullCountYear3Sem1 = 0;
                    int notNullCountYear3Sem2 = 0;
                    int notNullCountYear4Sem1 = 0;
                    int notNullCountYear4Sem2 = 0;
                    if (year1Sem1 != null) {
                        notNullCountYear1Sem1 = year1Sem1.split(",").length;
                    }

                    if (year1Sem2 != null) {
                        notNullCountYear1Sem2 = year1Sem2.split(",").length;
                    }
                    if (year2Sem1 != null) {
                        notNullCountYear2Sem1 = year2Sem1.split(",").length;
                    }
                    if (year2Sem2 != null) {
                        notNullCountYear2Sem2 = year2Sem2.split(",").length;
                    }
                    if (year3Sem1 != null) {
                        notNullCountYear3Sem1 = year3Sem1.split(",").length;
                    }
                    if (year3Sem2 != null) {
                        notNullCountYear3Sem2 = year3Sem2.split(",").length;
                    }
                    if (year4Sem1 != null) {
                        notNullCountYear4Sem1 = year4Sem1.split(",").length;
                    }

                    int totalBacklogs = notNullCountYear1Sem1 + notNullCountYear1Sem2+notNullCountYear2Sem1+notNullCountYear2Sem2+notNullCountYear3Sem1+notNullCountYear3Sem2+notNullCountYear4Sem1+notNullCountYear4Sem2;
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("roll_no") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("father_name") %></td>
                        <td><%= rs.getString("contact") %></td>
                        <td><%= rs.getInt("current_year") %></td>
                        <td><%= totalBacklogs %></td>
                        <td><%= year1Sem1 %></td>
                        <td><%= year1Sem2 %></td>
                        <td><%= year2Sem1 %></td>
                        <td><%= year2Sem2 %></td>
                        <td><%= year3Sem1 %></td>
                        <td><%= year3Sem2 %></td>
                        <td><%= year4Sem1 %></td>
                        <td><%= year4Sem2 %></td>
                    </tr>
                    <%
                }
                %>
            </table>
            <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</body>
</html>
