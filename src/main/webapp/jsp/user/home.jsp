<%@ page import="imag.dac4.model.user.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Home");
	request.setAttribute("menu-current-page", "user-home");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="../partial/head.jsp" %>

	<% final User user = (User) request.getAttribute("user"); %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<h1 class="ui block header">User Home</h1>

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

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></h2>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
