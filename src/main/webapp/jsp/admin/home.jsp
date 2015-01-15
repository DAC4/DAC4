<%@ page import="imag.dac4.model.user.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Home");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<c:import url="../partial/head.jsp"/>

	<% final User user = (User) request.getAttribute("user"); %>
</head>
<body>
	<c:import url="../partial/header.jsp"/>

	<h1 class="ui block header">Admin Home</h1>

	<hr>

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

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
