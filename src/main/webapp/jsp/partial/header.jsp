<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div id="header" class="ui menu">
	<div class="item">
		<h1>DAC4</h1>
	</div>
	<div class="right menu">
		<div class="item">
			<form method="POST" action="${pageContext.request.contextPath}/auth/login">
				<div class="ui transparent input">
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="ui transparent input">
					<input id="password" type="password" placeholder="password" name="password" required/>
				</div>
				<input class="ui submit button" type="submit" value="Login"/>
			</form>
			<a class="ui primary button" href="${pageContext.request.contextPath}/auth/register">Register</a>
		</div>
	</div>
</div>
