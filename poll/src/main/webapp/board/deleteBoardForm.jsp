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
		
	BoardDao boardDao = new BoardDao();
	Board b = new Board();
	b.setNum(num);
	
	boardDao.deleteBoard(b);	
	



	response.sendRedirect("/poll/board/boardList.jsp");	
%>
</body>
</html>