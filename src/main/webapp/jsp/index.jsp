<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Index"/>
<c:set var="currentPage" value="index"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="partial/head.jsp" %>
</head>
<body>
	<%@ include file="partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Bienvenue sur le site du TrocBox !</h1>

		</div>
	</div>

	<%@ include file="partial/footer.jsp" %>
</body>
</html>
