<!-- 
    Purpose: In this file, the database server report is stored in the database.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->

<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
}
else {
    String username = (String)session.getAttribute("username");
    int law_id = (int)session.getAttribute("id");
    int case_id = (int)session.getAttribute("case_id");
    String injected = request.getParameter("injected");
    String priv = request.getParameter("priv");
    String tables = request.getParameter("tables");
    String op = request.getParameter("op");
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

        String sql = "INSERT INTO db_server_reports (law_id, compl_id, injected_hostile_data, privilege_used, tables_affected, operation_used, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, law_id);
        stmt.setInt(2, case_id);
        stmt.setString(3, injected);
        stmt.setString(4, priv);
        stmt.setString(5, tables);
        stmt.setString(6, op);
        stmt.setString(7, desc);
        stmt.executeUpdate();

        response.sendRedirect("prep_reports.jsp?case_id=" + case_id);
        session.removeAttribute("case_id");
    } catch (Exception e) {
        out.println("Assignment failed" + e.getMessage());
    } finally {
        try { rs.close(); } catch (Exception e) { }
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }

}

%>