<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Marks and Type</title>
    <!-- Your CSS styles -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('your-background-image-url.jpg'); /* Replace with your image URL */
            background-size: 100%;
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

        label {
            font-weight: bold;
        }

        input[type="number"],
        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
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

        p.error {
            color: #f44336;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="center">
    <div class="form-container">
        <form action="update_mark_process.jsp" method="post">
            <h2>Update Marks and Type</h2>

            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" required>

            <label for="newMarks">New Marks:</label>
            <input type="number" id="newMarks" name="newMarks" required>

            <label for="newType"> Type:</label>
            <select id="newType" name="newType" required>
               <option value="ct1">CT1</option>
               <option value="ct2">CT2</option>
               <option value="ct3">CT3</option>
               <option value="ct4">CT4</option>
              <option value="mid1">Mid1</option>
              <option value="mid2">Mid2</option>
            </select><br><br>
               
             <input type="hidden" name="selectedSubject" value="<%= request.getParameter("selectedSubject") %>"> <!-- Add this hidden field -->
            
            <input type="submit" value="Update">
        </form>
    </div>
</div>

</body>
</html>
