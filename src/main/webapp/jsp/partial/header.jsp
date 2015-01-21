<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.user.User" %>

<%
	final String header_currentPage = request.getParameter("menuCurrentPage");
	final User user = (User) request.getSession().getAttribute("user");
	final boolean isConnected = user != null;
	final boolean isAdmin = isConnected && request.getSession().getAttribute("isAdmin") != null && (Boolean) request.getSession().getAttribute("isAdmin");
%>
<c:set var="header_currentPage" value="${param.menuCurrentPage}" scope="page"/>

<div id="header" class="ui menu">
	<a href="${pageContext.request.contextPath}/">
		<div class="item bar-text-big">
			<span>DAC4</span>
		</div>
	</a>

	<% if (isConnected) { %>
	<a href="${pageContext.request.contextPath}/items">
		<div class="<%= "items".equals(header_currentPage) ? "pointing " : "" %>item">
			<span>Items</span>
		</div>
	</a>

	<a href="${pageContext.request.contextPath}/user/items">
		<div class="<%= "user-items".equals(header_currentPage) ? "pointing" : ""%>item">
			<span>My Items</span>
		</div>
	</a>

	<a><!--href="${pageContext.request.contextPath}/loans"-->
		<div class="disabled <%= "loans".equals(header_currentPage) ? "pointing " : "" %>item">
			<span>Loans</span>
		</div>
	</a>
	<% if (isAdmin) { %>
	<a href="${pageContext.request.contextPath}/admin/user">
		<div class="<%= "admin-users".equals(header_currentPage) ? "pointing " : "" %>item">
			<span style="color:red"><i class="setting icon"></i> Users</span>
		</div>
	</a>

	<a href="${pageContext.request.contextPath}/admin/item">
		<div class="<%= "admin-items".equals(header_currentPage) ? "pointing " : "" %>item">
			<span style="color:red"><i class="setting icon"></i> Items</span>
		</div>
	</a>
	<% } %>
	<% } %>

	<div class="right menu">
		<div class="item bar-text-medium">
			<span style="font-style: italic"><%= request.getAttribute("title") %></span>
		</div>
		<% if (!isConnected) { %>
		<div class="item button-item">
			<form class="inline-form" method="POST" action="${pageContext.request.contextPath}/auth/login">
				<div class="ui input">
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="ui input">
					<input id="password" type="password" placeholder="Password" name="password" required/>
				</div>
				<input class="ui submit button" type="submit" value="Login"/>
			</form>
			<% if (!"auth-register".equals(header_currentPage)) { %>
			<a href="${pageContext.request.contextPath}/auth/register">
				<button type="button" class="ui primary button">Register</button>
			</a>
			<% } %>
		</div>
		<% } else { %>
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
			final Integer header_error = (Integer) session.getAttribute("error");
			final String header_error_msg = (String) session.getAttribute("error_msg");
			session.removeAttribute("error");
			session.removeAttribute("error_msg");
	%>
	<div id="error" class="ui negative message">
		<h2 class="header">
			Error <%= header_error %>
		</h2>

		<p>
			<%= header_error_msg %>
		</p>
	</div>
		<% } %>
