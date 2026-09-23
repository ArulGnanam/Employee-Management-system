<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ems.model.Salary" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="java.util.List" %>
<%
    request.setAttribute("pageTitle", "Salary Management");
    Salary editSal = (Salary) request.getAttribute("salary");
    List<Employee> empList = (List<Employee>) request.getAttribute("employees");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salary - Employee Management System</title>
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
                    <h3><%= editSal != null ? "Edit Salary Record" : "Add Salary Record" %></h3>
                </div>
                <form action="${pageContext.request.contextPath}/salary" method="post">
                    <input type="hidden" name="action" value="<%= editSal != null ? "update" : "add" %>">
                    <% if (editSal != null) { %>
                        <input type="hidden" name="salaryId" value="<%= editSal.getSalaryId() %>">
                    <% } %>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Employee</label>
                            <select name="employeeId" required>
                                <option value="">-- Select Employee --</option>
                                <% if (empList != null) { for (Employee e : empList) { %>
                                <option value="<%= e.getEmployeeId() %>"
                                    <%= (editSal != null && editSal.getEmployeeId() == e.getEmployeeId()) ? "selected" : "" %>>
                                    <%= e.getEmployeeName() %> (#<%= e.getEmployeeId() %>)
                                </option>
                                <% } } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Basic Salary</label>
                            <input type="number" step="0.01" id="basicSalary" name="basicSalary"
                                   value="<%= editSal != null ? editSal.getBasicSalary() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Allowance</label>
                            <input type="number" step="0.01" id="allowance" name="allowance"
                                   value="<%= editSal != null ? editSal.getAllowance() : 0 %>">
                        </div>
                        <div class="form-group">
                            <label>Deduction</label>
                            <input type="number" step="0.01" id="deduction" name="deduction"
                                   value="<%= editSal != null ? editSal.getDeduction() : 0 %>">
                        </div>
                        <div class="form-group">
                            <label>Net Salary (auto-calculated)</label>
                            <input type="number" step="0.01" id="netSalary" name="netSalaryDisplay" readonly
                                   value="<%= editSal != null ? editSal.getNetSalary() : 0 %>">
                        </div>
                        <div class="form-group">
                            <label>Payment Date</label>
                            <input type="date" name="paymentDate" value="<%= editSal != null ? editSal.getPaymentDate() : "" %>" required>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn"><%= editSal != null ? "Update" : "Save" %></button>
                        <% if (editSal != null) { %>
                            <a href="${pageContext.request.contextPath}/salary" class="btn btn-secondary">Cancel</a>
                        <% } %>
                    </div>
                </form>
            </div>

            <div class="panel">
                <div class="panel-header"><h3>Salary Records</h3></div>
                <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employee</th>
                            <th>Basic</th>
                            <th>Allowance</th>
                            <th>Deduction</th>
                            <th>Net Salary</th>
                            <th>Payment Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Salary> salaryList = (List<Salary>) request.getAttribute("salaryList");
                        if (salaryList != null && !salaryList.isEmpty()) {
                            for (Salary s : salaryList) {
                    %>
                        <tr>
                            <td>#<%= s.getSalaryId() %></td>
                            <td><%= s.getEmployeeName() != null ? s.getEmployeeName() : "Employee #" + s.getEmployeeId() %></td>
                            <td>₹<%= String.format("%.2f", s.getBasicSalary()) %></td>
                            <td>₹<%= String.format("%.2f", s.getAllowance()) %></td>
                            <td>₹<%= String.format("%.2f", s.getDeduction()) %></td>
                            <td><strong>₹<%= String.format("%.2f", s.getNetSalary()) %></strong></td>
                            <td><%= s.getPaymentDate() %></td>
                            <td class="actions-cell">
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/salary?action=edit&id=<%= s.getSalaryId() %>">Edit</a>
                                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/salary?action=delete&id=<%= s.getSalaryId() %>"
                                   onclick="return confirmDelete('Delete this salary record?');">Delete</a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="8" class="empty-state">No salary records found.</td></tr>
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
