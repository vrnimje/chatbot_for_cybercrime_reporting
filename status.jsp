<!-- 
    Purpose: In this page, all the complaints filed by the user will be displayed. The complaints will be categorised by
    'Currently being processed' (meaning status is "Unassigned" or "Assigned") and 'Reported' (meaning all the reports 
    relevant to the case are submitted by a law enforcement personnel). If the victim wants to see those reports, the user
    will then be redirected to the "display_reports.jsp" page, by entering the Case ID no. of that particular case. 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->

<head>
    <meta charset="UTF-8">
    <title>Status</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<%
// If user is not logged in, redirect them to Login page
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
}
else {
%>
<!-- Navbar -->
<header>
    <a href="chatbot.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
    <a href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Log In</a>
    <a href="logout.jsp">Log Out</a>
</header>
<%  
    // Get session variables (user id and username)
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

    // SQL statement to be executed
    String sql = "SELECT * FROM complaint WHERE user_id = ? AND (status = ? OR status = ?)";
    stmt = conn.prepareStatement(sql); // Preparing the query
    stmt.setInt(1, user_id);
    stmt.setString(2, "Unassigned");
    stmt.setString(3, "Assigned");
    rs = stmt.executeQuery(); // Result set
    %>
    <div id="cases">
    <h2>Complaints being processed</h2>
    <hr>
    <%
    if (rs.next()) {
    %>
    <!-- Displaying the cases currently being processed -->
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
        <!-- If rs is empty -->
        <em>No complaints are being processed...</em>
    <%}%>

    </table>
    </div>

    <%
    // SQL statement to be executed
    sql = "SELECT * FROM complaint WHERE user_id = ? AND status = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id);
    stmt.setString(2, "Reported");
    rs = stmt.executeQuery(); // Result set
    %>
    <div id="cases">
    <h2>Complaints Reported</h2>
    <hr>
    <%
    if (rs.next()) {
    %>
    <!-- Displaying the cases reported -->
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
            <!-- If rs is empty -->
            <em>No complaints from you are reported yet...</em>
        <%}%>
        
        </table>
        <!-- Form for accepting the Case ID of the case for which the user wants to access the cybercrime reports -->
        <form action="display_reports.jsp">
            <label>Enter Case ID no. for which you want to see the reports: </label>
            <input type="number" name="case_id">
        </form>
        </div>
<%
}%>
</body>
