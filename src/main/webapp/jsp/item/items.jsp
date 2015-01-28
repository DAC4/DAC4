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

		<h1 class="ui block header">Items List</h1>

		<p>
			<a class="ui primary button" href="${pageContext.request.contextPath}/item/register">Add an Item</a>
		</p>

                        <div class="card" data-item-name="${item.name}">
                            <div class="dimmable image">
                                <div class="ui dimmer">
                                    <div class="content">
                                        <div class="center">
                                            <div class="ui inverted button">Borrow</div>
                                        </div>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/item?id=${item.id}">
                                <c:choose>
                                    <c:when test="${item.imagePath == null}">
                                        <img src="${pageContext.request.contextPath}/static/img/default.png" style="width:290px;height:290px" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}${item.imagePath}" style="width:290px;height:290px" />
                                    </c:otherwise>
                                </c:choose>
                                </a>
                            </div>
                            <div class="content">
                                <a class="header" href="${pageContext.request.contextPath}/item?id=${item.id}"><c:out value="${item.name}"/></a>
                                    <div class="meta">
                                        <span class="date"><c:out value="${item.description}"/></span>
                                    </div>
                            </div>
                            <div class="extra content">
                                <div class="collapsing">
                                    <a class="ui primary button" href="${pageContext.request.contextPath}/item?id=${item.id}">Details</a>
                                    <form class="inline-form" action="${pageContext.request.contextPath}/item/borrow" method="POST">
                                        <input type="hidden" name="id" value="${item.id}"/>
                                        <c:choose>
                                            <c:when test="${item.available}">
                                                <input type="submit" value="Borrow" class="ui positive button"/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="submit" value="Borrow" class="ui disabled button"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </div>
                            </div>
                        </div>

					<div class="card" data-item-name="${item.name}">
						<div class="dimmable image">
							<div class="ui dimmer">
								<div class="content">
									<div class="center">
										<div class="ui inverted button">Borrow</div>
									</div>
								</div>
							</div>
							<c:choose>
								<c:when test="${item.imagePath == null}">
									<img src="${pageContext.request.contextPath}/static/img/default.png" style="width:290px;height:290px"/>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}${item.imagePath}" style="width:290px;height:290px"/>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="content">
							<a class="header" href="${pageContext.request.contextPath}/item?id=${item.id}"><c:out value="${item.name}"/></a>

							<div class="meta">
								<span class="date"><c:out value="${item.description}"/></span>
							</div>
						</div>
						<div class="extra content">
							<a>
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
							</a>
						</div>
					</div>

				</c:if>
			</c:forEach>
		</div>

	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
