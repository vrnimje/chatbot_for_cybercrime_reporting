<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>
<body>
    <header>
        <a href="home.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>
    <h2>Login</h2>
    <form action="login-check.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <button type="submit">Log In</button>

        <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
        <p>Are you from Law Enforcement? <a href="law/login.jsp">Login here</a></p>
    </form>
</body>
</html>
