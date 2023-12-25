<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");
int user_id = (int)session.getAttribute("id");
String scope = request.getParameter("scope");
String category = request.getParameter("category");
String desc = request.getParameter("desc");

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

    String sql = "INSERT INTO complaint (user_id, category, description, scope) VALUES (?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    stmt.setString(2, category);
    stmt.setString(3, desc);
    stmt.setString(4, scope);
    stmt.executeUpdate();
    response.sendRedirect("chatbot.jsp");
} catch (Exception e) {
    e.printStackTrace();
    out.println("Complaint failed");
} finally {
    try { rs.close(); } catch (Exception e) { }
    try { stmt.close(); } catch (Exception e) { }
    try { conn.close(); } catch (Exception e) { }
}

%>

