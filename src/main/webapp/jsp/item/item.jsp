<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>

<c:set var="title" value="Item Details"/>
<c:set var="currentPage" value="item"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Item Page</h1>

			<ul>
				<li>
					Image:
					<c:choose>
						<c:when test="${item.imagePath == null}">
							<img src="${pageContext.request.contextPath}/static/img/default.png" width="64" height="64"/>
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}${item.imagePath}" width="64" height="64"/>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					Name: ${item.name}
				</li>
				<li>
					Description: ${item.description}
				</li>
				<li>
					Locker Number: ${item.lockerNum}
				</li>
				<li>
					Max Loan Duration: ${item.maxLoanDuration}
				</li>
				<c:if test="${item.approved}">
					<li style="color:red">
						Approved: no
					</li>
				</c:if>
			</ul>

			<c:if test="${item.approved && item.available}">
				<form action="${pageContext.request.contextPath}/item/loan" method="POST">
					<input type="hidden" name="id" value="${item.id}"/>
					<input type="submit" class="ui submit button" value="Loan"/>
				</form>
			</c:if>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
