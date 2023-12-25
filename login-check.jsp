<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.*"%>

<head>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

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
        
        byte[] password_in_bytes = password.getBytes("UTF-8");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] theMD5digest = md.digest(password_in_bytes);
        String hashed_pass = new String(theMD5digest);

        // Check if the username and password match
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, hashed_pass);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Successful login
            session.setAttribute("username", username);
            session.setAttribute("id", rs.getInt("id"));
            response.sendRedirect("chatbot.jsp");
        } else {
            // Failed login
            out.println("Invalid login credentials. Please try again.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Login failed. Please try again.");
    } finally {
        try { rs.close(); } catch (Exception e) { }
        try { stmt.close(); } catch (Exception e) { }
        try { conn.close(); } catch (Exception e) { }
    }
%>
