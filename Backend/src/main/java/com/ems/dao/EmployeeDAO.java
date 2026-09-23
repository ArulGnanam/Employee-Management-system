package com.ems.dao;

import com.ems.model.Employee;
import com.ems.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private static final String BASE_SELECT =
            "SELECT e.*, d.department_name FROM employees e " +
            "LEFT JOIN departments d ON e.department_id = d.department_id ";

    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY e.employee_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Employee getEmployeeById(int id) {
        String sql = BASE_SELECT + "WHERE e.employee_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Employee> searchEmployees(String keyword) {
        List<Employee> list = new ArrayList<>();
        String sql = BASE_SELECT +
                "WHERE e.employee_name LIKE ? OR e.email LIKE ? OR d.department_name LIKE ? OR e.designation LIKE ? " +
                "ORDER BY e.employee_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String likeKeyword = "%" + keyword + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);
            ps.setString(3, likeKeyword);
            ps.setString(4, likeKeyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees " +
                "(employee_name, email, phone, gender, dob, department_id, designation, joining_date, salary) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setEmployeeParams(ps, emp);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET employee_name = ?, email = ?, phone = ?, gender = ?, dob = ?, " +
                "department_id = ?, designation = ?, joining_date = ?, salary = ? WHERE employee_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setEmployeeParams(ps, emp);
            ps.setInt(10, emp.getEmployeeId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE employee_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalEmployees() {
        String sql = "SELECT COUNT(*) FROM employees";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void setEmployeeParams(PreparedStatement ps, Employee emp) throws SQLException {
        ps.setString(1, emp.getEmployeeName());
        ps.setString(2, emp.getEmail());
        ps.setString(3, emp.getPhone());
        ps.setString(4, emp.getGender());
        ps.setDate(5, emp.getDob() != null && !emp.getDob().isEmpty() ? Date.valueOf(emp.getDob()) : null);
        ps.setInt(6, emp.getDepartmentId());
        ps.setString(7, emp.getDesignation());
        ps.setDate(8, emp.getJoiningDate() != null && !emp.getJoiningDate().isEmpty() ? Date.valueOf(emp.getJoiningDate()) : null);
        ps.setDouble(9, emp.getSalary());
    }

    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee emp = new Employee();
        emp.setEmployeeId(rs.getInt("employee_id"));
        emp.setEmployeeName(rs.getString("employee_name"));
        emp.setEmail(rs.getString("email"));
        emp.setPhone(rs.getString("phone"));
        emp.setGender(rs.getString("gender"));
        Date dob = rs.getDate("dob");
        emp.setDob(dob != null ? dob.toString() : "");
        emp.setDepartmentId(rs.getInt("department_id"));
        emp.setDepartmentName(rs.getString("department_name"));
        emp.setDesignation(rs.getString("designation"));
        Date joining = rs.getDate("joining_date");
        emp.setJoiningDate(joining != null ? joining.toString() : "");
        emp.setSalary(rs.getDouble("salary"));
        return emp;
    }
}
