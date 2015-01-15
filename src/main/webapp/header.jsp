<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
</head>
<body>
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="controleurGestionCompte">ACL</a></li>
                    <li><a href="controleurGestionNav?action=listeCentres">Centres de loisirs</a></li>
                    <li><a href="controleurGestionNav?action=listeActivites">Activites</a></li>
                    <c:if test="${not empty utilisateur}"><li><a href="controleurGestionCompte?action=tableauBord">Tableau de bord</a></li></c:if>
                    <c:if test="${not empty utilisateur}"><li><a href="controleurGestionCompte?action=effectuerDeconnexion">Déconnexion</a></li></c:if>
                </ul>
            </div>
        </div>
    </div>
