<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        /* Background with Flower Effect */
        body {
            background: linear-gradient(135deg, #ff6b6b, #f7c94c, #6bc8c7, #a86ef2);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            color: #333;
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

        h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            font-family: 'Georgia', serif;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        h2 {
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 40px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        /* Form Styles */
        form {
            background-color: rgba(30, 30, 30, 0.8); /* Dark semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            max-width: 400px;
            width: 100%;
            color: #fff;
        }

        label {
            font-size: 1.1rem;
            margin-bottom: 10px;
            display: block;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
            color: #333;
            background-color: #f9f9f9;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #2980b9;
            background-color: #eef3f7;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #2980b9;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #1f618d;
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

        /* Cursive Quote Styling */
        .quote {
            position: absolute;
            top: 45%; /* Positioning higher */
            right: 20px;
            font-family: 'Brush Script MT', cursive;
            font-size: 2.5rem;
            color: #3d3d3d; /* Darker color */
            text-align: right;
            line-height: 1.4;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            form {
                padding: 20px;
                width: 90%;
            }

            h1 {
                font-size: 2.5rem;
            }

            h2 {
                font-size: 2rem;
            }

            .quote {
                font-size: 1.2rem;
            }
        }

    </style>
</head>
<body>
    <div>
        <h1>Welcome to the Colorful World!</h1>
        <h2>Customer Registration</h2>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <div class="quote">Paint the World in the Colors of your Love!</div>
    </div>
</body>
</html>
