<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
%>

<h1>글삭제</h1>
	<form method="post" action="/poll/board/deleteBoardAction.jsp">
		<input type="hidden" name="num" value="<%=num%>">
		<table class="table table-hover">
			<tr>
				<td>pass</td>
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button class="btn btn-outline-primary" type="submit">삭제하기</button>
</body>
</html>