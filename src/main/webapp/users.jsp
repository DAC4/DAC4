<%@ page import="imag.dac.dac4.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
	<title>Users</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">
	<!--[if lte IE 8]>
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/grids-responsive-old-ie-min.css">
	<![endif]-->
	<!--[if gt IE 8]><!-->
	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/grids-responsive-min.css">
	<!--<![endif]-->
	<style>
		#content, table {
			margin: 25px auto;
		}
	</style>
</head>

<body class="pure-g">
	<div id="content" class="pure-u-1 pure-u-md-3-5">
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

		<table class="pure-table pure-table-bordered pure-table-striped">
			<thead>
				<tr>
					<th>Login</th>
					<th>Password (!)</th>
					<th>Name</th>
					<th>E-Mail</th>
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
			</tbody>
		</table>

		<a class="pure-button" href="${pageContext.request.contextPath}/">Home</a>
	</div>
</body>
</html>
