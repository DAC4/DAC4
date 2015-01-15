<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Index</title>
	<c:import url="partial/head.jsp"/>
</head>
<body>
	<c:import url="partial/header.jsp"/>
	<c:import url="partial/nav.jsp"/>
	<div id="content">

		<form class="ui form" method="POST" action="${pageContext.request.contextPath}/auth/login">
			<fieldset>
				<legend>Login</legend>
				<div class="two fields">
					<div class="field">
						<label for="login">Login</label>
						<input id="login" type="text" placeholder="Login" name="login" required/>
					</div>
					<div class="field">
						<label for="password">Mot de passe</label>
						<input id="password" type="password" placeholder="password" name="password" required/>
					</div>
				</div>
			</fieldset>
			<input class="ui submit primary button" type="submit" value="Login"/>
		</form>
		<br/>

		<a class="ui primary button" href="${pageContext.request.contextPath}/auth/register">Register</a>
	</div>
	<c:import url="partial/footer.jsp"/>
</body>
</html>
