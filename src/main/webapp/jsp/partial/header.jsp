<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="currentPage" type="java.lang.String"--%>

<%--@elvariable id="user" type="imag.dac4.model.user.User"--%>
<%--@elvariable id="isConnected" type="java.lang.Boolean"--%>
<%--@elvariable id="isAdmin" type="java.lang.Boolean"--%>

<%--@elvariable id="error" type="java.lang.String"--%>
<%--@elvariable id="error_msg" type="java.lang.String"--%>

<%--@elvariable id="warning_msg" type="java.lang.String"--%>

<%--@elvariable id="success_msg" type="java.lang.String"--%>

<c:if test="${user != null}" var="isConnected"/>
<c:if test="${isConnected && sessionScope.isAdmin != null && sessionScope.isAdmin == true}" var="isAdmin"/>

<div id="header" class="ui inverted pointing menu">
	<a href="${pageContext.request.contextPath}/">
		<div class="borderless header item bar-text-huge">
			<span><i class="exchange icon"></i></span>
		</div>
		<div class="header item bar-text-big">
			<span>TrocBox</span>
		</div>
	</a>

	<c:if test="${isConnected == true}">
		<c:choose>
			<c:when test="${!isAdmin}">
				<a data-menu="items" href="${pageContext.request.contextPath}/items">
					<div class="${"items" == currentPage ? "active " : ""}item">
						<span>Browse Items</span>
					</div>
				</a>

				<a data-menu="my-items" href="${pageContext.request.contextPath}/user/items">
					<div class="${"user-items" == currentPage ? "active " : ""}item">
						<span>My Items</span>
					</div>
				</a>

				<a data-menu="my-loans" href="${pageContext.request.contextPath}/user/loans">
					<div class="${"user-loans" == currentPage ? "active " : ""}item">
						<span>My Loans</span>
					</div>
				</a>
			</c:when>
			<c:otherwise>
				<a data-menu="admin-users" href="${pageContext.request.contextPath}/admin/users">
					<div class="${"admin-users" == currentPage ? "active " : ""}item">
						<span style="color:#FF3333"><i class="setting icon"></i> Users</span>
					</div>
				</a>

				<a data-menu="admin-items" href="${pageContext.request.contextPath}/admin/items">
					<div class="${"admin-items" == currentPage ? "active " : ""}item">
						<span style="color:#FF3333"><i class="setting icon"></i> Items</span>
					</div>
				</a>

				<a data-menu="admin-loans" href="${pageContext.request.contextPath}/admin/loans">
					<div class="${"admin-loans" == currentPage ? "active " : ""}item">
						<span style="color:#FF3333"><i class="setting icon"></i> Loans</span>
					</div>
				</a>
			</c:otherwise>
		</c:choose>
	</c:if>

	<div class="right menu">
		<div class="item bar-text-medium">
			<span style="font-style: italic"><c:out value="${title}"/></span>
		</div>
		<c:choose>
			<c:when test="${!isConnected}">
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
						<a class="ui primary button" href="${pageContext.request.contextPath}/auth/register">Register</a>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<div class="item bar-text-small">
					<span>Logged in as <c:out value="${user.name}"/></span>
				</div>
				<div class="item button-item">
					<a class="ui button" href="${pageContext.request.contextPath}/auth/logout">Logout</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div id="content" class="ui page grid">
	<c:if test="${sessionScope.error != null}">
		<div id="error" class="ui negative message">
			<h2 class="header">
				Error <c:out value="${error}"/>
			</h2>

			<p>
				<c:out value="${error_msg}"/>
			</p>
		</div>
		<c:remove var="error"/>
		<c:remove var="error_msg"/>
	</c:if>
	<c:if test="${sessionScope.warning_msg != null}">
		<div id="warning" class="ui warning message">
			<h2 class="header">
				Warning:
			</h2>

			<p>
				<c:out value="${warning_msg}"/>
			</p>
		</div>
			<c:remove var="success_msg"/>
	</c:if>
	<c:if test="${sessionScope.success_msg != null}">
		<div id="success" class="ui positive message">
			<h2 class="header">
				Success!
			</h2>

			<p>
				<c:out value="${success_msg}"/>
			</p>
		</div>
		<c:remove var="success_msg"/>
	</c:if>
