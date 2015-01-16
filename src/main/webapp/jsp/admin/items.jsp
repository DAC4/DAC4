<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Items List");
	request.setAttribute("menu-current-page", "admin-items");
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

	<h1 class="ui block header">Items List</h1>

	<table class="ui striped table">
		<thead>
			<tr>
				<th>Image</th>
				<th>Name</th>
				<th>Description</th>
				<th>Owner</th>
				<th>Available</th>
				<th>Locker Number</th>
				<th>Max Loan Duration</th>
				<th>Approved</th>
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
				<% if (item.isApproved()) { %>
				<td class="positive">
					<span style="color:green"><i class="checkmark icon"></i><button type="button" class="ui green disabled button">Approved</button></span>
				</td>
				<% } else { %>
				<td class="negative">
					<form action="${pageContext.request.contextPath}/admin/item/approve" method="POST">
						<input type="hidden" name="id" value="<%= item.getId() %>"/>
						<span style="color:red"><i class="remove icon"></i></span>
						<input type="submit" value="Approve" class="ui red button"/>
					</form>
				</td>
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

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
