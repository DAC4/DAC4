<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Home"/>
<c:set var="currentPage" value="user-home"/>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../partial/head.jsp" %>
</head>
<body>
	<%@ include file="../partial/header.jsp" %>

	<div class="sixteen wide column">
		<div class="section">

			<h1 class="ui block header">User Home</h1>
                        

                        <div class="ui card">
                            <div class="image">
                                <img src="http://semantic-ui.com/images/avatar/large/elliot.jpg">
                            </div>
                            <div class="content">
                                <a class="header"><c:out value="${user.name}"/></a>
                                <div class="description">
                                    <ul>
                                        <li>
                                                Login: <c:out value="${user.login}"/>
                                        </li>
                                        <li>
                                                Email: <c:out value="${user.email}"/>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="extra content">
                                <a>
                                    <i class="user icon"></i>
                                    Credits: <c:out value="${user.credits}"/>
                                </a>
                            </div>
                        </div>

		</div>
	</div>

	<%@ include file="../partial/footer.jsp" %>
</body>
</html>
