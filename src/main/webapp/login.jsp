<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Background with Gradient and Flower Pattern */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #ff6b6b, #6bc8c7);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        /* Flower Pattern */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"><circle cx="50" cy="50" r="40" fill="rgba(255, 255, 255, 0.1)"/><path d="M50,15 Q60,25 70,15 Q80,25 70,35 Q80,45 70,55 Q80,65 70,75 Q60,65 50,75 Q40,65 30,75 Q20,65 30,55 Q20,45 30,35 Q20,25 30,15 Q40,25 50,15" fill="rgba(255, 0, 0, 0.05)"/><path d="M50,85 Q40,75 30,85 Q20,75 30,65 Q20,55 30,45 Q20,35 30,25 Q40,35 50,25 Q60,35 70,25 Q80,35 70,45 Q80,55 70,65 Q80,75 70,85 Q60,75 50,85" fill="rgba(0, 0, 255, 0.05)"/></svg>') repeat;
            z-index: -1;
        }

        /* Login Container Styles */
        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 30px;
            background: rgba(30, 30, 30, 0.8); /* Dark semi-transparent background */
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            color: white;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 2rem;
            color: #ffffff;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.9); /* Light background for input */
            color: #333;
            font-size: 1rem;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border: 2px solid #ff6b6b; /* Focus effect */
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .error {
            color: red;
            margin-bottom: 10px;
        }

        p {
            margin-top: 15px;
            color: #f0f0f0;
        }

        /* Gradient Animation */
        @keyframes gradient {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .login-container {
                width: 90%;
                padding: 20px;
            }

            h2 {
                font-size: 1.8rem;
            }
        }

    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
        <div class="error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp" style="color: #ff6b6b;">Register here</a>.</p>
    </div>
</body>
</html>
