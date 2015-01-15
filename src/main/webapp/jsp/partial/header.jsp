<%@ page import="imag.dac4.model.user.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div id="header" class="ui menu">
	<div class="item">
		<h1 class="ui header">DAC4</h1>
	</div>
	<div class="right menu">
		<% if (request.getAttribute("showLoginForm") != null) { %>
		<div id="form-item" class="item">
			<form method="POST" action="${pageContext.request.contextPath}/auth/login">
				<div class="ui input">
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="ui input">
					<input id="password" type="password" placeholder="Password" name="password" required/>
				</div>
				<input class="ui submit button" type="submit" value="Login"/>
			</form>
			<a href="${pageContext.request.contextPath}/auth/register">
				<button type="button" class="ui primary button">Register</button>
			</a>
		</div>
		<% } else if (request.getAttribute("user") != null) {%>
		<% final User user = (User) request.getAttribute("user"); %>
		<div class="item">
			<p>
				Logged in as <%= user.getName() %>
			</p>
		</div>
		<% } %>
	</div>
</div>
