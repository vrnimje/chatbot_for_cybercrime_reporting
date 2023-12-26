<!-- 
    Purpose: In this page, the officers will be unassigned to the case, for which they entered the Case ID.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->

<%
// If officer is not logged in, redirect them to LE-Login
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
}
else {
// Retrieve the username and id of the officer
String username = (String)session.getAttribute("username");
int law_id = (int)session.getAttribute("id");
// Retrieve the case_id entered in the assignment form
int case_id = Integer.parseInt(request.getParameter("case_id"));
// Init
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String email, phone;

try {
    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Unassign the case
    String sql = "UPDATE complaint SET law_id = ?, status = ? WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setNull(1, Types.NULL);
    stmt.setString(2, "Unassigned");
    stmt.setInt(3, case_id);
    stmt.executeUpdate();
    response.sendRedirect("home.jsp");

} catch (Exception e) {
    // Debugging
    out.println("Assignment failed" + e.getMessage());
} finally {
    // Close DB Connections
    try { rs.close(); } catch (Exception e) { }
    try { stmt.close(); } catch (Exception e) { }
    try { conn.close(); } catch (Exception e) { }
}
}
%>