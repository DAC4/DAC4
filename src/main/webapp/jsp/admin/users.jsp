<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="users" type="java.util.Iterator"--%>
<%--@elvariable id="pair" type="imag.dac4.util.pairlist.Pair"--%>
<%--@elvariable id="u" type="imag.dac4.model.user.User"--%>
<%--@elvariable id="removable" type="java.lang.Boolean"--%>

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
				<c:forEach var="pair" items="${users}">
					<c:set var="u" value="${pair.key}"/>
					<c:set var="removable" value="${pair.value}"/>
					<tr data-login="${u.login}">
						<td>
							<c:out value="${u.login}"/>
						</td>
						<td>
							<c:out value="${u.name}"/>
						</td>
						<td>
							<c:out value="${u.email}"/>
						</td>
						<td>
							<form class="credit-form inline-form" action="${pageContext.request.contextPath}/admin/user/update-credit" method="POST">
								<input type="hidden" name="id" value="${u.id}"/>

								<div class="ui input" style="max-width:85px">
									<input type="number" name="amount" value="${u.credits}" placeholder="${u.credits}" min="0"/>
								</div>
								<input type="submit" value="Save" class="ui submit button" style="height:36px"/>
							</form>
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
							<c:choose>
								<c:when test="${!u.approved}">
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/approve" method="POST">
										<input type="hidden" name="id" value="${u.id}"/>
										<input type="submit" value="Approve" class="ui green button"/>
									</form>
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/remove" method="POST">
										<input type="hidden" name="id" value="${u.id}"/>
										<input type="submit" value="Reject" class="ui red button"/>
									</form>
								</c:when>
								<c:otherwise>
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/user/remove" method="POST">
										<input type="hidden" name="id" value="${u.id}"/>
										<input type="submit" value="Remove" class="ui ${removable ? "" : "disabled "}red button"/>
									</form>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
