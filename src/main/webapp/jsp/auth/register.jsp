<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="User Registration"/>
<c:set var="currentPage" value="auth-register"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<form class="ui form" method="POST" action="${pageContext.request.contextPath}/auth/register">
				<h1 class="ui dividing header">Registration</h1>

				<div class="field">
					<label for="login">Login:</label>
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="two fields">
					<div class="field">
						<label for="password">Password:</label>
						<input id="password" type="password" placeholder="Password" name="password" required/>
					</div>
					<div class="field">
						<label for="passwordConfirm">Confirm Password:</label>
						<input id="passwordConfirm" type="password" placeholder="Password again" name="passwordConfirm" required/>
					</div>
				</div>
				<div class="field">
					<label for="name">Name:</label>
					<input id="name" type="text" placeholder="Chuck Norris" name="name" required/>
				</div>
				<div class="field">
					<label for="email">Email:</label>
					<input id="email" type="email" placeholder="chuck@norris.com" name="email" required/>
				</div>
				<input type="submit" value="Register" class="ui primary submit button"/>
			</form>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
