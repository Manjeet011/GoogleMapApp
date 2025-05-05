<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.misha.model.SitterRegistration" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sitter Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            background-color: #f4f4f4;
            padding-top: 80px;
            padding: 20px;
            text-align: center;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 28px;
        }

        /* Table Styling */
        .table-container {
            width: 90%;
            margin: auto;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2C3E50;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .sitter-logo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        .pagination a {
            text-decoration: none;
            color: white;
            background-color: #2C3E50;
            padding: 8px 15px;
            border-radius: 5px;
            font-weight: bold;
            transition: 0.3s;
        }

        .pagination a:hover {
            background-color: #1A252F;
        }

        .pagination .active {
            background-color: #E74C3C;
            color: white;
            pointer-events: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<h2>Dog Sitter Details</h2>

<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>S.No</th>
            <th>Company Logo</th>
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Open Time</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<SitterRegistration> sitters = (List<SitterRegistration>)request.getAttribute("sittersrecords");
                int totalPages = (int)request.getAttribute("totalrecords");
                int currentPage=(int)request.getAttribute("currentpage");
            if (sitters != null && !sitters.isEmpty()) {
                int serialNumber = 1;
                for (SitterRegistration sitter : sitters) {
        %>
        <tr>
            <td><%= serialNumber++ %></td>
            <td>
                <% if (sitter.getLogo() != null) { %>
                <img src="/images/<%=sitter.getLogo()%>"
                     class="sitter-logo" alt="Sitter Logo">
                <% } else { %>
                <img src="default-logo.png" class="sitter-logo" alt="Default Logo">
                <% } %>
            </td>
            <td><%= sitter.getCompanyname() %></td>
            <td><%= sitter.getEmail() %></td>
            <td><%= sitter.getAddress() %></td>
            <td><%= sitter.getOpentime() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">No sitters found</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<%
    System.out.println(totalPages);
    System.out.println(currentPage);
%>

<div class="pagination">
<%--    &lt;%&ndash; Previous Button &ndash;%&gt;--%>
<%--    <% if (currentPage > 1) { %>--%>
<%--    <a href="showRecords?page=<%= currentPage - 1 %>">Previous</a>--%>
<%--    <% } %>--%>

    <%-- Page Numbers --%>
    <% for (int i = 1; i <= totalPages; i++) { %>
    <a href="showRecords?page=<%= i %>" class="<%= (i == currentPage)%>">
        <%= i %>
    </a>
    <% } %>

<%--    &lt;%&ndash; Next Button &ndash;%&gt;--%>
<%--    <% if (currentPage < totalPages) { %>--%>
<%--    <a href="showRecords?page=<%= currentPage + 1 %>">Next</a>--%>
<%--    <% } %>--%>
</div>


</body>
</html>
