<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ramu Web Page</title>
    <link href="images/ramulogo.jpg" rel="icon">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            text-align: center;
            animation: scrollFont 10s linear infinite;
        }

        @keyframes scrollFont {
            0% { color: #3498db; }
            25% { color: #9b59b6; }
            50% { color: #e74c3c; }
            75% { color: #2ecc71; }
            100% { color: #3498db; }
        }

        h1, h2 {
            margin-top: 50px;
        }

        img {
            margin-top: 20px;
            width: 100px;
        }

        .highlight {
            font-size: 1.5em;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Welcome to Ramu Web Page</h1>
    <h2 class="highlight">Phone Number: 9999911111</h2>
    <br>
    <h2 class="highlight">Host Name: ramuweb</h2>
    <br>
    <h2 class="highlight">Server IP Address: 172.21.40.70</h2>
    <br>
    <img src="images/ramulogo.jpg" alt="Ramu Logo">
</body>
</html>
