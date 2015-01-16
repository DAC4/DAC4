<%@ page import="imag.dac4.model.user.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
	final String current = request.getParameter("menu-current-page");
	final boolean isConnected = request.getSession().getAttribute("user") != null;
	final boolean isAdmin = request.getSession().getAttribute("isAdmin") != null && (Boolean) request.getSession().getAttribute("isAdmin");
%>

<!-- TODO Add menu entries according to session.getAttribute("menu-config"); -->
<div id="header" class="ui menu">
	<a href="${pageContext.request.contextPath}/">
		<div class="item bar-text-big">
			<span>DAC4</span>
		</div>
	</a>

	<div class="item bar-text-medium">
		<span style="font-style: italic"><%= request.getAttribute("title") %></span>
	</div>

	<% if (isConnected) { %>
	<a href="${pageContext.request.contextPath}/items">
		<div class="<%= "items".equals(current) ? "pointing " : "" %>item">Items</div>
	</a>

	<a><!--href="${pageContext.request.contextPath}/loans"-->
		<div class="disabled <%= "loans".equals(current) ? "pointing " : "" %>item">Loans</div>
	</a>
	<% if (isAdmin) { %>
	<a href="${pageContext.request.contextPath}/admin/user">
		<div class="red <%= "admin-users".equals(current) ? "pointing " : "" %>item"><i class="setting icon"></i> Users</div>
	</a>

	<a href="${pageContext.request.contextPath}/admin/item">
		<div class="red <%= "admin-items".equals(current) ? "pointing " : "" %>item"><i class="setting icon"></i> Items</div>
	</a>
	<% } %>
	<% } %>

	<div class="right menu">
		<% if (request.getAttribute("showLoginForm") != null) { %>
		<div class="item button-item">
			<form method="POST" action="${pageContext.request.contextPath}/auth/login">
				<div class="ui input">
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="ui input">
					<input id="password" type="password" placeholder="Password" name="password" required/>
				</div>
				<input class="ui submit button" type="submit" value="Login"/>
			</form>
			<% if (!"auth-register".equals(current)) { %>
			<a href="${pageContext.request.contextPath}/auth/register">
				<button type="button" class="ui primary button">Register</button>
			</a>
			<% } %>
		</div>
		<% } else if (request.getAttribute("user") != null) {%>
		<% final User user = (User) request.getAttribute("user"); %>
		<div class="item bar-text-small">
			<span>
				Logged in as <%= user.getName() %>
			</span>
		</div>
		<div class="item button-item">
			<a href="${pageContext.request.contextPath}/auth/logout">
				<button type="button" class="ui button">Logout</button>
			</a>
		</div>
		<% } %>
	</div>
</div>

<div id="content" class="ui page grid">
	<%
		if (session.getAttribute("error") != null) {
			final Integer error = (Integer) session.getAttribute("error");
			final String error_msg = (String) session.getAttribute("error_msg");
			session.removeAttribute("error");
			session.removeAttribute("error_msg");
	%>
	<div id="error" class="ui negative message">
		<h2 class="header">
			Error <%= error %>
		</h2>

		<p>
			<%= error_msg %>
		</p>
	</div>
		<% } %>
