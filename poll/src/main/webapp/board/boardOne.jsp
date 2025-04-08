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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container mt-5">
    <div class="card p-4 shadow-sm">
	<h1>board one</h1>
	 <table class="table table-bordered">
		<tr>
			<td>num</td>
			<td><%=b.getNum() %></td>
		</tr>
		<tr>
			<td>name</td>
			<td><%=b.getName() %></td>
		</tr>
		<tr>
			<td>subject</td>
			<td><%=b.getSubject() %></td>
		</tr>
		<tr>
			<td>content</td>
			<td><%=b.getContent() %></td>
		</tr>
		<tr>
			<td>pos</td>
			<td><%=b.getPos() %></td>
		</tr>
		<tr>
			<td>ref</td>
			<td><%=b.getRef() %></td>
		</tr>
		<tr>
			<td>depth</td>
			<td><%=b.getDepth() %></td>
		</tr>
		<tr>
			<td>regdate</td>
			<td><%=b.getRegdate() %></td>
		</tr>
		<tr>
			<td>ip</td>
			<td><%=b.getIp() %></td>
		</tr>
		<tr>
			<td>count</td>
			<td><%=b.getCount() %></td>
		</tr>
	</table>
	<a href="/poll/board/updateBoardForm.jsp?num=<%=b.getNum()%>" class="btn btn-primary">수정</a>
	<a href="/poll/board/deleteBoardForm.jsp?num=<%=b.getNum()%>" class="btn btn-danger">삭제</a>
	<a href="/poll/board/insertBoardReplyForm.jsp?ref=<%=b.getRef()%>&pos=<%=b.getPos()%>&depth=<%=b.getDepth()%>" class="btn btn-secondary">답글달기</a>
	</div>
	</div>
</body>
</html>