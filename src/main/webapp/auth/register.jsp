<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Registration</title>
</head>
<body>
	<h1>Registration</h1>

	<hr>

	<form action="${pageContext.request.contextPath}/auth/register" method="POST">
		<fieldset>
			<legend>
				<span>Create an account</span>
				<%
					final Integer error = (Integer) request.getAttribute("error");
					final String errorMessage = (String) request.getAttribute("error_msg");
					if (error != null) {
				%>
				<span style="color:red">Error <%= error %>: <%= errorMessage %></span>
				<%
					}
				%>
			</legend>
			<ul style="list-style-type:none">
				<li>
					<label for="login">Login:</label>
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</li>

				<li>
					<label for="password">Password:</label>
					<input id="password" type="password" placeholder="password" name="password" required/>
				</li>

				<li>
					<label for="passwordConfirm">Confirm Password:</label>
					<input id="passwordConfirm" type="password" placeholder="password" name="passwordConfirm" required/>
				</li>

				<li>
					<label for="name">Name:</label>
					<input id="name" type="text" placeholder="Chuck Norris" name="name" required/>
				</li>

				<li>
					<label for="email">Password:</label>
					<input id="email" type="email" placeholder="chuck@norris.com" name="email" required/>
				</li>
			</ul>
		</fieldset>
		<input type="submit" value="Register"/>
	</form>

	<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>
</body>
</html>
