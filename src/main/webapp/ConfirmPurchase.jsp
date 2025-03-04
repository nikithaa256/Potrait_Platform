<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String confirmationMessage = (String) request.getAttribute("confirmationMessage");
    Integer customerId = (Integer) request.getAttribute("customerId"); // Assuming you keep it as Integer
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Purchase Confirmation</title>
    <link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet"> <!-- Import cursive font -->
    <style>
        body {
            background: linear-gradient(135deg, #f8d3e1, #f6b0c0); /* Light pink gradient */
            display: flex;
            flex-direction: column; /* Stack elements vertically */
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            color: #333; /* Text color */
            font-family: 'Arial', sans-serif;
            text-align: center; /* Center align text */
            margin: 0; /* Remove default margin */
        }

        .logout-button {
            margin: 20px; /* Spacing for the logout button */
            align-self: flex-end; /* Align to the right */
            background-color: #ff6f91; /* Button color */
            color: white; /* Text color */
            border: none; /* No border */
            border-radius: 5px; /* Rounded corners */
            padding: 10px 15px; /* Padding for button */
            cursor: pointer; /* Pointer cursor */
            transition: background-color 0.3s; /* Smooth transition */
        }

        .logout-button:hover {
            background-color: #ff4c76; /* Darker shade on hover */
        }

        .container {
            background-color: white; /* White background for content */
            padding: 40px;
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Shadow effect */
            width: 80%; /* Responsive width */
            max-width: 600px; /* Max width for larger screens */
        }

        h1 {
            font-size: 2.5rem; /* Larger font size */
            margin-bottom: 20px; /* Spacing below heading */
            color: #d94a77; /* Accent color for heading */
        }

        p {
            font-size: 1.2rem; /* Caption font size */
            margin: 10px 0; /* Spacing for caption */
            color: #555; /* Darker text for caption */
        }

        .cursive-caption {
            font-family: 'Brush Script MT', cursive; /* Cursive font */
            font-size: 1.5rem; /* Slightly larger font size */
            color: #000000; /* Pink color for the caption */
            margin: 10px 0; /* Margin for spacing */
        }

        a {
            display: inline-block; /* Block element for button */
            margin-top: 20px; /* Space above the link */
            padding: 10px 20px; /* Padding for the link */
            background-color: #ff6f91; /* Button color */
            color: white; /* Text color */
            text-decoration: none; /* Remove underline */
            border-radius: 5px; /* Rounded corners */
            font-weight: bold; /* Bold text */
            transition: background-color 0.3s; /* Smooth transition */
        }

        a:hover {
            background-color: #ff4c76; /* Darker shade on hover */
        }
    </style>
</head>
<body>
    <form action="login.jsp">
        <button type="submit" class="logout-button">Logout</button>
    </form>
    <div class="container">
        <h1><%= confirmationMessage != null ? confirmationMessage : "Confirmation message not available." %></h1>
        <p>We will reach out to you soon!</p> <!-- Caption -->
        <p class="cursive-caption">The more you paint, the more you will realize how beautiful the World is!</p> <!-- New Caption -->
        <a href='gallery.jsp?customer_id=<%= customerId != null ? customerId.toString() : "0" %>'>Add Products</a> <!-- Link to gallery.jsp with customer_id -->
    </div>
</body>
</html>
