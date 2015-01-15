<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Items List");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<c:import url="../partial/head.jsp"/>

	<% final Boolean isAdmin = (Boolean) request.getAttribute("isAdmin"); %>
</head>
<body>
	<c:import url="../partial/header.jsp"/>

	<h1 class="ui block header">Items List</h1>

	<table class="ui table">
		<thead>
			<tr>
				<th>Image</th>
				<th>Name</th>
				<th>Available</th>
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
						if (item.isApproved() || isAdmin != null && isAdmin) {
			%>
			<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
				<tr>
					<td>
						TODO <!-- <%= item.getImageId() %> -->
					</td>
					<td>
						<%= item.getName() %>
					</td>
					<td style="color:<%= item.isAvailable() ? "green" : "red" %>">
						<%= item.isAvailable() ? "yes" : "no" %>
					</td>
					<% if (isAdmin != null && isAdmin) { %>
					<td>
						<%= item.isApproved() ? "yes" : "no" %>
					</td>
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

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/">Index</a></h2>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
