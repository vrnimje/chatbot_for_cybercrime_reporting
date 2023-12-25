<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
}
else {
%>
<header>
    <a href="home.jsp"><b>Law Enforcement Reporting</b></a>
    <a href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Log In</a>
    <a href="logout.jsp">Log Out</a>
</header>
<div id="reports">
<%
    String username = (String)session.getAttribute("username");
    int law_id = (int)session.getAttribute("id");
    int case_id = Integer.parseInt(request.getParameter("case_id"));
    session.setAttribute("case_id", case_id);
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    int completed = 0;

    try {
        // Connect to the MySQL database
        String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "SELECT * FROM web_server_reports WHERE law_id = ? AND compl_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, law_id);
        stmt.setInt(2, case_id);
        rs = stmt.executeQuery();%>
        
        <div id="report">
            <h3>Web Server Report for Case ID: <%=case_id%></h3>
            <hr>
        <%if (!rs.next()) {
            %>
            <form action="web_server.jsp">
                <label>Port used by attacker: </label>
                <input type="number" name="port">

                <label>Vulnerable web component exploited: </label>
                <input type="text" name="vul_comp">

                <label>Additional Description: </label>
                <textarea type="text" rows="5" name="desc"></textarea>
                <br>

                <button id="send-button" type="submit">Send</button>
            </form>
        <%} else {
            completed++;
            %>
            <em>Web server report submitted!! </em>
        <%}%>
        </div>
        <%
        sql = "SELECT * FROM appln_server_reports WHERE law_id = ? AND compl_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, law_id);
        stmt.setInt(2, case_id);
        rs = stmt.executeQuery();%>
        <div id="report">
            <h3>Application Server Report for Case ID: <%=case_id%></h3>
            <hr>
        <%if (!rs.next()) {
            %>
            <form action="app_server.jsp">
                <label>Vulnerable web component exploited: </label>
                <input type="text" name="vul_comp">

                <label>Access control of attacker: </label>
                <input type="text" name="access">

                <label>Unsafe CI/CD pipelines exploited: </label>
                <input type="text" name="ci_cd">

                <label>Additional Description: </label>
                <textarea type="text" rows="5" name="desc"></textarea>
                <br>

                <button id="send-button" type="submit">Send</button>
            </form>
        <%} else {
            completed++;
            %>
            <em>Application server report submitted!! </em>
        <%}%>
        </div>
        <%
        sql = "SELECT * FROM db_server_reports WHERE law_id = ? AND compl_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, law_id);
        stmt.setInt(2, case_id);
        rs = stmt.executeQuery();%>
        <div id="report">
            <h3>Database Server Report for Case ID: <%=case_id%></h3>
            <hr>
        <%if (!rs.next()) {
            %>
            <form action="db_server.jsp">
                <label>Injected query used: </label>
                <input type="text" name="injected">

                <label>Privilege used by attacker: </label>
                <input type="text" name="priv">

                <label>Tables affected: </label>
                <input type="text" name="tables">

                <label>Operation used: </label>
                <input type="text" name="op">

                <label>Additional Description: </label>
                <textarea type="text" rows="5" name="desc"></textarea>
                <br>

                <button id="send-button" type="submit">Send</button>
            </form>
        <%} else {
            completed++;
            %>
            <em>Database server report submitted!! </em>
        <%}%>
        </div>
        </div>
        <%
        if (completed == 3) {
            sql = "UPDATE complaint SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            out.println(stmt);
            stmt.setString(1, "Reported");
            stmt.setInt(2, case_id);
            stmt.executeUpdate();
            response.sendRedirect("home.jsp");
        }
    } catch (Exception e) {
        out.println("Assignment failed" + e.getMessage());
    } finally {
        try { rs.close(); } catch (Exception e) { }
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }
}
%>
</body>