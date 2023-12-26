<!-- 
    Purpose: The session variables pertaining to the officer will be destroyed, after having clicked the Logout button in
    the navigation bar.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>