<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="imag.dac.dac4.User,java.util.List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>Users</title>
</head>

<body>
	<form method="POST" action="user">
		Login: <input type="text" name="login"/>
		Password: <input type="password" name="password"/>
		Name: <input type="text" name="name"/>
		E-Mail: <input type="email" name="email"/>
		<input type="submit" value="Add"/>
		<%
			String error = (String) request.getAttribute("error");
			if (error != null) {
				out.print("<span style=\"color:red\">" + error + "</span>");
			}
		%>
	</form>

	<hr>
	<table>
		<tr>
			<th>ID</th>
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
</body>
</html>
