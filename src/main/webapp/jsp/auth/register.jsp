<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Registration");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<c:import url="../partial/head.jsp"/>
</head>
<body>
	<c:import url="../partial/header.jsp"/>

	<h1 class="ui header">Registration</h1>

	<hr>

	<form class="ui form" method="POST" action="${pageContext.request.contextPath}/auth/register">
		<div class="field">
			<label for="login">Login:</label>
			<input id="login" type="text" placeholder="Login" name="login" required/>
		</div>
		<div class="field">
			<label for="password">Password:</label>
			<input id="password" type="password" placeholder="password" name="password" required/>
		</div>
		<div class="field">
			<label for="passwordConfirm">Confirm Password:</label>
			<input id="passwordConfirm" type="password" placeholder="password" name="passwordConfirm" required/>
		</div>
		<div class="field">
			<label for="name">Name:</label>
			<input id="name" type="text" placeholder="Chuck Norris" name="name" required/>
		</div>
		<div class="field">
			<label for="email">Password:</label>
			<input id="email" type="email" placeholder="chuck@norris.com" name="email" required/>
		</div>
		<input type="submit" value="Register"/>
	</form>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
