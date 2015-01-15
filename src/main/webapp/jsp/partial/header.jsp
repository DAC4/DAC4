<%@ page import="imag.dac4.model.user.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div id="header" class="ui menu">
	<div class="item">
		<h1 class="ui header">DAC4</h1>
	</div>
	<div class="item">
		<h3 class="ui header">
			<%= request.getAttribute("title") %>
		</h3>
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
			<span>
				Logged in as <%= user.getName() %>
			</span>
			<a href="${pageContext.request.contextPath}/auth/logout">
				<button type="button" class="ui button">Logout</button>
			</a>
		</div>
		<% } %>
	</div>
</div>

<% if (request.getAttribute("error") != null) {
	final Integer error = (Integer) request.getAttribute("error");
	final String error_msg = (String) request.getAttribute("error_msg");
%>
<div id="error">
	<h2 class="ui red header">
		Error <%= error %>: <%= error_msg %>
	</h2>
	<hr>
</div>
<% } %>
