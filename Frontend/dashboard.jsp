<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Dashboard Overview"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-container">
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="includes/topbar.jsp" />

        <div class="page-body">
            <div class="cards-grid">
                <div class="card emp">
                    <div class="card-label">Total Employees</div>
                    <div class="card-value">${totalEmployees}</div>
                </div>
                <div class="card dept">
                    <div class="card-label">Total Departments</div>
                    <div class="card-value">${totalDepartments}</div>
                </div>
                <div class="card att">
                    <div class="card-label">Total Attendance Records</div>
                    <div class="card-value">${totalAttendance}</div>
                </div>
                <div class="card sal">
                    <div class="card-label">Total Salary Records</div>
                    <div class="card-value">${totalSalary}</div>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3>Welcome to the Employee Management System</h3>
                </div>
                <p style="color:#6b7280; font-size:14px; line-height:1.6;">
                    Use the sidebar to manage employees, departments, attendance and salary records.
                    All data is stored securely in the MySQL <code>employee_management</code> database
                    and accessed through Java Servlets and JDBC.
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
