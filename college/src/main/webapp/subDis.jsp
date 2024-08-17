<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student Details Form - Result</title>
  <!-- Your CSS styles -->
  <!-- Your CSS styles -->
 <style>
     body {
      font-family: Arial, sans-serif;
      background-image: url('https://t3.ftcdn.net/jpg/04/40/28/66/360_F_440286633_bvNYX5I6HRa7swCorzWCId6YYGJhMMgo.jpg');
      background-size: 100%;
    }
    marquee h1 {
      font-size: 50px;
      font-weight: bold;
      color: black;
      text-shadow: 1px 1px 2px black; /* Adding text shadow */
    }
	h1 {
		color: black;
		text-align: center;
		margin-bottom: 2px;
		
		}
	
    .center {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    

    .form-container {
     font-size: 18px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin-left: 170px; /* Adding left margin */
      background-color: #fff;
      padding: 40px; /* Increase padding for more height */
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 500px; /* Increase width */
      max-width: 70%; /* Limit width to prevent overflow on smaller screens */
      margin-top: 30px; /* Add margin to the top */
    }

    h2 {
      text-align: center;
      color: #009688;
    }

    .subject-rating {
      margin-bottom: 10px;
    }

    label {
     font-size: 18px;
      font-weight: bold;
    }
 input[type="text"],
    input[type="number"],
    select {
      font-size: 18px;
      padding: 12px; /* Adjust padding as needed */
    }
    input[type="submit"] {
     font-size: 18px;
      background-color: #009688;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color: #00796b;
    }

    p.no-match {
      color: #f44336;
    }
    .logo {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 170px; /* Set the desired width */
      height: 170px; /* Set the desired height */
      background-image: url('https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj');
      background-size: contain;
      background-repeat: no-repeat;
      }
  </style>
</head>
<body>
 
 <center>  <h1 style="font-size: 50px;">Eluru College Of Engineering and Technology</h1></center>
  <!-- Logo div -->
  <div class="logo"></div>
  <div class="center">
    <div class="form-container">
      <form action="Display.jsp" method="post">
        <h2>Feedback</h2>
       
        <%-- Retrieve the form data --%>
        <%
  String regulation = request.getParameter("regulation");
  String AcademicYear = request.getParameter("AcademicYear");
  String branch = request.getParameter("branch");
  int year = Integer.parseInt(request.getParameter("year"));
  int semester = Integer.parseInt(request.getParameter("semester"));
  String section = request.getParameter("section"); 
  String type = request.getParameter("type");  
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
        

        <%-- Establish a connection to the database --%>
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
        <% while (rs.next()) { %>
            <% hasSubjects = true; %>
            <% String subjectName = rs.getString("subject_name"); %>
            <option value="<%= subjectName %>"><%= subjectName %></option>
        <% } %>
    </select>
             
              <input type="hidden" name="selectedSubject" id="selectedSubject" value="selectedsubject">
             <% if (!hasSubjects) { %>
               <p>No matching subjects found for the entered details.</p>
             <% } %>

           <% } catch (Exception e) {
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
        <input type="hidden" name="type" value="<%= type %>">
       
       
    
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