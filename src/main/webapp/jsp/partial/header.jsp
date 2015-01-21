<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.user.User" %>

<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="currentPage" type="java.lang.String"--%>

<%--@elvariable id="user" type="imag.dac4.model.user.User"--%>
<%--@elvariable id="isConnected" type="java.lang.Boolean"--%>
<%--@elvariable id="isAdmin" type="java.lang.Boolean"--%>

<c:if test="${user != null}" var="isConnected"/>
<c:if test="${isConnected && sessionScope.isAdmin != null && sessionScope.isAdmin == true}" var="isAdmin"/>

<div id="header" class="ui menu">
	<a href="${pageContext.request.contextPath}/">
		<div class="item bar-text-big">
			<span>DAC4</span>
		</div>
	</a>

	<c:if test="${isConnected == true}">
		<a href="${pageContext.request.contextPath}/items">
			<div class="${"items" == currentPage ? "pointing " : ""}item">
				<span>Items</span>
			</div>
		</a>

		<a href="${pageContext.request.contextPath}/user/items">
			<div class="${"user-items" == currentPage ? "pointing " : ""}item">
				<span>My Items</span>
			</div>
		</a>

		<a><!--href="${pageContext.request.contextPath}/loans"-->
			<div class="disabled ${"loans" == currentPage ? "pointing " : ""}item">
				<span>Loans</span>
			</div>
		</a>
		<c:if test="${isAdmin == true}">
			<a href="${pageContext.request.contextPath}/admin/user">
				<div class="${"admin-users" == currentPage ? "pointing " : ""}item">
					<span style="color:red"><i class="setting icon"></i> Users</span>
				</div>
			</a>

			<a href="${pageContext.request.contextPath}/admin/item">
				<div class="${"admin-items" == currentPage ? "pointing " : ""}item">
					<span style="color:red"><i class="setting icon"></i> Items</span>
				</div>
			</a>
		</c:if>
	</c:if>

	<div class="right menu">
		<div class="item bar-text-medium">
			<span style="font-style: italic"><c:out value="${title}"/></span>
		</div>
		<c:choose>
			<c:when test="${isConnected == false}">
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
					<c:if test="${\"auth-register\" != currentPage}">
						<a href="${pageContext.request.contextPath}/auth/register">
							<button type="button" class="ui primary button">Register</button>
						</a>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<div class="item bar-text-small">
					<span>Logged in as <c:out value="${user.name}"/></span>
				</div>
				<div class="item button-item">
					<a href="${pageContext.request.contextPath}/auth/logout">
						<button type="button" class="ui button">Logout</button>
					</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div id="content" class="ui page grid">
	<c:if test="${sessionScope.error != null}">
		<div id="error" class="ui negative message">
			<h2 class="header">
				Error <c:out value="${sessionScope.error}"/>
			</h2>

			<p>
				<c:out value="${sessionScope.msg}"/>
			</p>
		</div>
		<c:remove var="sessionScope.error"/>
		<c:remove var="sessionScope.error_msg"/>
	</c:if>
