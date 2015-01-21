<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Admin - Home");
	request.setAttribute("menu-current-page", "admin-home");
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

			<h1 class="ui block header">Admin Home</h1>

			<ul>
				<li>
					Login: <%= user.getLogin() %>
				</li>
				<li>
					Name: <%= user.getName() %>
				</li>
				<li>
					Email: <%= user.getEmail() %>
				</li>
			</ul>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
