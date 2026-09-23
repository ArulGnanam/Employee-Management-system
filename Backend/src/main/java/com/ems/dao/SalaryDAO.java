package com.ems.dao;

import com.ems.model.Salary;
import com.ems.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SalaryDAO {

    private static final String BASE_SELECT =
            "SELECT s.*, e.employee_name FROM salary s " +
            "LEFT JOIN employees e ON s.employee_id = e.employee_id ";

    public List<Salary> getAllSalaries() {
        List<Salary> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY s.salary_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Salary getSalaryById(int id) {
        String sql = BASE_SELECT + "WHERE s.salary_id = ?";
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

    public boolean addSalary(Salary s) {
        String sql = "INSERT INTO salary (employee_id, basic_salary, allowance, deduction, net_salary, payment_date) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setParams(ps, s);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSalary(Salary s) {
        String sql = "UPDATE salary SET employee_id = ?, basic_salary = ?, allowance = ?, deduction = ?, " +
                "net_salary = ?, payment_date = ? WHERE salary_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setParams(ps, s);
            ps.setInt(7, s.getSalaryId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteSalary(int id) {
        String sql = "DELETE FROM salary WHERE salary_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalSalaryRecords() {
        String sql = "SELECT COUNT(*) FROM salary";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void setParams(PreparedStatement ps, Salary s) throws SQLException {
        ps.setInt(1, s.getEmployeeId());
        ps.setDouble(2, s.getBasicSalary());
        ps.setDouble(3, s.getAllowance());
        ps.setDouble(4, s.getDeduction());
        ps.setDouble(5, s.getNetSalary());
        ps.setDate(6, Date.valueOf(s.getPaymentDate()));
    }

    private Salary mapRow(ResultSet rs) throws SQLException {
        Salary s = new Salary();
        s.setSalaryId(rs.getInt("salary_id"));
        s.setEmployeeId(rs.getInt("employee_id"));
        s.setEmployeeName(rs.getString("employee_name"));
        s.setBasicSalary(rs.getDouble("basic_salary"));
        s.setAllowance(rs.getDouble("allowance"));
        s.setDeduction(rs.getDouble("deduction"));
        s.setNetSalary(rs.getDouble("net_salary"));
        Date d = rs.getDate("payment_date");
        s.setPaymentDate(d != null ? d.toString() : "");
        return s;
    }
}
