<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="java.util.List" %>
<% request.setAttribute("pageTitle", "Employee Management"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employees - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-container">
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="includes/topbar.jsp" />

        <div class="page-body">
            <div class="panel">
                <div class="panel-header">
                    <h3>Employees</h3>
                    <div style="display:flex; gap:10px; flex-wrap:wrap;">
                        <form class="search-bar" action="${pageContext.request.contextPath}/employees" method="get">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="keyword" placeholder="Search by name, email, department..." value="${keyword != null ? keyword : ''}">
                            <button type="submit" class="btn btn-sm">Search</button>
                        </form>
                        <a href="${pageContext.request.contextPath}/employees?action=add" class="btn">+ Add Employee</a>
                    </div>
                </div>

                <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Joining Date</th>
                            <th>Salary</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                        if (employees != null && !employees.isEmpty()) {
                            for (Employee e : employees) {
                    %>
                        <tr>
                            <td>#<%= e.getEmployeeId() %></td>
                            <td><%= e.getEmployeeName() %></td>
                            <td><%= e.getEmail() %></td>
                            <td><%= e.getPhone() %></td>
                            <td><%= e.getGender() %></td>
                            <td><%= e.getDepartmentName() != null ? e.getDepartmentName() : "-" %></td>
                            <td><%= e.getDesignation() %></td>
                            <td><%= e.getJoiningDate() %></td>
                            <td>₹<%= String.format("%.2f", e.getSalary()) %></td>
                            <td class="actions-cell">
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/employees?action=edit&id=<%= e.getEmployeeId() %>">Edit</a>
                                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/employees?action=delete&id=<%= e.getEmployeeId() %>"
                                   onclick="return confirmDelete('Delete this employee?');">Delete</a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="10" class="empty-state">No employees found.</td></tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
