<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Index");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<c:import url="partial/head.jsp"/>
</head>
<body>
	<c:import url="partial/header.jsp"/>

	<div id="content">

		<h1>Content</h1>

	</div>

	<c:import url="partial/footer.jsp"/>
</body>
</html>
