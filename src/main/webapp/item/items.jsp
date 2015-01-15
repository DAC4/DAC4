<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Items List</title>

	<% final Boolean isAdmin = (Boolean) request.getAttribute("isAdmin"); %>
</head>
<body>
	<h1>Items List</h1>

	<hr>

	<table>
		<thead>
			<tr>
				<th>Image</th>
				<th>Name</th>
				<% if (isAdmin != null && isAdmin) { %>
				<th>Approved</th>
				<% } %>
			</tr>
		</thead>
		<tbody>
			<%
				@SuppressWarnings("unchecked")
				final List<Item> items = (List<Item>) request.getAttribute("items");
				if (items != null) {
					for (Item item : items) {
						if (item.isAccepted() || isAdmin != null && isAdmin) {
			%>
			<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
				<tr>
					<td>
						TODO <!-- <%= item.getImageId() %> -->
					</td>
					<td style="color:<%= item.isAvailable() ? "green" : "red" %>">
						<%= item.getName() %>
					</td>
					<% if (isAdmin != null && isAdmin) { %>
					<% if (item.isAccepted()) { %>
					<td style="color:red">
						no
					</td>
					<% } else {%>
					<td style="color:green">
						yes
					</td>
					<% } %>
					<% } %>
				</tr>
			</a>
			<%
						}
					}
				}
			%>
		</tbody>
	</table>

	<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>
</body>
</html>
