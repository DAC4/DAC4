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
						<%--TODO: this doesn't work. How :( --%>
						<c:set var="item" value="${itemDao.read(loan.itemId)}" scope="request" />
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
									<td>
										<c:out value="${loan.startDate}"/>
									</td>
									<td>
										<c:out value="${loan.startDate + item.maxLoanDuration}" />
									</td>
									<td class="collapsing">
										<a href="${pageContext.request.contextPath}/
										<a href="${pageContext.request.contextPath}/loan?id=${loan.id}">
											<button type="button" class="ui button">Details</button>
										</a>
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
