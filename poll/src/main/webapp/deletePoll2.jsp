<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
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
	//값 가져오기
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	//쿼리 실행
	QuestionDao questionDao = new QuestionDao();
	Question question=questionDao.deleteQuestionOne(qnum);
	
	ItemDao itemDao = new ItemDao();
	Item item=itemDao.deleteItemTwo(qnum);
	question=questionDao.deleteQuestionTwo(qnum);
	
	
		
		
	response.sendRedirect("/poll/pollList2.jsp");	
%>
</body>
</html>