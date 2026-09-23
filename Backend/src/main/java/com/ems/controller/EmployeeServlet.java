package com.ems.controller;

import com.ems.dao.DepartmentDAO;
import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.setAttribute("departments", departmentDAO.getAllDepartments());
                req.getRequestDispatcher("add-employee.jsp").forward(req, resp);
                break;

            case "edit":
                int editId = Integer.parseInt(req.getParameter("id"));
                Employee emp = employeeDAO.getEmployeeById(editId);
                req.setAttribute("employee", emp);
                req.setAttribute("departments", departmentDAO.getAllDepartments());
                req.getRequestDispatcher("edit-employee.jsp").forward(req, resp);
                break;

            case "delete":
                int delId = Integer.parseInt(req.getParameter("id"));
                employeeDAO.deleteEmployee(delId);
                resp.sendRedirect(req.getContextPath() + "/employees");
                break;

            case "search":
                String keyword = req.getParameter("keyword");
                List<Employee> results = (keyword == null || keyword.trim().isEmpty())
                        ? employeeDAO.getAllEmployees()
                        : employeeDAO.searchEmployees(keyword.trim());
                req.setAttribute("employees", results);
                req.setAttribute("keyword", keyword);
                req.getRequestDispatcher("employees.jsp").forward(req, resp);
                break;

            case "list":
            default:
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.getRequestDispatcher("employees.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        Employee emp = new Employee();

        emp.setEmployeeName(req.getParameter("employeeName"));
        emp.setEmail(req.getParameter("email"));
        emp.setPhone(req.getParameter("phone"));
        emp.setGender(req.getParameter("gender"));
        emp.setDob(req.getParameter("dob"));
        emp.setDesignation(req.getParameter("designation"));
        emp.setJoiningDate(req.getParameter("joiningDate"));

        try {
            emp.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));
        } catch (NumberFormatException e) {
            emp.setDepartmentId(0);
        }
        try {
            emp.setSalary(Double.parseDouble(req.getParameter("salary")));
        } catch (NumberFormatException e) {
            emp.setSalary(0);
        }

        if ("update".equals(action)) {
            emp.setEmployeeId(Integer.parseInt(req.getParameter("employeeId")));
            employeeDAO.updateEmployee(emp);
        } else {
            employeeDAO.addEmployee(emp);
        }

        resp.sendRedirect(req.getContextPath() + "/employees");
    }
}
