<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.*"%>
<head>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String law_div = request.getParameter("law_div");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Connect to the MySQL database (update the connection details)
        String url = "jdbc:mysql://localhost:3306/cybercrime_chatbot";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Insert user data into the 'users' table
        byte[] password_in_bytes = password.getBytes("UTF-8");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] theMD5digest = md.digest(password_in_bytes);
        String hashed_pass = new String(theMD5digest);

        String sql = "INSERT INTO law_officer (username, password, email_id, law_division) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, hashed_pass);
        stmt.setString(3, email);
        stmt.setString(4, law_div);
        stmt.executeUpdate();

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        out.println("Registration failed." + e.getMessage());
    } finally {
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }
%>
