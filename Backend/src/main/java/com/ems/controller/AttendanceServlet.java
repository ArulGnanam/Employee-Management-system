package com.ems.controller;

import com.ems.dao.AttendanceDAO;
import com.ems.dao.EmployeeDAO;
import com.ems.model.Attendance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int editId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("attendance", attendanceDAO.getAttendanceById(editId));
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.setAttribute("attendanceList", attendanceDAO.getAllAttendance());
                req.getRequestDispatcher("attendance.jsp").forward(req, resp);
                break;

            case "delete":
                int delId = Integer.parseInt(req.getParameter("id"));
                attendanceDAO.deleteAttendance(delId);
                resp.sendRedirect(req.getContextPath() + "/attendance");
                break;

            case "filter":
                String empName = req.getParameter("employeeName");
                String date = req.getParameter("date");
                List<Attendance> filtered = attendanceDAO.filterAttendance(empName, date);
                req.setAttribute("attendanceList", filtered);
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.setAttribute("filterEmployeeName", empName);
                req.setAttribute("filterDate", date);
                req.getRequestDispatcher("attendance.jsp").forward(req, resp);
                break;

            case "list":
            default:
                req.setAttribute("attendanceList", attendanceDAO.getAllAttendance());
                req.setAttribute("employees", employeeDAO.getAllEmployees());
                req.getRequestDispatcher("attendance.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        Attendance a = new Attendance();
        a.setEmployeeId(Integer.parseInt(req.getParameter("employeeId")));
        a.setAttendanceDate(req.getParameter("attendanceDate"));
        a.setStatus(req.getParameter("status"));

        if ("update".equals(action)) {
            a.setAttendanceId(Integer.parseInt(req.getParameter("attendanceId")));
            attendanceDAO.updateAttendance(a);
        } else {
            attendanceDAO.addAttendance(a);
        }

        resp.sendRedirect(req.getContextPath() + "/attendance");
    }
}
