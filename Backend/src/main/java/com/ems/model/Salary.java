package com.ems.model;

public class Salary {
    private int salaryId;
    private int employeeId;
    private String employeeName; // joined from employees table
    private double basicSalary;
    private double allowance;
    private double deduction;
    private double netSalary;
    private String paymentDate; // yyyy-MM-dd

    public Salary() {}

    public int getSalaryId() { return salaryId; }
    public void setSalaryId(int salaryId) { this.salaryId = salaryId; }

    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }

    public double getBasicSalary() { return basicSalary; }
    public void setBasicSalary(double basicSalary) { this.basicSalary = basicSalary; }

    public double getAllowance() { return allowance; }
    public void setAllowance(double allowance) { this.allowance = allowance; }

    public double getDeduction() { return deduction; }
    public void setDeduction(double deduction) { this.deduction = deduction; }

    public double getNetSalary() { return netSalary; }
    public void setNetSalary(double netSalary) { this.netSalary = netSalary; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
}
