<!-- 
    Purpose: This file processes the Complaint Form filled by the victim user. The details are entered in the database,
    and the complaint's case status will be initialised to "Unassigned". After processing, the user will be redirected 
    back to the "chatbot.jsp" page.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->
<%
// Retrieving session variables (user id and username)
String username = (String)session.getAttribute("username");
int user_id = (int)session.getAttribute("id");
// Retrieving complaint fields
String scope = request.getParameter("scope");
String category = request.getParameter("category");
String desc = request.getParameter("desc");

// Init variables
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Storing complaint in the database
    String sql = "INSERT INTO complaint (user_id, category, description, scope) VALUES (?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql); // Preparing statement
    stmt.setInt(1, user_id);
    stmt.setString(2, category);
    stmt.setString(3, desc);
    stmt.setString(4, scope);
    stmt.executeUpdate(); // Execute 
    response.sendRedirect("chatbot.jsp"); // Redirect user to chatbot interface
} catch (Exception e) {
    // Debugging
    e.printStackTrace();
    out.println("Complaint failed");
} finally {
    // Closing DB connections
    try { rs.close(); } catch (Exception e) { }
    try { stmt.close(); } catch (Exception e) { }
    try { conn.close(); } catch (Exception e) { }
}

%>

