<!doctype html>
<html>
<head>
	<%!
		String message = "Rémi est dég parce qu'il sait pas dessiner de Pikachu !";
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
</body>
</html>
