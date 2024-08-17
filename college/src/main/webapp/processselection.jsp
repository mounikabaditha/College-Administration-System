<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  
  <style>
   body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    
    .container {
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      width: 100%;
    }
    
    h1 {
      text-align: center;
      margin-bottom: 20px;
    }
    
    form {
      display: flex;
      flex-direction: column;
    }
    
    label {
      margin-bottom: 5px;
      font-weight: bold;
      color: #555;
    }
    
    input[type="text"],
    input[type="number"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 16px;
      margin-bottom: 10px;
    }
    
    input[type="checkbox"] {
      margin-right: 5px;
      margin-bottom: 15px; /* Add margin-bottom to create space between checkboxes */
    }
    input[type="submit"] {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
            margin-bottom: 15px; /* Add margin-bottom to create space between checkboxes */
      
    }
    
    input[type="submit"]:hover {
      background-color: #45a049;
    }
    select {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 16px;
      margin-bottom: 10px;
      width: 100%; /* Adjust the width as needed */
    }
    
    hr {
      margin: 20px 0;
    }
  </style>
</head>
<body>
  
   <div class="container">
   <% String rollNo = request.getParameter("rollNo"); %>
    <% String name = request.getParameter("name"); %>
    <% String fatherName = request.getParameter("fatherName"); %>
    <% String contact = request.getParameter("contact"); %>
    <% String currentYear = request.getParameter("currentYear"); %>

    

    <%-- Process the selected year and semester parameters --%>
    <% String year = request.getParameter("year"); %>
    <% String semester = request.getParameter("semester"); %>

    
  <form method="post">
  <%-- Retrieve parameters sent from the previous page --%>
    
    <label for="regulation">Regulation:</label>
<select name="regulation" id="regulation" required>
  <option value="20">20</option>
  <option value="23">23</option>
  <option value="24">24</option>
  <option value="25">25</option>
  <option value="26">26</option>
  <option value="27">27</option>
  <option value="28">28</option>
  <option value="29">29</option>
  <option value="30">30</option>
</select>
      <label for="AcademicYear">Academic Year:</label>
        <select name="AcademicYear" id="AcademicYear" required>
          <option value="2021">20-21</option>
          <option value="2122">21-22</option>
          <option value="2223">22-23</option>
          <option value="2324">23-24</option>
          <option value="2425">24-25</option>
          <option value="2526">25-26</option>
         </select>    
    <label for="branch">Branch:</label>
    <select name="branch" id="branch" required>
      <option value="cse">CSE</option>
      <option value="ece">ECE</option>
      <option value="eee">EEE</option>
      <option value="cse_aids">CSE AIDS</option>
      <option value="cse_ds">CSE DS</option>
      <option value="mech">Mech</option>
      <option value="mba">MBA</option>
      <option value="mtech">M.Tech</option>
      <!-- Add other options as needed -->
    </select>
    <label for="section">Section:</label>
        <select name="section" id="section" required>
          <option value="A">A</option>
          <option value="B">B</option>
        </select>
    
    <input type="submit" value="Display">
    
  </form>
  
  <hr>
  
  <%-- Display the subject checkboxes dynamically based on user selection --%>
  <%
    String selectedRegulation = request.getParameter("regulation");
    String selectedBranch = request.getParameter("branch");
    int selectedYear = Integer.parseInt(request.getParameter("year"));
    int selectedSemester = Integer.parseInt(request.getParameter("semester"));
    String selectedAcademicYear = request.getParameter("AcademicYear");
    String selectedsection = request.getParameter("section");
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
      Class.forName("com.mysql.jdbc.Driver");
      String dbUrl = "jdbc:mysql://localhost:3306/student";
      String dbUsername = "root";
      String dbPassword = "system@123";
      conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
      stmt = conn.createStatement();
      
      String sql = "SELECT subject_name FROM subject_data WHERE regulation = '" + selectedRegulation + "' AND branch = '" + selectedBranch + "' AND year = " + selectedYear + " AND semester = " + selectedSemester + " AND AcademicYear = '" + selectedAcademicYear + "' AND section = '" + selectedsection + "'";

      rs = stmt.executeQuery(sql);
  %>
  
  <label>Select Subjects:</label>
  <div>
    <% while (rs.next()) { %>
      <input type="checkbox" name="subjects" value="<%= rs.getString("subject_name") %>">
      <label><%= rs.getString("subject_name") %></label><br>
    <% } %>
    
  </div>
 
  
   
  </form>
  <form action="add.jsp" method="post"  onsubmit="captureSelectedSubjects()">
  <input type="hidden" name="rollNo" value="<%= rollNo %>">
    <input type="hidden" name="name" value="<%= name %>">
    <input type="hidden" name="fatherName" value="<%= fatherName %>">
    <input type="hidden" name="contact" value="<%= contact %>">
    <input type="hidden" name="currentYear" value="<%= currentYear %>">
    <input type="hidden" name="year" value="<%= year %>">
    <input type="hidden" name="semester" value="<%= semester %>">
    <input type="hidden" name="regulation" value="<%= selectedRegulation %>">
    <input type="hidden" name="branch" value="<%= selectedBranch %>">
     <input type="hidden" name="selectedSubjects" id="selectedSubjects">
  
  <input type="submit" value="save">
  </form>
  <script>
    // JavaScript function to capture selected subjects as an array
    function captureSelectedSubjects() {
        var selectedSubjects = [];
        var subjectCheckboxes = document.querySelectorAll('input[name="subjects"]:checked');

        subjectCheckboxes.forEach(function (checkbox) {
            selectedSubjects.push(checkbox.value);
        });

        // Store the selected subjects as an array in the hidden input field
        document.getElementById('selectedSubjects').value = JSON.stringify(selectedSubjects);
    }
</script>
  
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
</div>
</body>
</html>
