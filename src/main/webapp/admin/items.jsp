<%@ page import="imag.dac4.model.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Items List</title>
</head>
<body>
	<h1>Items List</h1>

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
				<th>Image</th>
				<th>Name</th>
				<th>Description</th>
				<th>Owner</th>
				<th>Available</th>
				<th>Locker Number</th>
				<th>Max Loan Duration</th>
				<th>Accepted</th>
			</tr>
		</thead>
		<tbody>
			<%
				@SuppressWarnings("unchecked")
				List<Item> items = (List<Item>) request.getAttribute("items");
				if (items != null) {
					for (Item item : items) {
			%>
			<tr>
				<td>
					TODO <!-- <%= item.getImageId() %> -->
				</td>
				<td>
					<%= item.getName() %>
				</td>
				<td>
					<%= item.getDescription() %>
				</td>
				<td>
					<%= item.getOwnerId() %> <!-- TODO Login with Link to User page -->
				</td>
				<td>
					<%= item.isAvailable() %>
				</td>
				<td>
					<%= item.getLockerNum() %>
				</td>
				<td>
					<%= item.getMaxLoanDuration() %>
				</td>
				<td>
					<% if (item.isAccepted()) { %>
					yes
					<% } else { %>
					<form action="${pageContext.request.contextPath}/admin/item/approve" method="POST">
						<input type="hidden" value="<%= item.getId() %>"/>
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
