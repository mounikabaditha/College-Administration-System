<%@ page import="java.sql.*" %>

<%
try {
    // Get the form data
    Class.forName("com.mysql.jdbc.Driver");
    String regulation = request.getParameter("regulation");
    String AcademicYear = request.getParameter("AcademicYear");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));
    int semester = Integer.parseInt(request.getParameter("semester"));
    int num_subjects = Integer.parseInt(request.getParameter("num_subjects"));

    // Create a connection to the database
    String url = "jdbc:mysql://localhost:3306/student";
    String user = "root";
    String password = "system@123";
    Connection conn = DriverManager.getConnection(url, user, password);

    // Create a PreparedStatement to insert the regulation data
    String regulationSql = "INSERT INTO regulation1(regulation, branch, year, semester, subject_name,AcademicYear) VALUES (?,?, ?, ?, ?, ?)";
    PreparedStatement regulationStmt = conn.prepareStatement(regulationSql);

    for (int i = 1; i <= num_subjects; i++) {
        String subject_name = request.getParameter("subject" + i + "_name");
        String subjectCode = regulation + year + semester + branch + i;

        // Check if the table already exists
        boolean tableExists = false;
        DatabaseMetaData meta = conn.getMetaData();
        ResultSet tables = meta.getTables(null, null, subjectCode, null);
        if (tables.next()) {
            // Table exists
            tableExists = true;
        }
        tables.close();

        if (!tableExists) {
            // Create a table for the subject if it does not exist
            String createTableSql = "CREATE TABLE " + subjectCode + " (" +
                "student_registration VARCHAR(10), " +
                "subject_code VARCHAR(10), " +
                "branch VARCHAR(10), " +
                "year INT, " +
                "semester INT, " +
                "internal_marks INT, " +
                "external_marks INT)";
            PreparedStatement createTableStmt = conn.prepareStatement(createTableSql);
            createTableStmt.executeUpdate();
            createTableStmt.close();
        }

        // Insert the regulation data
        regulationStmt.setString(1, regulation);
        regulationStmt.setString(2, branch);
        regulationStmt.setInt(3, year);
        regulationStmt.setInt(4, semester);
        regulationStmt.setString(5, subject_name);
        regulationStmt.setString(6, AcademicYear);
        regulationStmt.executeUpdate();

        // Prepare and execute the insert statement for the subject
        String insertSql = "INSERT INTO " + subjectCode + " (student_registration, subject_code, branch, year, semester, internal_marks, external_marks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertSql);
        insertStmt.setString(1, ""); // Replace with the actual student registration number
        insertStmt.setString(2, subjectCode);
        insertStmt.setString(3, branch);
        insertStmt.setInt(4, year);
        insertStmt.setInt(5, semester);
        insertStmt.setInt(6, 0); // Replace with the actual internal marks
        insertStmt.setInt(7, 0); // Replace with the actual external marks
        insertStmt.executeUpdate();
        insertStmt.close();
%>

<form action="sub.jsp" method="post">
    <input type="hidden" name="subjectCode" value="<%=subjectCode%>">
    <input type="hidden" name="year" value="<%=year%>">
    <input type="hidden" name="semester" value="<%=semester%>">
    <input type="hidden" name="branch" value="<%=branch%>">
    <h2>Subject: <%=subject_name%></h2>
    <label>Student Registration:</label>
    <input type="text" name="student_registration">
    <label>Internal Marks:</label>
    <input type="text" name="internal_marks">
    <label>External Marks:</label>
    <input type="text" name="external_marks">
    <input type="submit" value="Submit">
</form>

<%
    }
    // Close the connection and statements
    regulationStmt.close();
    conn.close();
} catch (Exception e){
    out.println("An error occurred: " + e.getMessage());
    e.printStackTrace();
}
%>
