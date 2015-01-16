<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "User Registration");
	request.setAttribute("menu-current-page", "auth-register");
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

	<div class="section">
		<form class="ui form" method="POST" action="${pageContext.request.contextPath}/auth/register">
			<h1 class="ui dividing header">Registration</h1>

			<div class="field">
				<label for="login">Login:</label>
				<input id="login" type="text" placeholder="Login" name="login" required/>
			</div>
			<div class="field">
				<label for="password">Password:</label>
				<input id="password" type="password" placeholder="Password" name="password" required/>
			</div>
			<div class="field">
				<label for="passwordConfirm">Confirm Password:</label>
				<input id="passwordConfirm" type="password" placeholder="Password" name="passwordConfirm" required/>
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
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
