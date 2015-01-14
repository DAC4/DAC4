<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Registration</title>
</head>
<body>
	<h1>Registration</h1>

	<hr>

	<%
		final Integer error = (Integer) request.getAttribute("error");
		if (error != null) {
			final String errorMessage = (String) request.getAttribute("error_msg");
	%>
	<p style="color:red;font-weight:bold">
		<%= errorMessage %>
	</p>
	<hr>
	<%
		}
	%>

	<form action="${pageContext.request.contextPath}/auth" method="POST">
		<input type="hidden" name="action" value="register"/>
		<label for="login">Login:</label>
		<input id="login" type="text" placeholder="Login" name="login" required/>
		<label for="password">Password:</label>
		<input id="password" type="password" placeholder="password" name="password" required/>
		<input type="submit" value="Login"/>
	</form>
</body>
</html>
