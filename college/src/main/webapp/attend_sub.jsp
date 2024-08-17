<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Details Form - Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://img.freepik.com/premium-vector/abstract-background-blue-white-gradient-modern-blue-abstract-geometric-rectangle-box-lines-background-presentation-design-banner-brochure-business-card_181182-30737.jpg');
            background-size: 100%;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: navy;
            text-align: center;
            margin-left:70px;
            margin-bottom: -10px;
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
        

        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top:-150px;
        }

        h2 {
            text-align: center;
            color: navy;
        }

        label {
            font-weight: bold;
        }

        /* Adjust the width of the select dropdown */
        select[name="subject"] {
            width: 100%; /* Set the desired width, e.g., 100% */
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: navy;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #00796b;
        }

        p.no-match {
            color: #f44336;
        }
    </style>
</head>
<body>
<h1>Eluru College Of Engineering and Technology</h1>

<!-- Logo div -->
<div class="logo"></div>
<div class="center">
    <div class="form-container">
        <form action="attendDis.jsp" method="post">
            <h2>Feedback</h2>
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required><br>

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required><br>

            <!-- Retrieve the form data -->
            <%
                String regulation = request.getParameter("regulation");
                String AcademicYear = request.getParameter("AcademicYear");
                String branch = request.getParameter("branch");
                int year = Integer.parseInt(request.getParameter("year"));
                int semester = Integer.parseInt(request.getParameter("semester"));
                String section = request.getParameter("section");

            %>
            <%
                String branchFullName = "";
                if (branch.equals("cse")) {
                    branchFullName = "Computer Science and Engineering";
                } else if (branch.equals("ece")) {
                    branchFullName = "Electronics and Communication Engineering";
                } else if (branch.equals("eee")) {
                    branchFullName = "Electrical and Electronics Engineering";
                } else if (branch.equals("mech")) {
                    branchFullName = "Mechanical Engineering";
                } else if (branch.equals("cse_aids")) {
                    branchFullName = "Artificial Intelligence and Data Science";
                } else if (branch.equals("mba")) {
                    branchFullName = "MBA";
                } else if (branch.equals("mtech")) {
                    branchFullName = "M.Tech";
                }
            %>
            <h4>Department: <%= branchFullName %></h4>

            <!-- Establish a connection to the database -->
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                String dbUrl = "jdbc:mysql://localhost:3306/student";
                String dbUsername = "root";
                String dbPassword = "system@123";

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    stmt = conn.createStatement();

                    String sql = "SELECT subject_name FROM subject_data WHERE regulation = '" + regulation + "' AND branch = '" + branch + "' AND year = " + year + " AND semester = " + semester + " AND AcademicYear = '" + AcademicYear + "' AND section = '" + section + "'";
                    rs = stmt.executeQuery(sql);
                    boolean hasSubjects = false;

            %>

            <select name="subject" required>
                <option value="" disabled selected>Select a subject</option> <!-- Added default option -->
                <%
                    while (rs.next()) {
                        hasSubjects = true;
                        String subjectName = rs.getString("subject_name");
                %>
                <option value="<%= subjectName %>"><%= subjectName %></option>
                <%
                    }
                %>
            </select>

            <input type="hidden" name="selectedSubject" id="selectedSubject" value="selectedsubject">
            <%
                if (!hasSubjects) {
            %>
            <p class="no-match">No matching subjects found for the entered details.</p>
            <%
                }
            %>

            <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
            <input type="hidden" name="selectedSubject" id="selectedSubject">

            <input type="hidden" name="regulation" value="<%= regulation %>">
            <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
            <input type="hidden" name="branch" value="<%= branch %>">
            <input type="hidden" name="year" value="<%= year %>">
            <input type="hidden" name="semester" value="<%= semester %>">
            <input type="hidden" name="section" value="<%= section %>">

            <br><br>
            <script>
                // JavaScript function to update the hidden field value when a subject is selected
                function updateSelectedSubject() {
                    var subjectSelect = document.querySelector('select[name="subject"]');
                    var selectedSubjectInput = document.getElementById('selectedSubject');
                    selectedSubjectInput.value = subjectSelect.value; // Set the selected subject name
                }

                // Attach the function to the change event of the subject select element
                var subjectSelect = document.querySelector('select[name="subject"]');
                subjectSelect.addEventListener('change', updateSelectedSubject);
            </script>

            <input type="submit" value="Submit">
        </form>
    </div>
</div>
</body>
</html>
