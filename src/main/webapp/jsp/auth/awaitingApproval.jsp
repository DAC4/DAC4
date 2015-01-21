<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Registration - Awaiting Approval"/>
<c:set var="currentPage" value="auth-awaiting-approval"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Registration Complete</h1>

			<p class="ui section">
				The administrator needs to approve your account before you can login.
			</p>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
