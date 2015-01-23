<%@page contentType="text/html" pageEncoding="UTF-8" %>
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

			<p>
				<a class="ui primary button" href="${pageContext.request.contextPath}/item/register">Add an Item</a>
			</p>

			<table class="ui striped celled table">
				<thead>
					<tr>
						<th>Image</th>
						<th>Name</th>
						<th>Available</th>
						<c:if test="${isAdmin}">
							<th>Approved</th>
						</c:if>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${items}">
						<c:if test="${item.approved || isAdmin}">
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
								<c:choose>
									<c:when test="${item.available}">
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
									<a class="ui button" href="${pageContext.request.contextPath}/item?id=${item.id}">Details</a>
									<c:if test="${item.available}">
										<form class="inline-form" action="${pageContext.request.contextPath}/item/borrow" method="POST">
											<input type="hidden" name="id" value="${item.id}"/>
											<input type="submit" value="Borrow" class="ui green button"/>
										</form>
									</c:if>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

		</div>

		<div class="section">

			<h2 class="ui block header">Testing future new interface...</h2>

			<div class="ui grid">
				<c:forEach var="item" items="${items}">
					<c:if test="${item.approved || isAdmin}">
						<div class="four wide column">
							<a href="${pageContext.request.contextPath}/item?id=${item.id}">
								<c:choose>
								<c:when test="${item.available}">
								<div class="ui positive message">
									</c:when>
									<c:otherwise>
									<div class="ui negative message">
										</c:otherwise>
										</c:choose>
										<div class="header">
											<c:out value="${item.name}"/>
										</div>
										<div class="ui fluid image">
											<c:choose>
												<c:when test="${item.imagePath == null}">
													<img src="${pageContext.request.contextPath}/static/img/default.png" class="ui medium rounded image"/>
												</c:when>
												<c:otherwise>
													<img src="${pageContext.request.contextPath}${item.imagePath}" class="ui medium rounded image"/>
												</c:otherwise>
											</c:choose>
										</div>
										<ul>
											<li>It's good to see you again.</li>
											<li>Did you know it's been a while?</li>
										</ul>

										<p>
											<!-- <c:choose>
                                                        <c:when test="${item.available}">
                                                            <span style="color:green"><i class="checkmark icon"></i> Available</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="color:red"><i class="remove icon"></i> Not available</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="${pageContext.request.contextPath}/item?id=${item.id}">
                                                            <button type="button" class="ui button">Details</button>
                                                    </a>-->

										<form class="inline-form" action="${pageContext.request.contextPath}/item/borrow" method="POST">
											<input type="hidden" name="id" value="${item.id}"/>
											<c:choose>
												<c:when test="${item.available}">
													<input type="submit" value="Borrow" class="fluid ui green button"/>
												</c:when>
												<c:otherwise>
													<input type="submit" value="Borrow" class="fluid ui disabled button"/>
												</c:otherwise>
											</c:choose>
										</form>
										</p>

									</div>
							</a>
						</div>

					</c:if>
				</c:forEach>
			</div>
		</div>

		<%@ include file="../partial/footer.jsp" %>
</body>
</html>
