package com.ems.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Protects all internal pages/servlets (dashboard, employees, departments,
 * attendance, salary) so they cannot be accessed without a valid admin session.
 */
@WebFilter(urlPatterns = {
        "/dashboard", "/employees", "/departments", "/attendance", "/salary",
        "/dashboard.jsp", "/employees.jsp", "/add-employee.jsp", "/edit-employee.jsp",
        "/departments.jsp", "/attendance.jsp", "/salary.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("adminUsername") != null);

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}
