package com.ems.controller;

import com.ems.dao.AttendanceDAO;
import com.ems.dao.DepartmentDAO;
import com.ems.dao.EmployeeDAO;
import com.ems.dao.SalaryDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final SalaryDAO salaryDAO = new SalaryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("totalEmployees", employeeDAO.getTotalEmployees());
        req.setAttribute("totalDepartments", departmentDAO.getTotalDepartments());
        req.setAttribute("totalAttendance", attendanceDAO.getTotalAttendanceRecords());
        req.setAttribute("totalSalary", salaryDAO.getTotalSalaryRecords());

        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }
}
