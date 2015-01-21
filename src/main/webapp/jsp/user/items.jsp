<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "My Items");
	request.setAttribute("menu-current-page", "user-items");
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

			<h1 class="ui block header">My Items</h1>

			<table class="ui striped celled table">
				<thead>
					<th>Image</th>
					<th>Name</th>
					<th>Available</th>
					<th></th>
					<th></th>
				</thead>
				<tbody>
				<%
					@SuppressWarnings("unchecked")
					final List<Item> items = (List<Item>) request.getAttribute("items");
					if (items != null) {
						for (Item item : items) {
							if (item.isApproved() || isAdmin) {
				%>
				<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
					<tr>
						<td class="collapsing">
							<% if (item.getImagePath() == null) { %>
							<img src="${pageContext.request.contextPath}/static/img/default.png" width="64" height="64"/>
							<% } else { %>
							<img src="${pageContext.request.contextPath}<%= item.getImagePath() %>" width="64" height="64"/>
							<% } %>
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
						<td class="collapsing">
							<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
								<button type="button" class="ui button">Details</button>
							</a>
						</td>
						<td class="collapsing">
							<form class="inline-form" action="${pageContext.request.contextPath}/user/items/remove" method="POST">
								<input type="hidden" name="itemId" value="<%= item.getId() %>"/>
								<input type="submit" value="Delete" class="ui red button"/>
							</form>
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

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
