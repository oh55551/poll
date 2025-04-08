<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "model.*"%>
<%@ page import= "dto.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<h1>board one</h1>
	<form action="/poll/board/updateBoardAction.jsp" method="post">
	<table class="table table-striped">
		<tr>
			<td>num</td>
			<td><input type="text" name="num" value="<%=b.getNum()%>" readonly></td>
		</tr>
		<tr>
			<td>name</td>
			<td><input type="text" name="name" value="<%=b.getName()%>"></td>
		</tr>
		<tr>
			<td>subject</td>
			<td><input type="text" name="subject" value="<%=b.getSubject()%>"></td>
		</tr>
		<tr>
			<td>content</td>
			<td><input type="text" name="content" value="<%=b.getContent()%>"></td>
		</tr>
		<tr>
			<td>pos</td>
			<td><input type="text" name="pos" value="<%=b.getPos()%>"readonly></td>
		</tr>
		<tr>
			<td>ref</td>
			<td><input type="text" name="ref" value="<%=b.getRef()%>"readonly></td>
		</tr>
		<tr>
			<td>depth</td>
			<td><input type="text" name="depth" value="<%=b.getDepth()%>"readonly></td>
		</tr>
		<tr>
			<td>regdate</td>
			<td><input type="text" name="regdate" value="<%=b.getRegdate()%>"></td>
		</tr>
		<tr>
			<td>ip</td>
			<td><input type="text" name="ip" value="<%=b.getIp()%>"></td>
		</tr>
		<tr>
			<td>count</td>
			<td><input type="text" name="count" value="<%=b.getCount()%>"></td>
		</tr>
	</table>
		<button type="submit" class="btn btn-primary">수정</button>
	</form>
</body>
</html>