<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
}
else {
String username = (String)session.getAttribute("username");
int law_id = (int)session.getAttribute("id");
int case_id = Integer.parseInt(request.getParameter("case_id"));
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

    String sql = "UPDATE complaint SET law_id = ?, status = ? WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, law_id);
    stmt.setString(2, "Assigned");
    stmt.setInt(3, case_id);
    stmt.executeUpdate();

    sql = "SELECT * FROM complaint WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();
    rs.next();
    int user_id = rs.getInt("user_id");

    sql = "SELECT * FROM users WHERE id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    rs = stmt.executeQuery();
    rs.next();
    session.setAttribute("email", rs.getString("email"));
    session.setAttribute("phone", rs.getString("phone_no"));
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