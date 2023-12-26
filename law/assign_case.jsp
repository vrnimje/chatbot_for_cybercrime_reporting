<!-- 
    Purpose: In this page, the officers will be assigned to the case, for which they entered the Case ID.
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

    // Assign the case, by updating the table
    String sql = "UPDATE complaint SET law_id = ?, status = ? WHERE id = ?";
    stmt = conn.prepareStatement(sql); // Prepping the stmt
    stmt.setInt(1, law_id);
    stmt.setString(2, "Assigned");
    stmt.setInt(3, case_id);
    stmt.executeUpdate();

    // Retrieve victim's email and phone 
    sql = "SELECT * FROM complaint WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();
    rs.next(); // result set
    int user_id = rs.getInt("user_id");

    sql = "SELECT * FROM users WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    rs = stmt.executeQuery();
    rs.next();
    // Storing the victim's email and phone no.
    session.setAttribute("email", rs.getString("email"));
    session.setAttribute("phone", rs.getString("phone_no"));
    // Redirecting to victim details page
    response.sendRedirect("vic_details.jsp");

} catch (Exception e) {
    out.println("Assignment failed" + e.getMessage());
} finally {
    try { rs.close(); } catch (Exception e) { }
    try { stmt.close(); } catch (Exception e) { }
    try { conn.close(); } catch (Exception e) { }
}
}
%>