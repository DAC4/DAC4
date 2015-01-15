<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div id="header">
	<div class="ui menu">
		<div class="item">
			<h1>DAC4</h1>
		</div>
		<div class="right menu">
			<form method="POST" action="${pageContext.request.contextPath}/auth/login">
				<div class="item">
					<input id="login" type="text" placeholder="Login" name="login" required/>
				</div>
				<div class="item">
					<input id="password" type="password" placeholder="password" name="password" required/>
				</div>
				<div class="item">
					<input class="ui submit primary button" type="submit" value="Login"/>
				</div>
			</form>
			<div class="item">
				<a class="ui primary button" href="${pageContext.request.contextPath}/auth/register">Register</a>
			</div>
		</div>
	</div>

	<h1>DAC4</h1>


	<br/>

</div>
