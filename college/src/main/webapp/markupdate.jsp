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
	h1 {
		color: black;
		text-align: center;
		margin-bottom: 20px;
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
    }

    h2 {
      text-align: center;
      color: #009688;
    }

    .subject-rating {
      margin-bottom: 10px;
    }

    label {
      font-weight: bold;
    }

    input[type="submit"] {
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
  </style>
</head>
<body>
  <h1>Eluru College Of Engineering and Technology</h1>

  <!-- Logo div -->
  <div class="logo"></div>
  <div class="center">
    <div class="form-container">
      <form action="markprocess.jsp" method="post">
        <h2>Feedback</h2>
       
        <%-- Retrieve the form data --%>
        <%
  String regulation = request.getParameter("regulation");
  String AcademicYear = request.getParameter("AcademicYear");
  String branch = request.getParameter("branch");
  int year = Integer.parseInt(request.getParameter("year"));
  int semester = Integer.parseInt(request.getParameter("semester"));
  String section = request.getParameter("section");

%>
        

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
