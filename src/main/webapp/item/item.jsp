<%@ page import="imag.dac4.model.item.Item" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Item Page</title>
</head>
<body>
	<h1>Item Page</h1>

	<hr>

	<%
		final Integer error = (Integer) request.getAttribute("error");
		if (error != null) {
			final String errorMessage = (String) request.getAttribute("error_msg");
	%>

	<p style="color:red;font-weight:bold">
		Error <%= error %>: <%= errorMessage %>
	</p>

	<%
	} else {
		final Item item = (Item) request.getAttribute("item");
	%>

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
		<% if (!item.isAccepted()) { %>
		<li style="color:red">
			Approved: no
		</li>
		<% } %>
	</ul>

	<% if (item.isAccepted() && item.isAvailable()) { %>
	<form action="${pageContext.request.contextPath}/item/loan" method="POST">
		<input type="hidden" name="id" value="<%= item.getId() %>"/>
		<input type="submit" value="Loan"/>
	</form>
	<% } %>

	<%
		}
	%>

	<hr>

	<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>
</body>
</html>
