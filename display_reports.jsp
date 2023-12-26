<!-- 
    Purpose: In this page, the Web server report, Application server report and the Database server report, pertaining to 
    the Case ID entered in the "status.jsp" page. All the reports are displayed in a tabular format.  
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->
<head>
    <meta charset="UTF-8">
    <title>Reports for Case no. <%=request.getParameter("case_id")%></title>
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
    <header>
    <a href="chatbot.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
    <a href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Log In</a>
    <a href="logout.jsp">Log Out</a>
</header>
<%  
    try {
    // Retrieve the user session variables 
    String username = (String)session.getAttribute("username");
    int user_id = (int)session.getAttribute("id");
    // Retrieve case for which the reports are to be displayed
    int case_id = Integer.parseInt(request.getParameter("case_id"));
    // Init
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "SELECT law_officer.username AS law_name, law_officer.email_id AS law_email,"
                + " category, law_division, description "
                + "FROM complaint INNER JOIN law_officer ON complaint.law_id = law_officer.id WHERE complaint.id = ?";

    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();
    rs.next();

    %>
    <div id="cases">
    <h2>Case ID: <%=case_id%></h2>
    <p>
        <!-- Overview of complaint filed by user, and name of the law officer that created the reports -->
        Case reports prepared by: <%=rs.getString("law_name")%> (email: <%=rs.getString("law_email")%>), <%=rs.getString("law_division")%> <br>
        Category: <%=rs.getString("category")%> <br>
        Description: <%=rs.getString("description")%> <br>
    </p>
    
    <%
    // Retrieve the web server report pertaining to the complaint
    sql = "SELECT * from web_server_reports WHERE compl_id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();

    rs.next();
    %>
    <!-- Display the Web server report in tabular details -->
    <h2>Web Server Report</h2>
    <hr>
    <table>
        <tr>
            <th>Web Report ID</th>
            <th>Port used</th>
            <th>Vulnerable component exploited</th>
            <th>Additonal Description</th>
        </tr>
    </div>

    <tr>
        <td><%=rs.getString("id")%></td>
        <td><%=rs.getInt("port_used")%></td>
        <td><%=rs.getString("vulnerable_component")%></td>
        <td><%=rs.getString("description")%></td>
    </tr>

    </table>

    <%
    // Retrieve the Application server report pertaining to the complaint
    sql = "SELECT * from appln_server_reports WHERE compl_id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();
    rs.next();
    %>
    <!-- Display the Application server report in tabular details -->
    <h2>Application Server Report</h2>
    <hr>
    <table>
        <tr>
            <th>Appln Report ID</th>
            <th>Vulnerable component exploited</th>
            <th>Access control used by attacker</th>
            <th>Unsafe CI/CD pipelines exploited</th>
            <th>Additonal Description</th>
        </tr>
    </div>

    <tr>
        <td><%=rs.getString("id")%></td>
        <td><%=rs.getString("vulnerable_component")%></td>
        <td><%=rs.getString("access_control_used")%></td>
        <td><%=rs.getString("unsafe_ci_cd")%></td>
        <td><%=rs.getString("description")%></td>
    </tr>

    </table>
    
    <%
    // Retrieve the Database server report pertaining to the complaint
    sql = "SELECT * from db_server_reports WHERE compl_id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, case_id);
    rs = stmt.executeQuery();
    rs.next();
    %>
    <!-- Display the Database server report in tabular details -->
    <h2>Database Server Report</h2>
    <hr>
    <table>
        <tr>
            <th>DB Report ID</th>
            <th>Injected hostile data used</th>
            <th>Privilege used</th>
            <th>Tables affected</th>
            <th>Operation used</th>
            <th>Additonal Description</th>
        </tr>
    </div>
    
    <tr>
        <td><%=rs.getString("id")%></td>
        <td><%=rs.getString("injected_hostile_data")%></td>
        <td><%=rs.getString("privilege_used")%></td>
        <td><%=rs.getString("tables_affected")%></td>
        <td><%=rs.getString("operation_used")%></td>
        <td><%=rs.getString("description")%></td>
    </tr>

    </table>

    <%
    } catch (Exception e) {
        out.println("Assignment failed" + e.getMessage());
    }
}
%>
</body>