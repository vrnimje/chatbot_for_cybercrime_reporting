<!-- 
    Purpose: The username and password entered by the user in "login.jsp" page are checked here, making
    sure that the username and password matches with the one stored in database. Then, the session 
    variables are set for the user, for further processing. The user, after successful login, is 
    redirected to the "chatbot.jsp" page
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->
<%@ page import="java.security.*"%> <!-- Java security libraries, for hashing the passowrd -->
<head>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>

<%
    // Fetch the Login form's data (username and password)
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Variable initialisation
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Connect to the MySQL database (update the connection details)
        String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Generate MD5 hash of the password
        byte[] password_in_bytes = password.getBytes("UTF-8");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] theMD5digest = md.digest(password_in_bytes);
        String hashed_pass = new String(theMD5digest);

        // Check if the username and password match
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql); // Preparing statement
        stmt.setString(1, username);
        stmt.setString(2, hashed_pass);
        rs = stmt.executeQuery(); // Result set generated from the query

        if (rs.next()) {
            // Successful login - set user session variables
            session.setAttribute("username", username);
            session.setAttribute("id", rs.getInt("id"));
            response.sendRedirect("chatbot.jsp");
        } else {
            // Failed login
            out.println("Invalid login credentials. Please try again.");
        }
    } catch (Exception e) {
        // Debugging
        e.printStackTrace();
        out.println("Login failed. Please try again.");
    } finally {
        // Close database connections
        try { rs.close(); } catch (Exception e) { }
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }
%>
