// Confirm before deleting a record
function confirmDelete(message) {
    return confirm(message || "Are you sure you want to delete this record?");
}

// Client-side calculation of Net Salary as user types (Basic + Allowance - Deduction)
function calculateNetSalary() {
    const basic = parseFloat(document.getElementById("basicSalary")?.value) || 0;
    const allowance = parseFloat(document.getElementById("allowance")?.value) || 0;
    const deduction = parseFloat(document.getElementById("deduction")?.value) || 0;
    const net = basic + allowance - deduction;

    const netField = document.getElementById("netSalary");
    if (netField) {
        netField.value = net.toFixed(2);
    }
}

document.addEventListener("DOMContentLoaded", function () {
    ["basicSalary", "allowance", "deduction"].forEach(function (id) {
        const el = document.getElementById(id);
        if (el) el.addEventListener("input", calculateNetSalary);
    });
    calculateNetSalary();
});
