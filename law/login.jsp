<!-- 
    Purpose: Registered users can Login, to access the Chatbot-like interface for reporting 
    the cybercrime that occurred against them. The username and password are then matched in the file
    "login_check.jsp" 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LE - Login</title>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>
<body>
    <header>
        <a href="home.jsp"><b>Law Enforcement Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>
    <h2>Law Enforcement Login</h2>
    <form action="login_check.jsp" method="post">
        <!-- Officer's username -->
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <!-- Officer's account password -->
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <button type="submit">Log In</button>
    <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
    <p>Do you want to file complaint? <a href="../login.jsp">Go here</a></p>
    </form>
    
</body>
</html>
