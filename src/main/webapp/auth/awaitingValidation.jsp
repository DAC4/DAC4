<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Awaiting Validation</title>
</head>
<body>
	<h1>Awaiting Validation</h1>

	<hr>

	<p>
		Registration processed, for <%= request.getAttribute("name") %> (<%= request.getAttribute("login") %>).
	</p>
</body>
</html>
