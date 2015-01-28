<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--@elvariable id="item" type="imag.dac4.model.item.Item"--%>
<%--@elvariable id="owner" type="imag.dac4.model.user.User"--%>

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

                        <div class="ui card">
                            <div class="image">
                                <c:choose>
                                    <c:when test="${item.imagePath == null}">
                                        <img src="${pageContext.request.contextPath}/static/img/default.png" width="64" height="64"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}${item.imagePath}" width="64" height="64"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="content">
                                <a class="header"><c:out value="${item.name}"/></a>
                                <div class="meta">
                                    <span class="date"> Owner : <c:out value="${owner.name}"/></span>
                                </div>
                                <div class="description">
                                    <c:out value="${item.description}"/>
                                </div>
                            </div>
                            <div class="extra content">
                                <ul>
				<li>
					Locker Number: <c:out value="${item.lockerNum}"/>
				</li>
				<li>
					Max Loan Duration: <c:out value="${item.maxLoanDuration}"/>
				</li>
                                <c:choose>
                                    <c:when test="${item.available == true}">
                                        <li style="color:green">Approved: Yes</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li style="color:red">Approved: No</li>
                                    </c:otherwise>
                                </c:choose>
                                    
				<c:if test="${!item.approved}">
					<li style="color:red">
						Approved: No
					</li>
				</c:if>
                                </ul>
                            </div>
                        </div>
		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
