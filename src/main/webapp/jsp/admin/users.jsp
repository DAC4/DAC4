<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Users List");
	request.setAttribute("menu-current-page", "admin-users");
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

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Users List</h1>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Login</th>
						<th>Name</th>
						<th>E-Mail</th>
						<th>Credits</th>
						<th>Approved</th>
						<th>Action</th>
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
						<td class="right aligned">
							<%= user.getCredits() %>
						</td>
						<% if (user.isApproved()) { %>
						<td class="positive collapsing">
							<span style="color:green"><i class="checkmark icon"></i> Yes</span>
						</td>
						<% } else { %>
						<td class="negative collapsing">
							<span style="color:red"><i class="remove icon"></i> No</span>
						</td>
						<% } %>
						<td class="collapsing">
							<% if (!user.isApproved()) { %>
							<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/approve" method="POST">
								<input type="hidden" name="login" value="<%= user.getLogin() %>"/>
								<input type="submit" value="Approve" class="ui red button"/>
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

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
