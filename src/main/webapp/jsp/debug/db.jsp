<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="imag.dac4.model.loan.Loan" %>
<%@ page import="imag.dac4.model.user.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
	<title>Database dump</title>
	<style>
		#content, table {
			margin: 25px auto;
		}
	</style>
</head>

<body>
	<div id="content">

		<h1>Users</h1>
		<table>
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
				<%
					@SuppressWarnings("unchecked")
					List<User> users = (List<User>) request.getAttribute("users");
					if (users != null) {
						for (User user : users) {
				%>
				<tr>
					<td>
						<%= user.getId()%>
					</td>
					<td>
						<%= user.getLogin() %>
					</td>
					<td>
						<%= user.getPassword() %>
					</td>
					<td>
						<%= user.getName() %>
					</td>
					<td>
						<%= user.getEmail() %>
					</td>
					<td>
						<%= user.getCredits() %>
					</td>
					<td>
						<%= user.isRegistrationComplete() %>
					</td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>

		<hr>

		<h1>Items</h1>
		<table>
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
				<%
					@SuppressWarnings("unchecked")
					List<Item> items = (List<Item>) request.getAttribute("items");
					if (items != null) {
						for (Item item : items) {
				%>
				<tr>
					<td>
						<%= item.getId()%>
					</td>
					<td>
						<%= item.getName() %>
					</td>
					<td>
						<%= item.getImageId() %>
					</td>
					<td>
						<%= item.getDescription() %>
					</td>
					<td>
						<%= item.getOwnerId() %>
					</td>
					<td>
						<%= item.isAvailable() %>
					</td>
					<td>
						<%= item.getLockerNum() %>
					</td>
					<td>
						<%= item.getMaxLoanDuration() %>
					</td>
					<td>
						<%= item.isAccepted() %>
					</td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>

		<hr>

		<h1>Loans</h1>
		<table>
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
				<%
					@SuppressWarnings("unchecked")
					List<Loan> loans = (List<Loan>) request.getAttribute("loans");
					if (loans != null) {
						for (Loan loan : loans) {
				%>
				<tr>
					<td>
						<%= loan.getId()%>
					</td>
					<td>
						<%= loan.getUserId() %>
					</td>
					<td>
						<%= loan.getItemId() %>
					</td>
					<td>
						<%= loan.isReturned() %>
					</td>
					<td>
						<%= loan.getStartDate() %>
					</td>
					<td>
						<%= loan.getEndDate() %>
					</td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>

		<a href="${pageContext.request.contextPath}/">Home</a>
	</div>
</body>
</html>
