package com.ems.controller;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.SalaryDAO;
import com.ems.model.Salary;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salary")
public class SalaryServlet extends HttpServlet {

    private final SalaryDAO salaryDAO = new SalaryDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int editId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("salary", salaryDAO.getSalaryById(editId));
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.setAttribute("salaryList", salaryDAO.getAllSalaries());
                req.getRequestDispatcher("salary.jsp").forward(req, resp);
                break;

            case "delete":
                int delId = Integer.parseInt(req.getParameter("id"));
                salaryDAO.deleteSalary(delId);
                resp.sendRedirect(req.getContextPath() + "/salary");
                break;

            case "list":
            default:
                req.setAttribute("salaryList", salaryDAO.getAllSalaries());
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.getRequestDispatcher("salary.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        Salary s = new Salary();
        s.setEmployeeId(Integer.parseInt(req.getParameter("employeeId")));

        double basic = parseDoubleSafe(req.getParameter("basicSalary"));
        double allowance = parseDoubleSafe(req.getParameter("allowance"));
        double deduction = parseDoubleSafe(req.getParameter("deduction"));
        double net = basic + allowance - deduction; // Net Salary = Basic + Allowance - Deduction

        s.setBasicSalary(basic);
        s.setAllowance(allowance);
        s.setDeduction(deduction);
        s.setNetSalary(net);
        s.setPaymentDate(req.getParameter("paymentDate"));

        if ("update".equals(action)) {
            s.setSalaryId(Integer.parseInt(req.getParameter("salaryId")));
            salaryDAO.updateSalary(s);
        } else {
            salaryDAO.addSalary(s);
        }

        resp.sendRedirect(req.getContextPath() + "/salary");
    }

    private double parseDoubleSafe(String value) {
        try {
            return value == null || value.trim().isEmpty() ? 0 : Double.parseDouble(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
