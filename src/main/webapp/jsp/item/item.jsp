<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Item Details");
	request.setAttribute("menu-current-page", "item");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="../partial/head.jsp" %>

	<% final Item item = (Item) request.getAttribute("item"); %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Item Page</h1>

			<ul>
				<li>
					Image: <img src="<%= item.getImageId() %>"/>
				</li>
				<li>
					Name: <%= item.getName() %>
				</li>
				<li>
					Description: <%= item.getDescription() %>
				</li>
				<li>
					Locker Number: <%= item.getLockerNum() %>
				</li>
				<li>
					Max Loan Duration: <%= item.getMaxLoanDuration() %>
				</li>
				<% if (!item.isApproved()) { %>
				<li style="color:red">
					Approved: no
				</li>
				<% } %>
			</ul>

			<% if (item.isApproved() && item.isAvailable()) { %>
			<form action="${pageContext.request.contextPath}/item/loan" method="POST">
				<input type="hidden" name="id" value="<%= item.getId() %>"/>
				<input type="submit" class="ui submit button" value="Loan"/>
			</form>
			<% } %>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
