<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<head>
    <meta charset="UTF-8">
    <title>Status</title>
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
    <a href="chatbot.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
    <a href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Log In</a>
    <a href="logout.jsp">Log Out</a>
</header>
<%  
    String username = (String)session.getAttribute("username");
    int user_id = (int)session.getAttribute("id");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "SELECT * FROM complaint WHERE user_id = ? AND (status = ? OR status = ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    stmt.setString(2, "Unassigned");
    stmt.setString(3, "Assigned");
    rs = stmt.executeQuery();
    %>
    <div id="cases">
    <h2>Complaints being processed</h2>
    <hr>
    <%
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
            <td><%=rs.getString("id")%></td>
            <td><%=rs.getString("category")%></td>
            <td><%=rs.getString("description")%></td>
            <td><%=rs.getString("scope")%></td>
            <td><%=rs.getString("status")%></td>
        </tr>
    
    <%} while(rs.next());
    }
    else {%>
        <em>No complaints are being processed...</em>
    <%}%>

    </table>
    </div>

    <%
    sql = "SELECT * FROM complaint WHERE user_id = ? AND status = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    stmt.setString(2, "Reported");
    rs = stmt.executeQuery();
    %>
    <div id="cases">
    <h2>Complaints Reported</h2>
    <hr>
    <%
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
                <td><%=rs.getString("id")%></td>
                <td><%=rs.getString("category")%></td>
                <td><%=rs.getString("description")%></td>
                <td><%=rs.getString("scope")%></td>
                <td><%=rs.getString("status")%></td>
            </tr>
        
        <%} while(rs.next());
        }
        else {%>
            <em>No complaints from you are reported yet...</em>
        <%}%>
        
        </table>
        <form action="display_reports.jsp">
            <label>Enter Case ID no. for which you want to see the reports: </label>
            <input type="number" name="case_id">
        </form>
        </div>
<%
}%>
</body>
