<!doctype html>
<html>
<head>
	<%!
		String message = "Hello Wolrd!";
	%>
	<title><%= message%>
	</title>
</head>
<body>
	<h2>
		<%= message%>
	</h2>
	<%= new java.util.Date() %>
</body>
</html>
