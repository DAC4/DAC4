<jsp:useBean id="HelloBean" scope="request" class="beans.HelloBean"/>
<!doctype html>
<html>
<head>
	<%!
		String message = "Hello World!";
	%>
	<title><%= message %>
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

	<h5>
		${HelloBean.message}
	</h5>
</body>
</html>
