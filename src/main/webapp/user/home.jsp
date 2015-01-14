<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>User Home</title>
</head>
<body>
	<h1>User Home</h1>

	<hr>

	<ul>
		<li>
			Login: <%= request.getAttribute("login") %>
		</li>
		<li>
			Name: <%= request.getAttribute("name") %>
		</li>
		<li>
			Email: <%= request.getAttribute("email") %>
		</li>
	</ul>

	<hr>

	<h2><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></h2>
</body>
</html>
