<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
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

    <div id="cases">
    <h2 id="home_labels">Unassigned Cases</h2>
    <hr>
<%
    String username = (String)session.getAttribute("username");
    int law_id = (int)session.getAttribute("id");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "SELECT * FROM complaint where status = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, "Unassigned");
    rs = stmt.executeQuery();
    if (rs.next()) {
    %>
    <table>
    <tr>
        <th>Case ID</th>
        <th>Category</th>
        <th>Description</th>
        <th>Scope</th>
        <th>Status</th>
    </tr>
    
        <%
        do {
    
        %>
            <tr>
                <td><%=rs.getInt("id")%></td>
                <td><%=rs.getString("Category")%></td>
                <td><%=rs.getString("Description")%></td>
                <td><%=rs.getString("Scope")%></td>
                <td><%=rs.getString("Status")%></td>
            </tr>
        
        <%} while(rs.next());
        %>
    </table>
    <form action="assign_case.jsp">
        <label>Enter case id no. to be assigned: </label>
        <input type="number" name="case_id">
    </form>
    <% }
        else {%>
            <h3>No Unassigned complaints available yet...</h3>
        <%}%>
    </div>
    <div id="cases">
        <h2 id="home_labels">Assigned Cases</h2>
        <hr>
        <%
        sql = "SELECT * FROM complaint where law_id = ? AND status = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, law_id);
        stmt.setString(2, "Assigned");
        rs = stmt.executeQuery();
        if (rs.next()) {
        %>
        <table>
        <tr>
            <th>Case ID</th>
            <th>Category</th>
            <th>Description</th>
            <th>Scope</th>
            <th>Status</th>
        </tr>
        <%
        do {
        %>
            <tr>
                <td><%=rs.getInt("id")%></td>
                <td><%=rs.getString("Category")%></td>
                <td><%=rs.getString("Description")%></td>
                <td><%=rs.getString("Scope")%></td>
                <td><%=rs.getString("Status")%></td>
            </tr>
        
        <%} while(rs.next());
        %>
        </table>
        <form action="unassign_case.jsp">
            <label>Enter case id no. to be unassigned: </label>
            <input type="number" name="case_id">
        </form>
        <form action="prep_reports.jsp">
            <label>Enter case id no. for generating reports: </label>
            <input type="number" name="case_id">
        </form>
        <% }
        else {%>
            <h3>No active cases yet...</h3>
        <%}
}%> 
    </div>
</body>