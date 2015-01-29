<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="lockers" type="java.util.List"--%>
<%--@elvariable id="locker" type="java.lang.Integer"--%>
<c:set var="title" value="Item Registration"/>
<c:set var="currentPage" value="item-register"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">

		<form class="ui form" method="POST" enctype="multipart/form-data"
		      action="${pageContext.request.contextPath}/item/register">
			<h1 class="ui dividing header">Item Registration</h1>

			<div class="field">
				<label for="name">Name:</label>
				<input id="name" type="text" placeholder="Name" name="name" required/>
			</div>
			<div class="field">
				<label for="description">Description:</label>
				<textarea id="description" placeholder="Description" name="description" rows="5" maxlength="1000" required></textarea>
			</div>
			<div class="field">
				<label for="image">Image:</label>
				<input id="image" type="file" name="image"/>
			</div>
			<div class="two fields">
				<div class="field">
					<label for="lockerNum">Locker Number:</label>
					<select class="ui dropdown" id="lockerNum" name="lockerNum" required>
						<option value="">Number</option>
						<c:forEach var="locker" items="${lockers}">
							<option value="${locker}">${locker}</option>
						</c:forEach>
					</select>
				</div>
				<div class="field">
					<label for="maxLoanDuration">Maximum Loan Duration:</label>
					<input id="maxLoanDuration" type="number" min="1" step="1" placeholder="10" name="maxLoanDuration" required/>
				</div>
			</div>
			<input type="submit" value="Register Item" class="ui primary submit button"/>
		</form>

	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
