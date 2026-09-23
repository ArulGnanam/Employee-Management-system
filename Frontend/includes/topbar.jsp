<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="topbar">
    <h2><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Dashboard" %></h2>
    <div class="admin-info">
        <span>👤 <%= session.getAttribute("adminUsername") %></span>
    </div>
</div>
