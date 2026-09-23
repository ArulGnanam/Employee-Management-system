<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentPage = request.getServletPath();
%>
<div class="sidebar">
    <div class="brand">EMS<span>.</span> Admin</div>
    <nav>
        <a href="${pageContext.request.contextPath}/dashboard" class="<%= currentPage.contains("dashboard") ? "active" : "" %>">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/employees" class="<%= currentPage.contains("employee") ? "active" : "" %>">👥 Employees</a>
        <a href="${pageContext.request.contextPath}/departments" class="<%= currentPage.contains("department") ? "active" : "" %>">🏢 Departments</a>
        <a href="${pageContext.request.contextPath}/attendance" class="<%= currentPage.contains("attendance") ? "active" : "" %>">🗓️ Attendance</a>
        <a href="${pageContext.request.contextPath}/salary" class="<%= currentPage.contains("salary") ? "active" : "" %>">💰 Salary</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </nav>
</div>
