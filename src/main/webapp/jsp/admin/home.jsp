<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Home");
	request.setAttribute("menu-current-page", "admin-home");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="../partial/head.jsp" %>

</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<h1 class="ui block header">Admin Home</h1>

	<% final User user = (User) request.getSession().getAttribute("user"); %>

	<ul>
		<li>
			Login: <%= user.getLogin() %>
		</li>
		<li>
			Name: <%= user.getName() %>
		</li>
		<li>
			Email: <%= user.getEmail() %>
		</li>
	</ul>

	<hr>

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/admin/user">Users</a></h2>

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/admin/item">Items</a></h2>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
