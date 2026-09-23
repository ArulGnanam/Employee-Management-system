<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="java.util.List" %>
<% request.setAttribute("pageTitle", "Add Employee"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-container">
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="includes/topbar.jsp" />

        <div class="page-body">
            <div class="panel">
                <div class="panel-header"><h3>Add New Employee</h3></div>

                <form action="${pageContext.request.contextPath}/employees" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Employee Name</label>
                            <input type="text" name="employeeName" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone">
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dob">
                        </div>
                        <div class="form-group">
                            <label>Department</label>
                            <select name="departmentId" required>
                                <option value="">-- Select Department --</option>
                                <%
                                    List<Department> departments = (List<Department>) request.getAttribute("departments");
                                    if (departments != null) {
                                        for (Department d : departments) {
                                %>
                                <option value="<%= d.getDepartmentId() %>"><%= d.getDepartmentName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Designation</label>
                            <input type="text" name="designation">
                        </div>
                        <div class="form-group">
                            <label>Joining Date</label>
                            <input type="date" name="joiningDate">
                        </div>
                        <div class="form-group">
                            <label>Salary</label>
                            <input type="number" step="0.01" name="salary" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">Save Employee</button>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
