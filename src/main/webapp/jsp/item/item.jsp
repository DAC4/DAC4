<%@ page import="imag.dac4.model.item.Item" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Item Details");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<c:import url="../partial/head.jsp"/>

	<% final Item item = (Item) request.getAttribute("item"); %>
</head>
<body>
	<c:import url="../partial/header.jsp"/>

	<h1 class="ui block header">Item Page</h1>

	<ul>
		<li>
			Image: <%= item.getImageId() %>
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
		<input type="submit" value="Loan"/>
	</form>
	<% } %>

	<hr>

	<h2 class="ui header"><a href="${pageContext.request.contextPath}/">Index</a></h2>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
