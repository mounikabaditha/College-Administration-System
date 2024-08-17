<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Submission Result</title>
    <!-- Your CSS styles -->
    <!-- ... (your existing styles) ... -->
    <style>
        /* Your existing styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://img.freepik.com/premium-vector/abstract-background-blue-white-gradient-modern-blue-abstract-geometric-rectangle-box-lines-background-presentation-design-banner-brochure-business-card_181182-30737.jpg');
            background-size: 100%;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
        }

        form {
            text-align: center; /* Center the form content */
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
            margin: 0 auto; /* Center the select element */
        }

        table {
            align: center;
            width: 50%;
            margin: 0 auto;
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
            margin: 0 auto; /* Center the text input element */
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
            margin: 0 auto; /* Center the submit button */
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
</head>
<body>
<center><h1>Eluru College Of Engineering and Technology</h1></center>

<div class="center">
    <div class="form-container">
        <h2>Attendance Submission Result</h2>
        <form method="post" action="confirm.jsp">
            <table>
            <tr>
                    <td colspan="2">
                        <label for="period">Period:</label>
                        <select id="period" name="period">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                        </select>

                        <label for="month">Month:</label>
                        <select id="month" name="month">
                            <option value="January">January</option>
                            <option value="February">February</option>
                            <option value="March">March</option>
                            <option value="April">April</option>
                            <option value="May">May</option>
                            <option value="June">June</option>
                            <option value="July">July</option>
                            <option value="August">August</option>
                            <option value="September">September</option>
                            <option value="October">October</option>
                            <option value="November">November</option>
                            <option value="December">December</option>
                        </select>

                        <label for="date">Date:</label>
                        <input type="date" id="date" name="date">
                    </td>
                </tr>
                <tr>
                    <th>ID</th>
                    <th>Attendance</th>
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
                String[] studentIds = null;

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

                    int numStudentIds = 0;
                    while (idRs.next()) {
                        numStudentIds++;
                    }
                    studentIds = new String[numStudentIds];

                    // Reset the result set pointer
                    idRs.beforeFirst();

                    // Populate the array with student IDs
                    int index = 0;
                    while (idRs.next()) {
                        studentIds[index] = idRs.getString("Id");
                        index++;
                    }

                    idRs.close();
                    idStmt.close();
                    con.close();

                    // Continue rendering the table
                    for (String studentId : studentIds) {
                    %>
                    <tr>
                        <td><%= studentId %></td>
                        <td>
                            <input type="hidden" name="studentIds[]" value="<%= studentId %>" />
                            <label for="attendance_<%= studentId %>"><%= studentId %>:</label>
                            <label><input type="radio" name="attendance[<%= studentId %>]" value="1" checked> Present</label>
                            <label><input type="radio" name="attendance[<%= studentId %>]" value="0"> Absent</label>
                        </td>
                    </tr>


                    <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
                }
                %>
                            </table>

            <!-- Your hidden inputs -->
            <input type="hidden" name="selectedSubject" value="<%= selectedSubject %>">
            <input type="hidden" name="regulation" value="<%= regulation %>">
            <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
            <input type="hidden" name="branch" value="<%= branch %>">
            <input type="hidden" name="year" value="<%= year %>">
            <input type="hidden" name="semester" value="<%= semester %>">
            <input type="hidden" name="section" value="<%= section %>">

            <!-- Submit button -->
            <button type="submit">Confirm Attendance</button>
        </form>
        <script>
            // Function to update the current date
            function updateCurrentDate() {
                var currentDate = new Date();
                var options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                var formattedDate = currentDate.toLocaleDateString(undefined, options);
                document.getElementById("date").value = formattedDate;
            }

            // Update the date initially and every 24 hours
            updateCurrentDate();
            setInterval(updateCurrentDate, 24 * 60 * 60 * 1000); // Update every 24 hours
        </script>
    </div>
</div>
</body>
</html>
