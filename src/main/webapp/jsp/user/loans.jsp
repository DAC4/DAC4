<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="loans" type="java.util.Iterator"--%>
<%--@elvariable id="pair" type="imag.dac4.util.pairlist.Pair"--%>
<%--@elvariable id="loan" type="imag.dac4.model.loan.Loan"--%>
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
					<c:forEach var="pair" items="${loans}">
						<c:set var="loan" value="${pair.key}"/>
						<c:set var="item" value="${pair.value}"/>
						<c:if test="${!loan.returned}">
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
									<c:out value="${loan.startDateAsString}"/>
								</td>
								<td class="${loan.shouldHaveBeenReturned(item.maxLoanDuration) ? "negative" : "positive"}">
									<c:out value="${loan.getMaxEndDateAsString(item.maxLoanDuration)}"/>
								</td>
								<td class="collapsing">
									<a class="ui button" href="${pageContext.request.contextPath}/loan?id=${loan.id}">Details</a>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
