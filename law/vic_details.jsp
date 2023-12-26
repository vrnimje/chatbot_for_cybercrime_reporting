<!-- 
    Purpose: In this page, the victim's contact details are displayed to the officer, after being 
    assigned to the particular case.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Retrieving the email and phone session variables
    String email = (String)session.getAttribute("email");
    String phone = (String)session.getAttribute("phone");
    // Destroying the above attributes
    session.removeAttribute("email");
    session.removeAttribute("phone");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Case Assigned</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
    <!-- Navbar -->
    <header>
        <a href="home.jsp"><b>Law Enforcement Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>
    <div id="details">
        <!-- Displaying the victim's email and phone no. -->
        <h3>Case assigned successfully</h3>
        Here is victim's/complainee's contact details: <br>
        Email_id: <%=(email)%> <br>
        Phone No.: <%=(phone)%> <br>
        <button id = "go-back">
            Go to Home
        </button>
    </div>
</body>
<script>
    // Go back button
    var back = document.getElementById("go-back");
    back.onclick = () => {
        window.location.href = "home.jsp";
    };
</script>