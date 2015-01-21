<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="imag.dac4.model.item.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setAttribute("title", "Items List");
	request.setAttribute("menu-current-page", "items");
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

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">Items List</h1>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Image</th>
						<th>Name</th>
						<th>Available</th>
						<% if (isAdmin) { %>
						<th>Approved</th>
						<% } %>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
						@SuppressWarnings("unchecked")
						final List<Item> items = (List<Item>) request.getAttribute("items");
						if (items != null) {
							for (Item item : items) {
								if (item.isApproved() || isAdmin) {
					%>
					<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
						<tr>
							<td class="collapsing">
								<% if (item.getImagePath() == null) { %>
								<img src="${pageContext.request.contextPath}/static/img/default.png" width="64" height="64"/>
								<% } else { %>
								<img src="${pageContext.request.contextPath}<%= item.getImagePath() %>" width="64" height="64"/>
								<% } %>
							</td>
							<td>
								<%= item.getName() %>
							</td>
							<% if (item.isAvailable()) { %>
							<td class="positive collapsing">
								<span style="color:green"><i class="checkmark icon"></i> Yes</span>
							</td>
							<% } else { %>
							<td class="negative collapsing">
								<span style="color:red"><i class="remove icon"></i> No</span>
							</td>
							<% } %>
							<% if (isAdmin) { %>
							<% if (item.isApproved()) { %>
							<td class="positive collapsing">
								<span style="color:green"><i class="checkmark icon"></i> Yes</span>
							</td>
							<% } else { %>
							<td class="negative collapsing">
								<span style="color:red"><i class="remove icon"></i> No</span>
							</td>
							<% } %>
							<% } %>
							<td class="collapsing">
								<a href="${pageContext.request.contextPath}/item?id=<%= item.getId() %>">
									<button type="button" class="ui button">Details</button>
								</a>
							</td>
						</tr>
					</a>
					<%
								}
							}
						}
					%>
				</tbody>
			</table>

                        <div class="ui page grid">
                            <%
                                @SuppressWarnings(  "unchecked")
                                final List<Item> items2 = (List<Item>) request.getAttribute("items");
                                if (items2 != null) {
                                    for (Item item : items2) {
                                        if (item.isApproved() || isAdmin) {
                            %>
                            <div class="four wide column">
                                <a href="${pageContext.request.contextPath}/item?id=<%= item.getId()%>">
                                    <% if (item.isAvailable()) { %>
                                    <button type="button" class="ui segment tertiary inverted green">
                                    <% } else { %>
                                    <button type="button" class="ui segment tertiary inverted red">
                                    <% } %>
                                        <button type="button" class="ui animated button">
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
                                                <div class="header"><%= item.getName()%></div>
                                                <% if (item.isAvailable()) { %>
                                                <span style="color:green"><i class="checkmark icon"></i> Available</span>
                                                <% } else { %>
                                                <span style="color:red"><i class="remove icon"></i> Not available</span>
                                                <% } %>
                                            </div>
                                        </button>        
                                    </button>
                                </a>
                            </div>
                            <% } %>
                            <% } %>
                            <% } %>
                        </div>

			<% if (isConnected) { %>
			<a href="${pageContext.request.contextPath}/item/register">
				<button type="button" class="ui primary button">Add Item</button>
			</a>
			<% } %>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
