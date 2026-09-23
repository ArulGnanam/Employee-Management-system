<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Attendance" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="java.util.List" %>
<%
    request.setAttribute("pageTitle", "Attendance Management");
    Attendance editAtt = (Attendance) request.getAttribute("attendance");
    List<Employee> empList = (List<Employee>) request.getAttribute("employees");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Employee Management System</title>
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
                    <h3><%= editAtt != null ? "Edit Attendance" : "Mark Attendance" %></h3>
                </div>
                <form action="${pageContext.request.contextPath}/attendance" method="post">
                    <input type="hidden" name="action" value="<%= editAtt != null ? "update" : "add" %>">
                    <% if (editAtt != null) { %>
                        <input type="hidden" name="attendanceId" value="<%= editAtt.getAttendanceId() %>">
                    <% } %>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Employee</label>
                            <select name="employeeId" required>
                                <option value="">-- Select Employee --</option>
                                <% if (empList != null) { for (Employee e : empList) { %>
                                <option value="<%= e.getEmployeeId() %>"
                                    <%= (editAtt != null && editAtt.getEmployeeId() == e.getEmployeeId()) ? "selected" : "" %>>
                                    <%= e.getEmployeeName() %> (#<%= e.getEmployeeId() %>)
                                </option>
                                <% } } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date</label>
                            <input type="date" name="attendanceDate" value="<%= editAtt != null ? editAtt.getAttendanceDate() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Status</label>
                            <select name="status" required>
                                <option value="Present" <%= editAtt != null && "Present".equals(editAtt.getStatus()) ? "selected" : "" %>>Present</option>
                                <option value="Absent" <%= editAtt != null && "Absent".equals(editAtt.getStatus()) ? "selected" : "" %>>Absent</option>
                                <option value="Leave" <%= editAtt != null && "Leave".equals(editAtt.getStatus()) ? "selected" : "" %>>Leave</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn"><%= editAtt != null ? "Update" : "Save" %></button>
                        <% if (editAtt != null) { %>
                            <a href="${pageContext.request.contextPath}/attendance" class="btn btn-secondary">Cancel</a>
                        <% } %>
                    </div>
                </form>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3>Attendance Records</h3>
                    <form class="search-bar" action="${pageContext.request.contextPath}/attendance" method="get">
                        <input type="hidden" name="action" value="filter">
                        <input type="text" name="employeeName" placeholder="Filter by employee name" value="${filterEmployeeName != null ? filterEmployeeName : ''}">
                        <input type="date" name="date" value="${filterDate != null ? filterDate : ''}">
                        <button type="submit" class="btn btn-sm">Filter</button>
                        <a href="${pageContext.request.contextPath}/attendance" class="btn btn-sm btn-secondary">Reset</a>
                    </form>
                </div>
                <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employee</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
                        if (attendanceList != null && !attendanceList.isEmpty()) {
                            for (Attendance a : attendanceList) {
                                String badgeClass = "present";
                                if ("Absent".equals(a.getStatus())) badgeClass = "absent";
                                else if ("Leave".equals(a.getStatus())) badgeClass = "leave";
                    %>
                        <tr>
                            <td>#<%= a.getAttendanceId() %></td>
                            <td><%= a.getEmployeeName() != null ? a.getEmployeeName() : "Employee #" + a.getEmployeeId() %></td>
                            <td><%= a.getAttendanceDate() %></td>
                            <td><span class="badge <%= badgeClass %>"><%= a.getStatus() %></span></td>
                            <td class="actions-cell">
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/attendance?action=edit&id=<%= a.getAttendanceId() %>">Edit</a>
                                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/attendance?action=delete&id=<%= a.getAttendanceId() %>"
                                   onclick="return confirmDelete('Delete this attendance record?');">Delete</a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="5" class="empty-state">No attendance records found.</td></tr>
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
