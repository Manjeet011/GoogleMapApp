<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dog Sitter App</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Reset default margins and paddings */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        /* Ensures the page covers full screen without exceeding viewport */
        html, body {
            width: 100%;
            min-height: 100vh;
            overflow-x: hidden; /* Prevents horizontal scroll */
        }

        /* Navbar styling */
        nav {
            background-color: #2C3E50; /* Deep navy blue */
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            font-size: 20px;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 40px;
        }

        nav ul li {
            display: inline;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            padding: 12px 20px;
            transition: background 0.3s, border-radius 0.3s;
        }

        nav ul li a:hover,
        nav ul li a.active {
            background-color: #F39C12; /* Gold accent */
            border-radius: 8px;
        }

        /* Main content styling */
        body {
            background-color: #FAF3E0; /* Light beige background */
            padding-top: 80px; /* Prevent overlap with navbar */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        /* Center content */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            width: 100%;
            min-height: calc(100vh - 80px); /* Ensures it fits screen without overflow */
        }

        /* Welcome section */
        section {
            background: white;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 50%;
        }

        /* Heading */
        #welcome h1 {
            font-size: 42px;
            color: #2C3E50; /* Matching the navbar */
            margin-bottom: 10px;
        }

        #welcome p {
            font-size: 18px;
            color: #555;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                padding: 100px 20px;
            }

            section {
                width: 90%;
            }

            nav ul {
                gap: 15px;
            }

            nav ul li a {
                font-size: 16px;
                padding: 10px 14px;
            }
        }

    </style>

</head>
<body>

<%@ include file="navbar.jsp" %>
<div class="container">
    <section id="welcome">
        <h1>Welcome to Misha Infotech</h1>
        <p>Your one-stop solution for Dog Sitter services.</p>
    </section>
</div>

</body>
</html>