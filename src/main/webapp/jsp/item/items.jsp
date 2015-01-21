<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="items" type="java.util.List"--%>
<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>

<c:set var="title" value="Items List"/>
<c:set var="currentPage" value="items"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Items List</h1>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Image</th>
						<th>Name</th>
						<th>Available</th>
						<c:if test="${isAdmin}">
							<th>Approved</th>
						</c:if>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${items}">
						<c:if test="${item.approved || isAdmin}">
							<a href="${pageContext.request.contextPath}/item?id=${item.id}">
								<tr>
									<td class="collapsing">
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
									<c:if test="${isAdmin}">
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
									</c:if>
									<td class="collapsing">
										<a href="${pageContext.request.contextPath}/item?id=${item.id}">
											<button type="button" class="ui button">Details</button>
										</a>
									</td>
								</tr>
							</a>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<div class="ui page grid">
				<%
					final boolean isAdmin = session.getAttribute("isAdmin") != null ? (Boolean) session.getAttribute("isAdmin") : false;
					@SuppressWarnings("unchecked")
					final List<Item> items2 = (List<Item>) request.getAttribute("items");
					if (items2 != null) {
						for (Item item : items2) {
							if (item.isApproved() || isAdmin) {
				%>
				<div class="four wide column">
					<a href="${pageContext.request.contextPath}/item?id=<%= item.getId()%>">
						<div type="button" class="ui animated button">
							<div class="visible content">
								<div class="ui fluid image">
									<% if (item.getImagePath() == null) { %>
									<img src="${pageContext.request.contextPath}/static/img/default.png" class="ui medium rounded image"/>
									<% } else { %>
									<img src="${pageContext.request.contextPath}<%= item.getImagePath() %>" class="ui medium rounded image"/>
									<% } %>
								</div>
							</div>
							<div class="hidden content">
								<div class="header"><%= item.getName()%>
								</div>
								<% if (item.isAvailable()) { %>
								<span style="color:green"><i class="checkmark icon"></i> Available</span>
								<% } else { %>
								<span style="color:red"><i class="remove icon"></i> Not available</span>
								<% } %>
							</div>
						</div>
				</div>
				</a>
			</div>
			<% } %>
			<% } %>
			<% } %>
		</div>

		<c:if test="${isConnected}">
			<a href="${pageContext.request.contextPath}/item/register">
				<button type="button" class="ui primary button">Add Item</button>
			</a>
		</c:if>

	</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
