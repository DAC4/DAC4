<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="imag.dac.dac4.User,java.util.List" %>

<!DOCTYPE html>

<html>
<head>
	<title>Users</title>
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
</head>

<body>
	<form class="pure-form" method="POST" action="user">
		<fieldset>
			<legend>
				<span>Create a new User</span>
				<%
					String error = (String) request.getAttribute("error");
					if (error != null) {
						out.print(" - <span style=\"color:red\">" + error + "</span>");
					}
				%>
			</legend>
			<input type="text" name="login" placeholder="Login" required/>
			<input type="password" name="password" placeholder="Password" required/>
			<input type="text" name="name" placeholder="Name" required/>
			<input type="email" name="email" placeholder="Email" required/>
			<button type="submit" class="pure-button pure-button-primary">Create</button>
		</fieldset>
	</form>

	<hr>
	<table class="pure-table">
		<tr>
			<th>Login</th>
			<th>Password (!)</th>
			<th>Name</th>
			<th>E-Mail</th>
		</tr>
		<%
			@SuppressWarnings("unchecked")
			List<User> users = (List<User>) request.getAttribute("users");
			if (users != null) {
				for (User user : users) {
		%>
		<tr>
			<td>
				<%= user.getLogin() %>
			</td>
			<td>
				<%= user.getPassword() %>
			</td>
			<td>
				<%= user.getName() %>
			</td>
			<td>
				<%= user.getEmail() %>
			</td>
		</tr>
		<%
				}
			}
		%>
	</table>

	<a href="${pageContext.request.contextPath}/">Home</a>
</body>
</html>
