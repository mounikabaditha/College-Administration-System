<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Selected Subject Data</title>
    <style>
             body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-image: url('https://t3.ftcdn.net/jpg/04/40/28/66/360_F_440286633_bvNYX5I6HRa7swCorzWCId6YYGJhMMgo.jpg');
    background-size: 100%;
}

h2 {
    text-align: center;
    margin-top: 20px;
}

form {
    max-width: 500px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
}

select {
    width: 50%;
    padding: 8px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
}

input[type="text"] {
    width: 50%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button[type="submit"] {
    display: block;
    margin-top: 15px;
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button[type="submit"]:hover {
    background-color: #0056b3;
}

.hidden {
    display: none;
}
 .logo {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 160px; /* Set the desired width */
      height: 160px; /* Set the desired height */
      background-image: url('https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj');
      background-size: contain;
      background-repeat: no-repeat;
      }
    
    </style>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const typeSelector = document.getElementById("typeSelector");
        const typeInputs = document.getElementsByName("type");
        
        typeSelector.addEventListener("change", function () {
            const selectedType = typeSelector.value;
            
            for (let i = 0; i < typeInputs.length; i++) {
                typeInputs[i].value = selectedType;
            }
        });
    });
</script>
    
</head>
<body>
<center><h1>Eluru College Of Engineering and Technology</h1></center>

  <!-- Logo div -->
  <div class="logo"></div>
    
    <form method="post" action="updatemarks.jsp">
        <!-- Your form elements here -->
        
        <!-- Inside the <table> element, replace your existing code with this: -->
        <select id="typeSelector">
    <option value="ct1">CT1</option>
    <option value="ct2">CT2</option>
    <option value="ct3">CT3</option>
    <option value="ct4">CT4</option>
    <option value="mid1">Mid1</option>
    <option value="mid2">Mid2</option>
    <option value="external">External</option>
    <option value="internal">Internal</option>
</select>
<table>
    <tr>
        <th>ID</th>
        <th>Marks</th>
        <th>Type</th>
    </tr>
    <%
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/student";
        String dbUsername = "root";
        String dbPassword = "system@123";
        
        String selectedSubject = request.getParameter("selectedSubject");
        String regulation = request.getParameter("regulation");
        String AcademicYear = request.getParameter("AcademicYear");
        String branch = request.getParameter("branch");
        int year = Integer.parseInt(request.getParameter("year"));
        int semester = Integer.parseInt(request.getParameter("semester"));
        String section = request.getParameter("section");
        
        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
            
            // Query to select student IDs from student_registration based on regulation, year, and semester
            String idQuery = "SELECT Id FROM student_registration WHERE regulation = ? AND AcademicYear = ? AND branch = ? AND year = ? AND semester = ? AND section = ?";
            PreparedStatement idStmt = con.prepareStatement(idQuery);
            idStmt.setString(1, regulation);
            idStmt.setString(2, AcademicYear);
            idStmt.setString(3, branch);
            idStmt.setInt(4, year);
            idStmt.setInt(5, semester);
            idStmt.setString(6, section);
            ResultSet idRs = idStmt.executeQuery();
            
            // Iterate through the IDs and display the table rows
            while (idRs.next()) {
                String studentId = idRs.getString("Id");
    %>
                <tr>
                    <td><%= studentId %></td>
                    <td><input type="text" name="marks" value=""></td>
                    <td><input type="text" name="type" value=""></td>
                    <td><input type="hidden" name="Id" value="<%= studentId %>"></td>
                </tr>
    <%
            }
            idRs.close();
            idStmt.close();
            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>
</table>


        
        
        
       <input type="hidden" name="selectedSubject" value="<%= selectedSubject %>">
       <input type="hidden" name="regulation" value="<%= regulation %>">
        <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
        <input type="hidden" name="branch" value="<%= branch %>">
        <input type="hidden" name="year" value="<%= year %>">
        <input type="hidden" name="semester" value="<%= semester %>">
        <input type="hidden" name="section" value="<%= section %>">
        
        <button type="submit">Enter</button>
    </form>
</body>
</html>
