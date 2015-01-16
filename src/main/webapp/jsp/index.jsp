<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Index");
	request.setAttribute("menu-current-page", "index");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="partial/head.jsp" %>
</head>
<body>
	<%@ include file="partial/header.jsp" %>

	<h1 class="ui block header">Content</h1>

	<%@ include file="partial/footer.jsp" %>
</body>
</html>
