<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Item Registration - Awaiting Approval");
	request.setAttribute("menu-current-page", "item-awaiting-approval");
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

	<h1 class="ui block header">Item Registration Complete</h1>

	<p class="ui section">
		The administrator needs to approve your item before in order to finalize registration.
	</p>

	<hr>

	<h2><a href="${pageContext.request.contextPath}/">Index</a></h2>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
