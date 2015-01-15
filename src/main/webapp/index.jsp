<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Index</title>
    </head>
    <body>
        <h1>Index</h1>

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

        <h2>Login</h2>

        <form action="${pageContext.request.contextPath}/auth/login" method="POST">
            <label for="login">Login:</label>
            <input id="login" type="text" placeholder="Login" name="login" required/>
            <label for="password">Password:</label>
            <input id="password" type="password" placeholder="password" name="password" required/>
            <input type="submit" value="Login"/>
        </form>

        <hr>

        <h2><a href="${pageContext.request.contextPath}/auth/register">Register</a></h2>
    </body>
</html>
