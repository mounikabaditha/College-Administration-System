<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Student Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://t3.ftcdn.net/jpg/04/40/28/66/360_F_440286633_bvNYX5I6HRa7swCorzWCId6YYGJhMMgo.jpg');
            background-size: 100%;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
         marquee h1 {
        font-weight: bold;
        color: black;
        text-shadow: 2px 2px 4px white;
    }
    .logo {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 190px; /* Set the desired width */
        height: 190px; /* Set the desired height */
        background-image: url('https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj');
        background-size: contain;
        background-repeat: no-repeat;
    }
        
        .center {
            text-align: center;
            margin-left: 600px;
            margin-top: 130px;
            padding: 8px;
            width: 30%;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            color: #333;
        }
         
        h2 {
            color: blue;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        
        input {
            width: 50%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #45a049;
        }
   
    </style>
</head>
<body>

    <center>  <h1 style="font-size: 50px;">Eluru College Of Engineering and Technology</h1></center>
    

    <!-- Your header and navigation here -->
<div class="logo"></div>

    
    <!-- Your header and navigation here -->

    <div class="center">
        <h2>Update Student Registration</h2>
        <form action="update_registration.jsp" method="post">
            <label for="id">Enter Student ID:</label>
            <input type="text" id="id" name="id" required>
        </form>

        
        <%
            String studentId = request.getParameter("id");

            if (studentId != null) {
                String driver = "com.mysql.jdbc.Driver";
                String url = "jdbc:mysql://localhost:3306/student";
                String dbUsername = "root";
                String dbPassword = "system@123";

                try {
                    Class.forName(driver);
                    Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);

                    String query = "SELECT * FROM student_registration WHERE Id = ?";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, studentId);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String password = rs.getString("Password");
                        String regulation = rs.getString("Regulation");
                        String academicYear = rs.getString("AcademicYear");
                        String branch = rs.getString("branch");
                        String year = rs.getString("Year");
                        String semester = rs.getString("Semester");
                        String section = rs.getString("Section");

                        %>
                        
                        <!-- Form for updating details -->
                        <form action="update_details.jsp" method="post">
                            <input type="hidden" name="id" value="<%= studentId %>">
                            
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" value="<%= password %>" required><br>
                            
                            <label for="regulation">Regulation:</label>
                            <input type="text" id="regulation" name="regulation" value="<%= regulation %>" required><br>
                            
                            <label for="academicYear">Academic Year:</label>
                            <input type="text" id="academicYear" name="academicYear" value="<%= academicYear %>" required><br>
                            
                            <label for="branch">Branch:</label>
                            <input type="text" id="branch" name="branch" value="<%= branch %>" required><br>
                            
                            <label for="year">Year:</label>
                            <input type="text" id="year" name="year" value="<%= year %>" required><br>
                            
                            <label for="semester">Semester:</label>
                            <input type="text" id="semester" name="semester" value="<%= semester %>" required><br>
                            
                            <label for="section">Section:</label>
                            <input type="text" id="section" name="section" value="<%= section %>" required><br>
                            
                            <button type="submit">Update Details</button>
                        </form>
                        <%
                    } else {
                        out.println("<p>No student found with ID: " + studentId + "</p>");
                    }

                    rs.close();
                    pstmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            }
        %>
    </div>

    <!-- Your footer here -->
</body>
</html>
