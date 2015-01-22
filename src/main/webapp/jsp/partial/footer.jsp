<%@page contentType="text/html" pageEncoding="UTF-8" %>
</div>

<%--@elvariable id="user" type="imag.dac4.model.user.User"--%>
<%--@elvariable id="isConnected" type="java.lang.Boolean"--%>
<%--@elvariable id="isAdmin" type="java.lang.Boolean"--%>

<div id="footer" class="ui inverted menu">
	<c:if test="${isConnected && !isAdmin}">
		<div class="item bar-text-medium">
			<span>Credits: <c:out value="${user.credits}"/> </span>
		</div>
	</c:if>
	<div class="right item bar-text-small">
		<a href="https://html5.validator.nu/?doc=http%3A%2F%2Fdac.ribesg.fr"><img src="${pageContext.request.contextPath}/static/img/HTML5.png"/></a>
		<span>All Rights Reserved © Copyright <a href="https://github.com/DAC4">DAC4 Team</a> 2014-2015</span>
	</div>
</div>
