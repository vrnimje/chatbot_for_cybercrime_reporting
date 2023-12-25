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
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
    %>
    <header>
        <a href="chatbot.jsp"><b>Chatbot for Cybercrime Reporting</b></a>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Log In</a>
        <a href="logout.jsp">Log Out</a>
    </header>

    <div class="container">
        <div class="chat-container">
            <div id="chat-box">
                <div id="bot-message">
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

                if (message == "file complaint") {
                    const responseElement = document.createElement("div");
                    const formElement = document.createElement("form");
                    const heading = document.createElement("h3");
                    heading.textContent = "File Complaint";
                    formElement.appendChild(heading);
                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("input");
                    labelElement.textContent = "Category: ";
                    inputElement.name = "category"
                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("input");
                    labelElement.textContent = "Scope: ";
                    inputElement.name = "scope"
                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

                    var labelElement = document.createElement("label");
                    var inputElement = document.createElement("textarea");
                    labelElement.innerHTML = "Description:<br> (in less than 200 characters)";
                    inputElement.name = "desc"
                    inputElement.rows = "10"

                    formElement.appendChild(labelElement);
                    formElement.appendChild(inputElement);

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
                else if (message == "status") {
                    const responseElement = document.createElement("div");

                    const heading = document.createElement("p");
                    heading.textContent = "Click the button below to check the status of complaints filed by you";
                    responseElement.appendChild(heading);

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
                else if (message == "query") {
                    const responseElement = document.createElement("div");

                    responseElement.innerHTML = "<ul>"
                                                + "<li><b>Identity theft: </b> When someone steals your identity, and accesses your resources, " 
                                         + "like credit cards, bank accounts, etc..</li>"
                                                + "<li><b>Cyber terrorism:</b> Involves damaging large scale networks, to achieve loss of data and even life.</li>"
                                                + "<li><b>Phishing:</b> Activity of fraudulently preseting oneself as a legitimate enterprise"
                                                + " in order to trick consumers</li>"
                                                + "<li><b>Scope:</b> The type of victim that was affected; Can be Individual, Organisational or Governmental</li>"
                                                + "</ul>";

                    responseElement.id = "bot-message"

                    // Append the new element to the chat-box div
                    const chatBox = document.getElementById("chat-box");
                    chatBox.appendChild(responseElement);
                }
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
