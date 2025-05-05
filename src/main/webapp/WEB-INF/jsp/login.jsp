<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <style>
        /* Container Styling */
        /* Global Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            /*background: linear-gradient(185deg, #06beb6, #48b1bf); !* Aqua to Blue *!*/
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Main Container */
        body > .container {
            width: auto;
            min-width: 400px;
            max-width: 450px;
            min-height: 350px;
            background: rgba(255, 255, 255, 0.2); /* Frosted glass effect */
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            backdrop-filter: blur(10px); /* Smooth blur effect */
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            transition: transform 0.3s ease-in-out;
        }

        /* Header */
        .header {
            font-size: 22px;
            font-weight: bold;
            background:#2C3E50;
            color: white;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            width: 100%;
            text-transform: uppercase;
        }

        /* Form Styling */
        .form {
            width: 100%;
        }

        /* Form Groups - Labels & Inputs */
        .form-group {
            width: 100%;
            text-align: left;
            display: flex;
            flex-direction: column;
            gap: 5px;
            margin-bottom: 15px;
        }

        /* Labels */
        .form-group label {
            font-size: 15px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        /* Input Fields */
        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid black;
            background: rgba(255, 255, 255, 0.2);

            outline: none;
            transition: 0.3s ease-in-out;
            text-align: center;
        }

        /* Input Placeholder Styling */
        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        /* Focus Effect on Inputs */
        input:focus {
            border-color: #ff6f61;
            box-shadow: 0px 0px 8px rgba(255, 111, 97, 0.8);
        }

        /* Button Styling */
        .btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            background: #2C3E50;
            color: white;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

        /* Hover & Active Button Effects */
        .btn:hover {
            background: linear-gradient(90deg, #ff9068, #ff6f61);
            transform: scale(1.05);
        }

        /* Footer */
        .footer {
            margin-top: 10px;
            font-size: 14px;
            text-align: center;
        }

        /* Footer Links */
        .footer a {
            font-weight: bold;
            color: bisque;
            text-decoration: none;
            transition: 0.3s ease-in-out;
        }

        .footer a:hover {
            text-decoration: underline;
            color: #ff6f61;
        }

    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
    <div class="header">User Login</div>
    <form action="/login" method="post">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn">Login</button>
    </form>
    <div class="footer">
        <small>Don't have an account? </small>
    </div>



</div>
</body>
</html>
