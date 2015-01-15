<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Index</title>
    </head>
    <body>
        <div class="container" role="main">
            <div class="page-header">
                <h1>Bienvenue sur l'application TrocBox</h1>
            </div>

            <hr>

            <%
                final Integer error = (Integer) request.getAttribute("error");
                if (error != null) {
                    final String errorMessage = (String) request.getAttribute("error_msg");
            %>
            <p style="color:red;font-weight:bold">
                Error <%= error%>: <%= errorMessage%>
            </p>

            <hr>
            <%
                }
            %>
            <form role="form" action="${pageContext.request.contextPath}/auth/login">
                <input type="hidden" name="action" value="effectuerConnexion" />
                <div class="form-group">
                    <label for="login">Identifiant</label>
                    <input id="login" type="text" class="form-control" placeholder="Login" name="login" required/>
                </div>
                <div class="form-group">
                    <label for="pass">Mot de passe</label>
                    <input id="password" type="password" class="form-control" placeholder="password" name="password" required/>
                </div>
                <button type="submit" class="btn btn-default"> Login </button>
            </form>
            <br />
            <form action=href="${pageContext.request.contextPath}/auth/register">
                <button type="submit" class="btn btn-default">Register</button>
            </form>
        </div>
    </body>
</html>
