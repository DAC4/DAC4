<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Items List");
	request.setAttribute("menu-current-page", "items");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="../partial/head.jsp" %>

	<% final Boolean isAdmin = (Boolean) request.getAttribute("isAdmin"); %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<h1 class="ui block header">Items List</h1>

	<table class="ui striped table">
		<thead>
			<tr>
				<th>Image</th>
				<th>Name</th>
				<th>Available</th>
				<% if (isAdmin != null && isAdmin) { %>
				<th>Approved</th>
				<% } %>
				<th></th>
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
					<% if (item.isAvailable()) { %>
					<td class="positive collapsing">
						<span style="color:green"><i class="checkmark icon"></i> Yes</span>
					</td>
					<% } else { %>
					<td class="negative collapsing">
						<span style="color:red"><i class="remove icon"></i> No</span>
					</td>
					<% } %>
					<% if (isAdmin != null && isAdmin) { %>
					<% if (item.isApproved()) { %>
					<td class="positive collapsing">
						<span style="color:green"><i class="checkmark icon"></i> Yes</span>
					</td>
					<% } else { %>
					<td class="negative collapsing">
						<span style="color:red"><i class="remove icon"></i> No</span>
					</td>
					<% } %>
					<% } %>
					<td class="collapsing">
						<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
							<button type="button" class="ui button">Details</button>
						</a>
					</td>
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

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
