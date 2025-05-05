<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.misha.model.SitterRegistration" %>
<%@ page import="com.misha.service.MyUserDetails" %>

<%
    MyUserDetails sitterregistration = (MyUserDetails) request.getAttribute("loggedInUser");
    if (sitterregistration == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if user is null
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        /* General Styles */
        body {
            background-color: #f4f6f9;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            color: #333;
            padding-top: 80px; /* Prevent overlap with navbar */
        }

        /* Navbar */
        nav {
            height: 80px;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            background-color: #343a40;
            z-index: 1000;
        }

        /* Main Container */
        .container {
            max-width: 100%;
            height: auto;
            margin: 0 auto;
            gap: 20px;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        /* Header Section */
        .profile-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            text-align: center;
        }

        .profile-header img.sitter-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
        }

        /* Tabs */
        .nav-tabs {
            display: flex;
            justify-content: center;
            border-bottom: none;
            margin-bottom: 20px;
        }

        .nav-tabs .nav-link {
            font-weight: 600;
            color: #555;
            border-radius: 6px;
            transition: all 0.3s ease-in-out;
            padding: 10px;
            background: #e9ecef;
        }

        .nav-tabs .nav-link.active {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: #fff;
        }

        /* Card Styles */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
            margin-bottom: 20px;
            padding: 15px;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .card-title {
            color: #007bff;
            font-weight: bold;
        }

        /* Form Section */
        .divlag {
            max-width: 100%;
            max-height: calc(100vh - 150px);
            overflow: auto;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        .form-control {
            max-width: 100%;
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }

        /* Buttons */
        .btn-primary {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            transition: all 0.3s ease-in-out;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #0056b3, #004089);
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">

    <div class="profile-header">
        <h2>User Profile</h2>
        <img src="/images/<%=sitterregistration.getLogo()%>" class="sitter-logo" alt="Sitter Logo">
    </div>

    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs" id="profileTabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#viewProfile">View Profile</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#editProfile">Edit Profile</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <!-- View Profile Tab -->
        <div class="tab-pane fade show active" id="viewProfile">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Profile Details</h4>
                    <p><strong>Username (Email):</strong> <%= (sitterregistration != null) ? sitterregistration.getUsername() : "N/A" %></p>
                    <p><strong>Password:</strong> ********</p>
                    <p><strong>Role:</strong> <%= (sitterregistration != null) ? sitterregistration.getAuthorities() : "N/A" %></p>
                </div>
            </div>
        </div>

        <!-- Edit Profile Tab -->
        <div class="tab-pane fade" id="editProfile">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Edit Profile</h4>

                    <%-- Success & Error Messages --%>
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                    <% } %>

                    <div class="divlag">
                        <form action="updateProfile" method="POST">
                            <div class="mb-3">
                                <label class="form-label">Username (Email)</label>
                                <input type="email" class="form-control" name="email"
                                       value="<%= (sitterregistration != null) ? sitterregistration.getUsername() : "" %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Current Password</label>
                                <input type="password" class="form-control" name="currentPassword" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input type="password" class="form-control" name="newPassword" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
