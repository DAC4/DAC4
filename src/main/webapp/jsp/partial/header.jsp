<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div id="header">
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

	<h1>Header</h1>
</div>
