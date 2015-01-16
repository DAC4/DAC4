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

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Content</h1>

		</div>
	</div>

	<%@ include file="partial/footer.jsp" %>
</body>
</html>
