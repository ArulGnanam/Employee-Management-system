<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="java.util.List" %>
<%
    request.setAttribute("pageTitle", "Edit Employee");
    Employee emp = (Employee) request.getAttribute("employee");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-container">
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="includes/topbar.jsp" />

        <div class="page-body">
            <div class="panel">
                <div class="panel-header"><h3>Edit Employee</h3></div>

                <% if (emp != null) { %>
                <form action="${pageContext.request.contextPath}/employees" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="employeeId" value="<%= emp.getEmployeeId() %>">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Employee Name</label>
                            <input type="text" name="employeeName" value="<%= emp.getEmployeeName() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="<%= emp.getEmail() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone" value="<%= emp.getPhone() != null ? emp.getPhone() : "" %>">
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender">
                                <option value="Male" <%= "Male".equals(emp.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= "Female".equals(emp.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= "Other".equals(emp.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dob" value="<%= emp.getDob() %>">
                        </div>
                        <div class="form-group">
                            <label>Department</label>
                            <select name="departmentId" required>
                                <%
                                    List<Department> departments = (List<Department>) request.getAttribute("departments");
                                    if (departments != null) {
                                        for (Department d : departments) {
                                %>
                                <option value="<%= d.getDepartmentId() %>" <%= d.getDepartmentId() == emp.getDepartmentId() ? "selected" : "" %>>
                                    <%= d.getDepartmentName() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Designation</label>
                            <input type="text" name="designation" value="<%= emp.getDesignation() != null ? emp.getDesignation() : "" %>">
                        </div>
                        <div class="form-group">
                            <label>Joining Date</label>
                            <input type="date" name="joiningDate" value="<%= emp.getJoiningDate() %>">
                        </div>
                        <div class="form-group">
                            <label>Salary</label>
                            <input type="number" step="0.01" name="salary" value="<%= emp.getSalary() %>" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">Update Employee</button>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
                <% } else { %>
                    <p>Employee not found.</p>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
