<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String email = (String)session.getAttribute("email");
    String phone = (String)session.getAttribute("phone");
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
    <header>
        <a href="home.jsp"><b>Law Enforcement Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>
    <div id="details">
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
    var back = document.getElementById("go-back");
    back.onclick = () => {
        window.location.href = "home.jsp";
    };
</script>