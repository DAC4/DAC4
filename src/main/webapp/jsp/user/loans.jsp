<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="loans" type="java.util.List"--%>
<%--@elvariable id="loan" type="imag.dac4.model.loan.Loan"--%>
<%--@elvariable id="itemDao" type="imag.dac4.model.item.ItemDao"--%>
<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>

<c:set var="title" value="My Loans"/>
<c:set var="currentPage" value="user-loans"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">My Loans</h1>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Image</th>
						<th>Name</th>
						<th>Borrowed on</th>
						<th>Must return before</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="loan" items="${loans}">
						<c:set var="item" value="${itemDao.read(loan.itemId)}" />
							<a href="${pageContext.request.contextPath}/loan?id=${loan.id}">
								<tr>
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
									<td class="collapsing">
										<a href="${pageContext.request.contextPath}/item?id=${item.id}">
											<button type="button" class="ui button">Details</button>
										</a>
										<c:if test="${item.available}">
											<form class="inline-form" action="${pageContext.request.contextPath}/user/item/remove" method="POST">
												<input type="hidden" name="itemId" value="${item.id}"/>
												<input type="submit" value="Delete" class="ui red button"/>
											</form>
										</c:if>
									</td>
								</tr>
							</a>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
