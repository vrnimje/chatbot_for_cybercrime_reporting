<!-- 
    Purpose: This file obtains the details, filled by the user, in the "signup.jsp" page, and 
    then enters them into the database 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- Java DataBase Connectivity, for MySQL database access -->
<%@ page import="java.security.*"%> <!-- Java security libraries, for hashing the passowrd -->
<head>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>

<%
    // Fetch the Sign Up form's data (username, password, email and phone no.)
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone_no = request.getParameter("phone_no");

    // Variable initialisation
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Connect to the MySQL database (update the connection details)
        String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        // SQL Database Connection driver
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Generate MD5 hash of the password
        byte[] password_in_bytes = password.getBytes("UTF-8");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] theMD5digest = md.digest(password_in_bytes);
        String hashed_pass = new String(theMD5digest);

        // Insert user data into the 'users' table
        String sql = "INSERT INTO users (username, password, email, phone_no) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql); // Preparing statement
        stmt.setString(1, username); 
        stmt.setString(2, hashed_pass);
        stmt.setString(3, email);
        stmt.setString(4, phone_no);
        stmt.executeUpdate();

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        // Debugging, in case of error
        e.printStackTrace();
        out.println("Registration failed. -- " + e.getMessage())
    } finally {
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }
%>
