<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Registration - Awaiting Validation");
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
		<h1>Registration Complete</h1>

		<hr>

		<p>
			The administrator needs to approve your account before you can login.
		</p>

		<hr>

		<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>
	</div>

	<c:import url="../partial/footer.jsp"/>
</body>
</html>
