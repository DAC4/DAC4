<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="${pageContext.request.contextPath}/">Liste des objets</a></li>
                    <li><a href="${pageContext.request.contextPath}/"></a>Mes emprunts</li>
                    <li><a href="${pageContext.request.contextPath}/">Déconnexion</a></li></c:if>
                </ul>
            </div>
        </div>
    </div>
