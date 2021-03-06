<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="pairs" type="java.util.Iterator"--%>
<%--@elvariable id="pair" type="imag.dac4.util.pairlist.Pair"--%>
<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>
<%--@elvariable id="u" type="imag.dac4.model.user.User"--%>

<c:set var="title" value="Admin - Items List"/>
<c:set var="currentPage" value="admin-items"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">

		<h1 class="ui block header">Items List</h1>

		<table class="ui striped celled table">
			<thead>
				<tr>
					<th>Image</th>
					<th>Name</th>
					<th>Description</th>
					<th>Owner</th>
					<th>Available</th>
					<th>Locker Number</th>
					<th>Max Loan Duration</th>
					<th>Approved</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pair" items="${pairs}">
					<c:set var="item" value="${pair.key}"/>
					<c:set var="u" value="${pair.value}"/>
					<tr data-item-name="${item.name}">
						<td style="padding:0" class="collapsing">
							<c:choose>
								<c:when test="${item.imagePath == null}">
									<img src="${pageContext.request.contextPath}/static/img/default.png" width="64" height="64"/>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}${item.imagePath}" width="64" height="64"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:out value="${item.name}"/>
						</td>
						<td>
							<c:out value="${item.description}"/>
						</td>
						<td class="right aligned collapsing">
							<c:out value="${u.login}"/>
						</td>
						<c:choose>
							<c:when test="${item.available}">
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
							<c:out value="${item.lockerNum}"/>
						</td>
						<td class="right aligned collapsing">
							<c:out value="${item.maxLoanDuration}"/>
						</td>
						<c:choose>
							<c:when test="${item.approved}">
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
								<c:when test="${!item.approved}">
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/item/approve" method="POST">
										<input type="hidden" name="id" value="${item.id}"/>
										<input type="submit" value="Approve" class="ui orange button"/>
									</form>
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/item/remove" method="POST">
										<input type="hidden" name="id" value="${item.id}"/>
										<input type="submit" value="Reject" class="ui red button"/>
									</form>
								</c:when>
								<c:otherwise>
									<form class="inline-form" action="${pageContext.request.contextPath}/admin/item/remove" method="POST">
										<input type="hidden" name="id" value="${item.id}"/>
										<input type="submit" value="Remove" class="ui ${item.available ? "" : "disabled "}red button"/>
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
