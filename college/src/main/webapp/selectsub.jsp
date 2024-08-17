<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject Filter</title>
    <style>
        body {
            background-image: url('https://static.vecteezy.com/system/resources/previews/003/557/257/non_2x/abstract-blue-and-gray-wave-background-free-vector.jpg'); /* Replace with the actual path to your background image */
            background-size: cover;
            background-repeat: no-repeat;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333; /* Change the color to your preference */
        }

        form {
            background-color: rgba(255, 255, 255, 0.8); /* Add a semi-transparent white background to the form */
            padding: 20px;
            margin: 20px auto;
            max-width: 500px;
            border-radius: 10px;
        }

        label, select {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc; /* Change the border color to your preference */
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #007BFF; /* Change the button background color to your preference */
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* Change the button color on hover to your preference */
        }

        select[multiple] {
            height: 200px; /* Set the height of the multiple select box */
        }
    </style>
</head>
<body>
    <h1>Subject Filter</h1>
    
    <form action="" method="post">
        <label>Regulation:</label>
        <input type="text" name="regulation">
				
        <label>Branch:</label>
        <select name="branch">
            <option value="cse">CSE</option>
            <option value="ece">ECE</option>
            <option value="eee">EEE</option>
            <option value="mech">Mech</option>
            <option value="cse-ai">CSE-AI</option>
            <option value="cse-ds">CSE-DS</option>
            <option value="mba">MBA</option>
        </select>

        <label>Year:</label>
        <select name="year">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
        </select>

        <label>Semester:</label>
        <select name="semester">
            <option value="1">1</option>
            <option value="2">2</option>
        </select>
        
        <input type="submit" value="Filter Subjects">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String regulation = request.getParameter("regulation");
            String branch = request.getParameter("branch");
            String year = request.getParameter("year");
            String semester = request.getParameter("semester");

            String dbUrl = "jdbc:mysql://localhost:3306/student";
            String dbUsername = "root";
            String dbPassword = "system@123";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                // Define the SQL query to select subjects based on filters
                String selectQuery = "SELECT DISTINCT subject_name FROM subject_data WHERE regulation = ? AND branch = ? AND year = ? AND semester = ?";
                pstmt = conn.prepareStatement(selectQuery);
                pstmt.setString(1, regulation);
                pstmt.setString(2, branch);
                pstmt.setString(3, year);
                pstmt.setString(4, semester);

                resultSet = pstmt.executeQuery();
        %>

        <h2><center>Selected Subjects:</center></h2>
        <form class="form" action="roll.jsp" method="get" target="_blank">
            <label for="subject">Select Subject:</label>
            <select id="subject" name="subject">
                <%
                    while (resultSet.next()) {
                        String subjectName = resultSet.getString("subject_name");
                %>
                <option value="<%= subjectName %>"><%= subjectName %></option>
                <%
                    }
                %>
            </select>
            <button type="submit">Show</button>
        </form>
              

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
        }
    %>
</body>
</html>
