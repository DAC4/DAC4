<%@ page import="imag.dac4.model.user.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Users List</title>
</head>
<body>
	<h1>Users List</h1>

	<hr>

	<%
		final Integer error = (Integer) request.getAttribute("error");
		if (error != null) {
			final String errorMessage = (String) request.getAttribute("error_msg");
	%>
	<p style="color:red;font-weight:bold">
		Error <%= error %>: <%= errorMessage %>
	</p>

	<hr>
	<%
		}
	%>

	<table>
		<thead>
			<tr>
				<th>Login</th>
				<th>Name</th>
				<th>E-Mail</th>
				<th>Credits</th>
				<th>Approved</th>
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
					<%= user.getLogin() %>
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
					<% if (user.isRegistrationComplete()) { %>
					yes
					<% } else { %>
					<form action="${pageContext.request.contextPath}/admin/user/approve" method="POST">
						<input type="hidden" name="login" value="<%= user.getLogin() %>"/>
						<input type="submit" value="no"/>
					</form>
					<% } %>
				</td>
			</tr>
			<%
					}
				}
			%>
		</tbody>
	</table>

	<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>
</body>
</html>
