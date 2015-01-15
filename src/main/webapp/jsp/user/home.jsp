<%@ page import="imag.dac4.model.user.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>User Home</title>
	<c:import url="../partial/head.jsp"/>

	<% final User user = (User) request.getAttribute("user"); %>
</head>
<body>
	<c:import url="../partial/header.jsp"/>

	<div id="content">
		<h1>User Home</h1>

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

		<h2><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></h2>
	</div>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
