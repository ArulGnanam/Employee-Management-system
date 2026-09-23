package com.ems.controller;

import com.ems.dao.DepartmentDAO;
import com.ems.model.Department;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/departments")
public class DepartmentServlet extends HttpServlet {

    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int editId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("department", departmentDAO.getDepartmentById(editId));
                req.setAttribute("departments", departmentDAO.getAllDepartments());
                req.getRequestDispatcher("departments.jsp").forward(req, resp);
                break;

            case "delete":
                int delId = Integer.parseInt(req.getParameter("id"));
                departmentDAO.deleteDepartment(delId);
                resp.sendRedirect(req.getContextPath() + "/departments");
                break;

            case "list":
            default:
                req.setAttribute("departments", departmentDAO.getAllDepartments());
                req.getRequestDispatcher("departments.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        Department d = new Department();
        d.setDepartmentName(req.getParameter("departmentName"));
        d.setDescription(req.getParameter("description"));

        if ("update".equals(action)) {
            d.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));
            departmentDAO.updateDepartment(d);
        } else {
            departmentDAO.addDepartment(d);
        }

        resp.sendRedirect(req.getContextPath() + "/departments");
    }
}
