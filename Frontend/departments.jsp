<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="java.util.List" %>
<%
    request.setAttribute("pageTitle", "Department Management");
    Department editDept = (Department) request.getAttribute("department");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - Employee Management System</title>
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
                    <h3><%= editDept != null ? "Edit Department" : "Add New Department" %></h3>
                </div>
                <form action="${pageContext.request.contextPath}/departments" method="post">
                    <input type="hidden" name="action" value="<%= editDept != null ? "update" : "add" %>">
                    <% if (editDept != null) { %>
                        <input type="hidden" name="departmentId" value="<%= editDept.getDepartmentId() %>">
                    <% } %>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Department Name</label>
                            <input type="text" name="departmentName" value="<%= editDept != null ? editDept.getDepartmentName() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <input type="text" name="description" value="<%= editDept != null && editDept.getDescription() != null ? editDept.getDescription() : "" %>">
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn"><%= editDept != null ? "Update Department" : "Add Department" %></button>
                        <% if (editDept != null) { %>
                            <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">Cancel</a>
                        <% } %>
                    </div>
                </form>
            </div>

            <div class="panel">
                <div class="panel-header"><h3>All Departments</h3></div>
                <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Department Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Department> departments = (List<Department>) request.getAttribute("departments");
                        if (departments != null && !departments.isEmpty()) {
                            for (Department d : departments) {
                    %>
                        <tr>
                            <td>#<%= d.getDepartmentId() %></td>
                            <td><%= d.getDepartmentName() %></td>
                            <td><%= d.getDescription() != null ? d.getDescription() : "-" %></td>
                            <td class="actions-cell">
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/departments?action=edit&id=<%= d.getDepartmentId() %>">Edit</a>
                                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/departments?action=delete&id=<%= d.getDepartmentId() %>"
                                   onclick="return confirmDelete('Delete this department?');">Delete</a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="4" class="empty-state">No departments found.</td></tr>
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
