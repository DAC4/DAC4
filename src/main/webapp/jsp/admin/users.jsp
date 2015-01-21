<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="users" type="java.util.List"--%>
<%--@elvariable id="u" type="imag.dac4.model.user.User"--%>

<c:set var="title" value="Admin - Users List"/>
<c:set var="currentPage" value="admin-users"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Users List</h1>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Login</th>
						<th>Name</th>
						<th>E-Mail</th>
						<th>Credits</th>
						<th>Approved</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${users}">
						<tr>
							<td>
								<c:out value="${u.login}"/>
							</td>
							<td>
								<c:out value="${u.name}"/>
							</td>
							<td>
								<c:out value="${u.email}"/>
							</td>
							<td class="right aligned">
								<c:out value="${u.credits}"/>
							</td>
							<c:choose>
								<c:when test="${u.approved}">
									<td class="positive collapsing">
										<span style="color:green"><i class="checkmark icon"></i> Yes</span>
									</td>
								</c:when>
								<c:otherwise>
									<td class="negative collapsing">
										<span style="color:red"><i class="remove icon"></i> No</span>
									</td>
								</c:otherwise>
							</c:choose>
							<td class="right aligned collapsing">
								<c:if test="${!u.approved}">
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/approve" method="POST">
										<input type="hidden" name="login" value="${u.login}"/>
										<input type="submit" value="Approve" class="ui orange button"/>
									</form>
								</c:if>
								<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/remove" method="POST">
									<input type="hidden" name="login" value="${u.login}"/>
									<input type="submit" value="Remove" class="ui disabled red button"/>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
