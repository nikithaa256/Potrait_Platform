<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to the Colorful World!</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body /* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Playfair Display', serif; /* Elegant and stylish serif font */
}

body {
    background: linear-gradient(135deg, #c39bd3, #d2b4de, #d7bde2, #f5eef8); /* Soft lavender gradient */
    background-size: 400% 400%;
    animation: gradient 15s ease infinite;
    color: #4a4a4a;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    text-align: center;
    position: relative;
}

h1 {
    font-size: 4rem;
    margin-bottom: 40px;
    color: #2e2e2e;
    font-weight: 700;
    letter-spacing: 3px;
    text-transform: uppercase;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Soft shadow for depth */
    font-family: 'Great Vibes', cursive; /* Creative font for the heading */
    animation: fadeIn 2s ease-in-out forwards;
}

p {
    font-size: 2.4rem;
    color: #6a6a6a;
    font-family: 'Brush Script MT', cursive; /* Stylish serif font for the paragraph */
    margin-bottom: 30px;
    letter-spacing: 1px;
}

.options {
    display: flex;
    gap: 30px;
    justify-content: center;
    margin-top: 20px;
}

.options a {
    text-decoration: none;
    background-color: #6a5acd;
    color: white;
    padding: 15px 40px;
    border-radius: 50px;
    font-size: 1.3rem;
    font-family: 'Poppins', sans-serif;
    font-weight: 600;
    transition: all 0.4s ease;
    text-transform: uppercase;
}

.options a:hover {
    background-color: #5b49b2;
    transform: scale(1.1); /* Adds a scaling effect on hover */
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

/* Fade-in animation for the heading */
@keyframes fadeIn {
    0% {
        opacity: 0;
        transform: translateY(-20px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}
        
       
    </style>
</head>
<body>
    <div class="overlay"></div> <!-- Overlay for better text visibility -->
    <div>
        <h1>Welcome to the Colorful World!</h1>
        <p>Let your creativity shine in the world of art!</p>
        <div class="options">
            <a href="register.jsp">Register</a>
            <a href="login.jsp">Login</a>
        </div>
    </div>

    <!-- Glowing Circles for aesthetic design -->
    <div class="glow-circle glow-1"></div>
    <div class="glow-circle glow-2"></div>
    <div class="glow-circle glow-3"></div>
    <div class="glow-circle glow-4"></div>
       
</body>
</html>
