<!-- 
    Purpose: For officers to Sign Up and Register an account with the website. The user will 
    enter their details like Username, EMail-ID, Law Enforcement division and the Password for the
    account. After that, the details will be used to create an account in the database, which are 
    processed in the file "register.jsp" 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LE - Sign Up</title>
    <link rel="stylesheet" type="text/css" href="signup-login.css">
</head>
<body>
    <header>
        <a href="home.jsp"><b>Law Enforcement Reporting</b></a>
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

        <label for="law_div">Law Division:</label>
        <input type="text" id="law_div" name="law_div" required><br><br>

        <button type="submit">Sign Up </button>

        <p>Already have an account? <a href="login.jsp">Login</a></p>
    </form>
</body>
</html>
