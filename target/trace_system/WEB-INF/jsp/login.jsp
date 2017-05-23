<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String path = request.getContextPath();
	request.setAttribute("path",path);
%>
<title>Insert title here</title>
</head>
<body>
<form action="${path}/index.do">
username:<input type="text" name="username" />
password:<input type="text" name="password" />
<input type="submit" value="login"/>
</form>
</body>
</html>