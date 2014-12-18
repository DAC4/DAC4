<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="imag.dac.dac4.Guest,java.util.List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>JPA Guestbook Web Application Tutorial</title>
</head>

<body>
	<form method="POST" action="guest">
		Name: <input type="text" name="name"/>
		<input type="submit" value="Add"/>
	</form>

	<hr>
	<ol>
		<%
			@SuppressWarnings("unchecked")
			List<Guest> guests = (List<Guest>) request.getAttribute("guests");
			if (guests != null) {
				for (Guest guest : guests) {
		%>
		<li>
			<%= guest %>
		</li>
		<%
				}
			}
		%>
	</ol>
</body>
</html>
