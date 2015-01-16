<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Item Registration");
	request.setAttribute("menu-current-page", "item-register");
%>

<!DOCTYPE html>
<html>
<head>
	<title>
		<%= request.getAttribute("title") %>
	</title>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="section">
		<form class="ui form" method="POST" action="${pageContext.request.contextPath}/item/register">
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
				<label for="lockerNum">Locker Number:</label>
				<input id="lockerNum" type="number" min="1" max="9" step="1" placeholder="1" name="lockerNum" required/>
			</div>
			<div class="field">
				<label for="maxLoanDuration">Maximum Loan Duration:</label>
				<input id="maxLoanDuration" type="number" min="1" step="1" placeholder="10" name="maxLoanDuration" required/>
			</div>
			<input type="submit" value="Register Item"/>
		</form>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
