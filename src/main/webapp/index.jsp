<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deployment Successful!</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #3a7bd5, #3a6073);
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 25px rgba(0,0,0,0.3);
            padding: 40px 60px;
            text-align: center;
            max-width: 600px;
        }
        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #00ffcc;
        }
        p {
            font-size: 1.2rem;
            margin: 10px 0;
        }
        .pipeline {
            background: rgba(255,255,255,0.15);
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            font-weight: bold;
            letter-spacing: 1px;
        }
        footer {
            margin-top: 25px;
            font-size: 0.9rem;
            color: #dcdcdc;
        }
        .success {
            color: #00ffcc;
            font-weight: bold;
            font-size: 1.3rem;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>✅ Deployment Successful!</h1>
        <p class="success">Your CI/CD pipeline works perfectly 🚀</p>
        <div class="pipeline">
            Jenkins → GitHub → Maven → Ansible → Tomcat
        </div>
        <p>This page is served from <strong>Apache Tomcat</strong>.</p>
        <p>Deployed at: <%= new java.util.Date() %></p>

        <footer>
            &copy; <%= java.time.Year.now() %> DevOps Automated Deployment
        </footer>
    </div>
</body>
</html>
