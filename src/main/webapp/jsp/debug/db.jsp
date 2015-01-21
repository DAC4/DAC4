<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="users" type="java.util.List"--%>
<%--@elvariable id="u" type="imag.dac4.model.user.User"--%>
<%--@elvariable id="items" type="java.util.List"--%>
<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>
<%--@elvariable id="loans" type="java.util.List"--%>
<%--@elvariable id="loan" type="imag.dac4.model.loan.Loan"--%>

<c:set var="title" value="Debug - Database dump"/>
<c:set var="currentPage" value="db"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>

<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Users</h1>
			<table class="ui table">
				<thead>
					<tr>
						<th>Id</th>
						<th>Login</th>
						<th>Password (!)</th>
						<th>Name</th>
						<th>E-Mail</th>
						<th>Credits</th>
						<th>Registration Complete</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${users}">
						<tr>
							<td>
								<c:out value="${u.id}"/>
							</td>
							<td>
								<c:out value="${u.login}"/>
							</td>
							<td>
								<c:out value="${u.password}"/>
							</td>
							<td>
								<c:out value="${u.name}"/>
							</td>
							<td>
								<c:out value="${u.email}"/>
							</td>
							<td>
								<c:out value="${u.credits}"/>
							</td>
							<td>
								<c:out value="${u.approved}"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>

			<h1 class="ui block header">Items</h1>
			<table class="ui table">
				<thead>
					<tr>
						<th>Id</th>
						<th>Name</th>
						<th>Image ID</th>
						<th>Description</th>
						<th>Owner ID</th>
						<th>Availability</th>
						<th>Locker Number</th>
						<th>Maximum Loan Duration</th>
						<th>Accepted</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${items}">
						<tr>
							<td>
								<c:out value="${item.id}"/>
							</td>
							<td>
								<c:out value="${item.name}"/>
							</td>
							<td>
								<c:out value="${item.imagePath}"/>
							</td>
							<td>
								<c:out value="${item.description}"/>
							</td>
							<td>
								<c:out value="${item.ownerId}"/>
							</td>
							<td>
								<c:out value="${item.available}"/>
							</td>
							<td>
								<c:out value="${item.lockerNum}"/>
							</td>
							<td>
								<c:out value="${item.maxLoanDuration}"/>
							</td>
							<td>
								<c:out value="${item.approved}"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>

			<h1 class="ui block header">Loans</h1>
			<table class="ui table">
				<thead>
					<tr>
						<th>Id</th>
						<th>User ID</th>
						<th>Item ID</th>
						<th>Returned</th>
						<th>Start Date</th>
						<th>End Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="loan" items="${loans}">
						<tr>
							<td>
								<c:out value="${loan.id}"/>
							</td>
							<td>
								<c:out value="${loan.userId}"/>
							</td>
							<td>
								<c:out value="${loan.itemId}"/>
							</td>
							<td>
								<c:out value="${loan.returned}"/>
							</td>
							<td>
								<c:out value="${loan.startDate}"/>
							</td>
							<td>
								<c:out value="${loan.endDate}"/>
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
