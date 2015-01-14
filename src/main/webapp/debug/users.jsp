<%@ page import="imag.dac4.model.user.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
	<title>Users</title>
	<style>
		#content, table {
			margin: 25px auto;
		}
	</style>
</head>

<body>
	<div id="content">
		<form method="POST" action="user">
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

		<table class="pure-table pure-table-bordered pure-table-striped">
			<thead>
				<tr>
					<th>Id</th>
					<th>Login</th>
					<th>Password (!)</th>
					<th>Name</th>
					<th>E-Mail</th>
					<th>Credits</th>
					<th>Registration Complete</th>
				</tr>
			</thead>
			<tbody>
				<%
					@SuppressWarnings("unchecked")
					List<User> users = (List<User>) request.getAttribute("users");
					if (users != null) {
						for (User user : users) {
				%>
				<tr>
					<td>
						<%= user.getId()%>
					</td>
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
					<td>
						<%= user.getCredits() %>
					</td>
					<td>
						<%= user.isRegistrationComplete() %>
					</td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>

		<a class="pure-button" href="${pageContext.request.contextPath}/">Home</a>
	</div>
</body>
</html>
