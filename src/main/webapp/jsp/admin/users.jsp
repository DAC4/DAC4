<%@ page import="imag.dac4.model.user.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Users List");
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

	<h1 class="ui block header">Users List</h1>

	<table class="ui table">
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
					<% if (user.isApproved()) { %>
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

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/">Index</a></h2>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
