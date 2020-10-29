<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Thank You!</title>
</head>
<body>
	<%
		HttpSession httpsession = request.getSession();
		httpsession.invalidate();
		response.sendRedirect("Thankyou.html");
	%>
</body>
</html>