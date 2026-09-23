package com.ems.dao;

import com.ems.model.Attendance;
import com.ems.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    private static final String BASE_SELECT =
            "SELECT a.*, e.employee_name FROM attendance a " +
            "LEFT JOIN employees e ON a.employee_id = e.employee_id ";

    public List<Attendance> getAllAttendance() {
        List<Attendance> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY a.attendance_date DESC, a.attendance_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Attendance getAttendanceById(int id) {
        String sql = BASE_SELECT + "WHERE a.attendance_id = ?";
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

    /**
     * Filters attendance by employee name (partial match) and/or exact date.
     * Either parameter may be null/empty to skip that filter.
     */
    public List<Attendance> filterAttendance(String employeeName, String date) {
        List<Attendance> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT + "WHERE 1=1 ");

        if (employeeName != null && !employeeName.trim().isEmpty()) {
            sql.append("AND e.employee_name LIKE ? ");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append("AND a.attendance_date = ? ");
        }
        sql.append("ORDER BY a.attendance_date DESC, a.attendance_id DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (employeeName != null && !employeeName.trim().isEmpty()) {
                ps.setString(idx++, "%" + employeeName.trim() + "%");
            }
            if (date != null && !date.trim().isEmpty()) {
                ps.setDate(idx++, Date.valueOf(date.trim()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addAttendance(Attendance a) {
        String sql = "INSERT INTO attendance (employee_id, attendance_date, status) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, a.getEmployeeId());
            ps.setDate(2, Date.valueOf(a.getAttendanceDate()));
            ps.setString(3, a.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAttendance(Attendance a) {
        String sql = "UPDATE attendance SET employee_id = ?, attendance_date = ?, status = ? WHERE attendance_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, a.getEmployeeId());
            ps.setDate(2, Date.valueOf(a.getAttendanceDate()));
            ps.setString(3, a.getStatus());
            ps.setInt(4, a.getAttendanceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAttendance(int id) {
        String sql = "DELETE FROM attendance WHERE attendance_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalAttendanceRecords() {
        String sql = "SELECT COUNT(*) FROM attendance";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setAttendanceId(rs.getInt("attendance_id"));
        a.setEmployeeId(rs.getInt("employee_id"));
        a.setEmployeeName(rs.getString("employee_name"));
        Date d = rs.getDate("attendance_date");
        a.setAttendanceDate(d != null ? d.toString() : "");
        a.setStatus(rs.getString("status"));
        return a;
    }
}
