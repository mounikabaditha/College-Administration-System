<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Form</title>
</head>
<body>

    <h2>Enter Attendance Data</h2>

    <form action="process_selection.jsp" method="post">
        <label for="studentId">Student ID:</label>
        <input type="text" id="studentId" name="studentId" required><br>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br>

        <input type="submit" value="Submit">
    </form>

</body>
</html>
