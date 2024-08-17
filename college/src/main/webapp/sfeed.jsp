<!DOCTYPE html>
<html>
<head>
  <style>
    /* Define your CSS styles here */
    body {
      font-family: Arial, sans-serif;
      background-image: url('https://static.vecteezy.com/system/resources/thumbnails/012/189/186/small_2x/gold-shiny-glowing-vintage-frame-with-shadows-isolated-transparent-background-golden-luxury-realistic-rectangle-border-illustration-free-vector.jpg');
      background-size: 100%;
      margin: 0;
      padding: 0;
    }
     .logo {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 110px; /* Set the desired width */
        height: 100px; /* Set the desired height */
        background-image: url('https://yt3.googleusercontent.com/ytc/AOPolaTnDZi8nJ3asaFVsYE6Alx-B6u0vN1KpfJLSr2B=s900-c-k-c0x00ffffff-no-rj');
        background-size: contain;
        background-repeat: no-repeat;
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

    table {
      width: 98%; /* Adjust the width as needed */
      margin-top: 20px;
      border-collapse: collapse;
      margin: 0 auto; /* Center the table horizontally */
    }

   
    th, td {
      padding: 1px; /* Decrease the padding to reduce cell height */
      border: 1px solid #ccc;
      text-align: left;
      font-size: 14px; /* Decrease the font size */
    }

    label {
      font-weight: bold;
    }
button[type="submit"] {
      background-color: #4CAF50;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }

    button[type="submit"]:hover {
      background-color: #45a049;
    }

    button[type="submit"]:focus {
      outline: none;
    }
    input[type="radio"] {
      margin-right: 3px;
    }

    input[type="submit"] {
      display: block;
      margin-top: 0px; /* Adjust margin as needed */
      background-color: #009688;
      color: #fff;
      border: none;
      padding: 10px 26px;
      border-radius: 2px;
      cursor: pointer;
      font-size: 12px;
      margin-left: auto; /* Align to the right */
      margin-right: auto; /* Align to the right */
    }

    input[type="submit"]:hover {
      background-color: #00796b;
    }  </style>
</head>
<body>
  <h1>Eluru College Of Engineering and Technology</h1>

  <!-- Logo div -->
  <div class="logo"></div>

  <div class="center">
    <div class="form-container">
      <form action="result.jsp" method="post">
        <% 
          String regulation = request.getParameter("regulation");
          String AcademicYear = request.getParameter("AcademicYear");
          String branch = request.getParameter("branch");
          int year = Integer.parseInt(request.getParameter("year"));
          int semester = Integer.parseInt(request.getParameter("semester"));
          String section = request.getParameter("section");
          
          int feedbackNo = Integer.parseInt(request.getParameter("feedbackNo")); // Default value if feedbackNo is not provided
          String loginId = request.getParameter("loginId");
          String selectedSubject = request.getParameter("selectedSubject");
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
<h3><center>Department: <%= branchFullName %></h3>
        <table>
          <tr>
            <th><center>Statement</th>
            <th><center>Rating</th>
          </tr>
          <% for (int i = 1; i <= 10; i++) { %>
            <tr>
              <td>
                <ul>
                  <li>
                    <% 
                      String statement = "";
                      if (i == 1) { statement = "Lectures were well prepared and organized"; }
                      else if (i == 2) { statement = "Black board writing / visuals aids are clear and organized"; }
                      else if (i == 3) { statement = "Lectures delivered with an emphasis on fundamental concepts / examples"; }
                      else if (i == 4) { statement = "Teachers engage classes regularly & maintain discipline"; }
                      else if (i == 5) { statement = "Difficult topics are taught with adequate attention & ease"; }
                      else if (i == 6) { statement = "Faculty able to deliver lectures with good communication skills"; }
                      else if (i == 7) { statement = "Students were encouraged to ask questions, making lectures interactive & lively"; }
                      else if (i == 8) { statement = "The teacher is effective in preparing students for exams"; }
                      else if (i == 9) { statement = "Evaluation is fair & impartial, helping you to improve"; }
                      else if (i == 10) { statement = "Faculty is accessible to students for guidance & solving queries"; }
                      out.print(statement);
                    %>
                  </li>
                </ul>
              </td>
              <td>
               
                  <% 
                    String[] ratingLabels = { "Poor", "Average", "Satisfactory", "Good", "Excellent" };
                    for (int rating = 1; rating <= 5; rating++) { 
                  %>
                    <input type="radio" name="q<%= i %>" value="<%= rating %>" required>
                    <%= ratingLabels[rating - 1] %>
                    &nbsp;&nbsp;&nbsp;
                  <% } %>

              </td>
            </tr>
          <% } %>
        </table>
        
        <input type="hidden" name="loginId" value="<%= loginId %>">
        <input type="hidden" name="regulation" value="<%= regulation %>">
        <input type="hidden" name="AcademicYear" value="<%= AcademicYear %>">
        <input type="hidden" name="branch" value="<%= branch %>">
        <input type="hidden" name="year" value="<%= year %>">
        <input type="hidden" name="semester" value="<%= semester %>">
        <input type="hidden" name="section" value="<%= section %>">
        <input type="hidden" name="feedbackNo" value="<%= feedbackNo %>">
        <input type="hidden" name="selectedSubject" value="<%= selectedSubject %>">
        
        <br><br>
       
        <input type="submit" value="submit">
        

      </form>
    </div>
  </div>

</body>
</html>
