<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Details</title>
</head>
<body>

    <h2>Attendance Details</h2>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String studentId = request.getParameter("studentId");
            String date = request.getParameter("date");

            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/student"); // Specify your data source

                try (Connection conn = ds.getConnection()) {
                    String query = "SELECT * FROM attendance_data WHERE studentId = ? AND date = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                        pstmt.setString(1, studentId);
                        pstmt.setString(2, date);

                        try (ResultSet rs = pstmt.executeQuery()) {
                            while (rs.next()) {
                                out.println("<p>Student ID: " + rs.getString("studentId") + "</p>");
                                out.println("<p>Subject: " + rs.getString("subject") + "</p>");
                                out.println("<p>Regulation: " + rs.getString("regulation") + "</p>");
                                out.println("<p>Academic Year: " + rs.getString("AcademicYear") + "</p>");
                                out.println("<p>Branch: " + rs.getString("branch") + "</p>");
                                out.println("<p>Year: " + rs.getInt("year") + "</p>");
                                out.println("<p>Semester: " + rs.getInt("semester") + "</p>");
                                out.println("<p>Section: " + rs.getString("section") + "</p>");
                                out.println("<p>Attendance: " + rs.getInt("attendance") + "</p>");
                                out.println("<p>Date: " + rs.getString("date") + "</p>");
                                out.println("<p>Month: " + rs.getString("month") + "</p>");
                                out.println("<p>Period: " + rs.getString("period") + "</p>");
                                // Add more fields as needed
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>An error occurred while processing your request.</p>");
            }
        }
    %>

</body>
</html>
