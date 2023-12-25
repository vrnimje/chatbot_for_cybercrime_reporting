<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>
<body>
    <header>
        <a href="home.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>

    <h2>Sign Up</h2>
    <form action="register.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <label for="email">E-Mail:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="phone_no">Phone Number:</label>
        <input type="text" id="phone" name="phone_no" required><br><br>

        <button type="submit">Sign Up </button>

        <p>Already have an account? <a href="login.jsp">Login</a></p>
    </form>
</body>
</html>
