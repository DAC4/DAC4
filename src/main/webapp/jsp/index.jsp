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

	<h1 class="ui block header">Content</h1>

	<c:import url="partial/footer.jsp"/>
</body>
</html>
