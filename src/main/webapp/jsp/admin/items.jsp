<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Items List");
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

	<div id="content">
		<h1 class="ui header">Items List</h1>

		<hr>

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
						<% if (item.isApproved()) { %>
						yes
						<% } else { %>
						<form action="${pageContext.request.contextPath}/admin/item/approve" method="POST">
							<input type="hidden" name="id" value="<%= item.getId() %>"/>
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
	</div>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
