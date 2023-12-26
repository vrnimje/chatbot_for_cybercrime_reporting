<!-- 
    Purpose: This page is used for handling the various queries and inputs from the user. There are 3 commands through
    which the user can interact:
    1. file complaint: User can file a cybercrime complaint, which specifies the category of cybercrime (whether it is
       phishing, cyber-fraud etc..), scope of cybercrime (Individual, Organisational or Governmental). The details entered 
       will then be processed by "file_complaint.jsp".
    2. query: This command is used when the user may not have an idea of what the terms involved in the above form mean.
    3. status: This command will show a button, which on clicked, will redirect the users to the "status.jsp" page, where
       they can see the status of all cyber-complaints filed by them 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chatbot for Cybercrime Reporting</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <%
    // If user is not logged in, redirect them to Login page
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
    %>
    <!-- Navigation bar -->
    <header>
        <a href="chatbot.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>

    <div class="container">
        <div class="chat-container">
            <!-- Chat box container -->
            <div id="chat-box">
                <div id="bot-message">
                    <!-- Welcome message -->
                    Welcome, <%= session.getAttribute("username") %>! <br>
                    These are the commands you can use to interact with me: <br>
                    1. <b>file complaint</b>: To file complaint for cyber crime <br>
                    2. <b>query</b>: To get information about various cyber crimes <br>
                    3. <b>status</b>: To check on the status of the complaints filed by you <br>
                </div>
            </div>
            <form id="user-input">
                <input type="text" id="user-message-input" name="user-message" placeholder="Type your message...">
                <button id="send-button" type="submit">Send</button>
            </form>
        </div>
    </div>

    <script>
        // Get the form and input field
        const form = document.getElementById("user-input");
        const input = document.getElementById("user-message-input");

        // Add event listener to the form
        form.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission

            // Get the value of the input field
            if (input.value !== "") {
                const message = input.value;

                // Create a new element to display the message
                const messageElement = document.createElement("div");
                messageElement.textContent = message;
                messageElement.id = "user-message"

                // Append the new element to the chat-box div
                const chatBox = document.getElementById("chat-box");
                chatBox.appendChild(messageElement);

                // Clear the input field
                input.value = "";

                // If command used is "file complaint"
                if (message == "file complaint") {
                    const responseElement = document.createElement("div");
                    // Creating form for getting user's cybercrime complaint
                    const formElement = document.createElement("form");
                    const heading = document.createElement("h3");
                    heading.textContent = "File Complaint";
                    formElement.appendChild(heading);

                    // Category of cybercrime
                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("input");
                    labelElement.textContent = "Category: ";
                    inputElement.name = "category"
                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

                    // Scope of cybercrime
                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("input");
                    labelElement.textContent = "Scope: ";
                    inputElement.name = "scope"
                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

                    // Description of the cybercrime 
                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("textarea");
                    labelElement.innerHTML = "Description:<br> (in less than 200 characters)";
                    inputElement.name = "desc"
                    inputElement.rows = "10"

                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

                    // Submit button
                    var inputElement = document.createElement("button");
                    inputElement.textContent = "Submit";
                    inputElement.type = "submit"
                    formElement.appendChild(inputElement);
                    formElement.action="file_complaint.jsp";

                    responseElement.appendChild(formElement);
                    responseElement.id = "bot-message"

                    // Append the new element to the chat-box div
                    const chatBox = document.getElementById("chat-box");
                    chatBox.appendChild(responseElement);
                } 
                // If command used is "status"
                else if (message == "status") {
                    const responseElement = document.createElement("div");

                    const heading = document.createElement("p");
                    heading.textContent = "Click the button below to check the status of complaints filed by you";
                    responseElement.appendChild(heading);

                    // Button to redirect users to Status page
                    var redirectButton = document.createElement("button");
                    redirectButton.textContent = "Go";
                    redirectButton.onclick = () => {window.location.href = "status.jsp";}
                    redirectButton.id = "send-button"

                    responseElement.appendChild(redirectButton);
                    responseElement.id = "bot-message"

                    // Append the new element to the chat-box div
                    const chatBox = document.getElementById("chat-box");
                    chatBox.appendChild(responseElement);
                }
                // If command used is "query"
                else if (message == "query") {
                    const responseElement = document.createElement("div");
                    // Informational text for educating users about various cybercimes
                    responseElement.innerHTML = "<ul>"
                                                + "<li><b>Identity theft: </b> When someone steals your identity, and accesses your resources, " 
                                                + "like credit cards, bank accounts, etc..</li>"
                                                + "<li><b>Cyber terrorism:</b> Involves damaging large scale networks, to achieve loss of data and even life.</li>"
                                                + "<li><b>Phishing:</b> Activity of fraudulently preseting oneself as a legitimate enterprise"
                                                + " in order to trick consumers</li>"
                                                + "<li><b>Threatning:</b> Sending threatning mails and messages via social media</li>"
                                                + "<li><b>Web Jacking:</b> Hacker takes control of a website fraudulently and may change its content</li>"
                                                + "<li><b>Spoofing:</b> Hiding source of attack by using one's fake identity</li>"
                                                + "<li><b>Scope:</b> The type of victim that was affected; Can be Individual, Organisational or Governmental</li>"
                                                + "</ul>";

                    responseElement.id = "bot-message"

                    // Append the new element to the chat-box div
                    const chatBox = document.getElementById("chat-box");
                    chatBox.appendChild(responseElement);
                }
                // Default case message
                else {
                    const responseElement = document.createElement("div");
                    responseElement.innerHTML = "How can I help you?";
                    responseElement.id = "bot-message"
                    const chatBox = document.getElementById("chat-box");
                    chatBox.appendChild(responseElement);
                }
            }  
        });
    </script>
</body>
</html>
