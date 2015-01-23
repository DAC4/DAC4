<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="loans" type="java.util.Iterator"--%>
<%--@elvariable id="pair" type="imag.dac4.util.pairlist.Pair"--%>
<%--@elvariable id="loan" type="imag.dac4.model.loan.Loan"--%>
<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>
<%--@elvariable id="user" type="imag.dac4.model.user.User"--%>

<c:set var="title" value="Loans"/>
<c:set var="currentPage" value="admin-loans"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">

		<h1 class="ui block header">My Loans</h1>

		<table class="ui striped celled table">
			<thead>
				<tr>
					<th>Image</th>
					<th>Name</th>
					<th>Borrowed by</th>
					<th>Borrowed on</th>
					<th>Must return before</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pair" items="${loans}">
					<c:set var="loan" value="${pair.key}"/>
					<c:set var="item" value="${pair.value.key}"/>
					<c:set var="user" value="${pair.value.value}"/>
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
								<c:out value="${user.name}"/>
							</td>
							<td>
								<c:out value="${loan.startDateAsString}"/>
							</td>
							<c:choose>
								<c:when test="${loan.shouldHaveBeenReturned(item.maxLoanDuration)}">
									<c:set var="maxEndDateClass" value="negative"/>
								</c:when>
								<c:when test="${loan.shouldReturnTomorrow(item.maxLoanDuration)}">
									<c:set var="maxEndDateClass" value="warning"/>
								</c:when>
								<c:otherwise>
									<c:set var="maxEndDateClass" value="positive"/>
								</c:otherwise>
							</c:choose>
							<td class="${maxEndDateClass}">
								<c:out value="${loan.getMaxEndDateAsString(item.maxLoanDuration)}"/>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
