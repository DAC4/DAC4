<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
<head>
	<%!
		String message = "Hello new world! (jsp)";
	%>
	<title>
		<%= message %>
	</title>
</head>
<body>
	<h2>
		<%= message %>
	</h2>

	<h3>
		<%= new java.util.Date() %>
	</h3>

	<h4>
		<%= request.getAttribute("text") %>
	</h4>

	<a href="${pageContext.request.contextPath}/user">User JDBC/JPA/EJB/MySQL test page</a>
</body>
</html>
