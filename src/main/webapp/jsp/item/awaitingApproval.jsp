<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Item Registration - Awaiting Approval"/>
<c:set var="currentPage" value="item-awaiting-approval"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Item Registration Incomplete</h1>

			<p class="ui section">
				The administrator needs to approve your item in order to finalize registration.
			</p>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
